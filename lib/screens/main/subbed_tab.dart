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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _SubscriptionsView(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SubscriptionsView extends StatelessWidget {
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
    final divider = const SizedBox(height: 32.0);

    return StoreConnector<ReddigramState, _SubredditsViewModel>(
      converter: (store) => _SubredditsViewModel.fromStore(store),
      builder: (context, vm) => Column(
        children: [
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.body1.color,
              ),
            ),
            title: Text(
              'Search subreddits',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          divider,
          ListTile(
            title: const Text(
              'Subscriptions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (vm.subreddits.isEmpty)
            const ListTile(
              leading: SizedBox(),
              title: Text(
                'No subreddits. Subscribe to some!',
              ),
            ),
          ...vm.subreddits
              .map((subredditId) => StoreConnector<ReddigramState, Subreddit>(
                    key: Key(subredditId),
                    converter: (store) => store.state.subreddits[subredditId],
                    builder: (context, subreddit) => subreddit != null
                        ? SubredditListTile(
                            subreddit: subreddit,
                            subscribed: true,
                            onTap: () => Navigator.push(
                                context, SubredditScreen.route(subreddit.id)),
                            onUnsubscribe: () => _unsubscribe(
                              context,
                              subreddit.name,
                              () => vm.unsubscribe(subreddit.id),
                            ),
                          )
                        : SizedBox(),
                  ))
              .toList(),
          divider,
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
            const ListTile(
              title: Text(
                'You may also like',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (vm.subreddits.isEmpty)
              const ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.sentiment_dissatisfied),
                ),
                title: Text('No suggestions available'),
              ),
            ...vm.subreddits
                .map((subredditId) => StoreConnector<ReddigramState, Subreddit>(
                      key: Key('suggestion_$subredditId'),
                      converter: (store) => store.state.subreddits[subredditId],
                      builder: (context, subreddit) => subreddit != null
                          ? SubredditListTile(
                              subreddit: subreddit,
                              subscribed: false,
                              onTap: () => Navigator.push(
                                context,
                                SubredditScreen.route(subreddit.id),
                              ),
                              onSubscribe: () => vm.subscribe(subredditId),
                            )
                          : const SizedBox(),
                    ))
                .toList(),
          ],
        );
      },
    );
  }
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
      subscribe: (subredditId) =>
          store.dispatch(subscribeSubreddit(subredditId)),
      unsubscribe: (subredditId) =>
          store.dispatch(unsubscribeSubreddit(subredditId)),
    );
  }

  factory _SubredditsViewModel.fromStoreSuggested(Store<ReddigramState> store) {
    return _SubredditsViewModel(
      subreddits: store.state.suggestedSubscriptions
          .where(
              (suggestion) => !store.state.subscriptions.contains(suggestion))
          .toList(),
      subscribe: (subredditId) =>
          store.dispatch(subscribeSubreddit(subredditId)),
      unsubscribe: (subredditId) =>
          store.dispatch(unsubscribeSubreddit(subredditId)),
    );
  }
}
