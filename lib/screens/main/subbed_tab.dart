import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SubbedTab extends StatefulWidget {
  const SubbedTab({Key key}) : super(key: key);

  @override
  _SubbedTabState createState() => _SubbedTabState();
}

class _SubbedTabState extends State<SubbedTab>
    with AutomaticKeepAliveClientMixin {
  final _contextCompleter = Completer<BuildContext>();

  @override
  void initState() {
    super.initState();

    _contextCompleter.future.then((context) =>
        StoreProvider.of<ReddigramState>(context)
            .dispatch(fetchSuggestedSubscriptions()));
  }

  void _subscribe(BuildContext context, void Function(String) callback) async {
    StoreProvider.of<ReddigramState>(context).dispatch(ClearSearch());
    final subreddit = await showSearch<String>(
      context: context,
      delegate: SearchSubredditsDelegate(),
    );

    if (subreddit != null && subreddit.isNotEmpty) {
      callback(subreddit);
    }
  }

  void _unsubscribe(
      BuildContext context, String subreddit, VoidCallback callback) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unsubscribing'),
          content: Text('Do you really want to unsubscribe from r/$subreddit?'),
          actions: [
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: const Text('UNSUBSCRIBE'),
              onPressed: () {
                Navigator.of(context).pop();
                callback();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!_contextCompleter.isCompleted) {
      _contextCompleter.complete(context);
    }

    return StoreConnector<ReddigramState, _SubredditsViewModel>(
      converter: (store) => _SubredditsViewModel.fromStore(store),
      builder: (context, vm) => ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.body1.color,
              ),
            ),
            title: const Text(
              'Explore subreddits',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => _subscribe(context, vm.subscribe),
          ),
          if (vm.subreddits.isEmpty)
            const ListTile(
              leading: SizedBox(),
              title: Text(
                'No subreddits. Subscribe to some!',
              ),
            ),
          ...vm.subreddits
              .map((subredditName) => StoreConnector<ReddigramState, Subreddit>(
                    key: Key(subredditName),
                    converter: (store) =>
                        store.state.subreddits[subredditName] ??
                        Subreddit((b) => b..name = subredditName),
                    builder: (context, subreddit) => SubredditListTile(
                      subreddit: subreddit,
                      onTap: () => Navigator.push(
                          context, SubredditScreen.route(subredditName)),
                      trailingIcon: const Icon(Icons.remove),
                      onTrailingTap: () => _unsubscribe(context, subredditName,
                          () => vm.unsubscribe(subredditName)),
                    ),
                  ))
              .toList(),
          _buildSuggestions(context),
        ],
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context) {
    return StoreConnector<ReddigramState, _SubredditsViewModel>(
      converter: (store) => _SubredditsViewModel.fromStoreSuggested(store),
      builder: (context, vm) {
        return Column(
          children: [
            const SizedBox(height: 32.0),
            const ListTile(
              leading: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.add_circle),
              ),
              title: Text('Here are some suggestions:'),
            ),
            ...vm.subreddits
                .map((subredditId) => StoreConnector<ReddigramState, Subreddit>(
                      key: Key('suggestion_$subredditId'),
                      converter: (store) => store.state.subreddits.values
                          .firstWhere((sub) => sub.id == subredditId,
                              orElse: () => null),
                      builder: (context, subreddit) => subreddit != null
                          ? SubredditListTile(
                              subreddit: subreddit,
                              onTap: () => Navigator.push(
                                context,
                                SubredditScreen.route(subreddit.name),
                              ),
                              trailingIcon: Icon(Icons.add),
                              onTrailingTap: () => vm.subscribe(subreddit.name),
                            )
                          : SizedBox(),
                    ))
                .toList(),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SubredditsViewModel {
  final List<String> subreddits;
  final void Function(String) subscribe;
  final void Function(String) unsubscribe;

  _SubredditsViewModel(
      {@required this.subreddits,
      @required this.subscribe,
      @required this.unsubscribe})
      : assert(subreddits != null),
        assert(subscribe != null),
        assert(unsubscribe != null);

  factory _SubredditsViewModel.fromStore(Store<ReddigramState> store) {
    return _SubredditsViewModel(
      subreddits: store.state.subscriptions.toList(),
      subscribe: (subreddit) => store.dispatch(subscribeSubreddit(subreddit)),
      unsubscribe: (subreddit) =>
          store.dispatch(unsubscribeSubreddit(subreddit)),
    );
  }

  factory _SubredditsViewModel.fromStoreSuggested(Store<ReddigramState> store) {
    return _SubredditsViewModel(
      subreddits: store.state.suggestedSubscriptions.toList(),
      subscribe: (subreddit) => store.dispatch(subscribeSubreddit(subreddit)),
      unsubscribe: (subreddit) =>
          store.dispatch(unsubscribeSubreddit(subreddit)),
    );
  }
}
