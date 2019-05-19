import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SubbedTab extends StatelessWidget {
  const SubbedTab({Key key}) : super(key: key);

  void _subscribe(BuildContext context, void Function(String) callback) async {
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
                  title: Text('No subreddits'),
                  dense: true,
                ),
              ...vm.subreddits
                  .map((subredditName) => StoreConnector<ReddigramState, Feed>(
                        converter: (store) =>
                            store.state.feeds['r/$subredditName'] ??
                            Feed.blank(subredditName),
                        builder: (context, subreddit) => SubredditListTile(
                              subreddit: subreddit,
                              onTap: () => Navigator.push(
                                  context,
                                  SubredditScreen.route(
                                    context,
                                    subredditName,
                                  )),
                              trailingIcon: const Icon(Icons.remove),
                              onTrailingTap: () => _unsubscribe(
                                  context,
                                  subredditName,
                                  () => vm.unsubscribe(subredditName)),
                            ),
                      ))
                  .toList()
            ],
          ),
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
      subscribe: (subreddit) => store.dispatch(subscribeSubreddit(subreddit)),
      unsubscribe: (subreddit) =>
          store.dispatch(unsubscribeSubreddit(subreddit)),
    );
  }
}
