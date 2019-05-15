import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
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
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                  child: Icon(
                    Icons.add,
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                ),
                title: const Text(
                  'Subscribe to subreddit',
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
                  .map((subreddit) => ListTile(
                        leading: const CircleAvatar(),
                        title: Text('r/$subreddit'),
                        contentPadding: const EdgeInsets.only(left: 16.0),
                        trailing: InkWell(
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Icon(Icons.remove),
                          ),
                          onTap: () => _unsubscribe(context, subreddit,
                              () => vm.unsubscribe(subreddit)),
                        ),
                        onTap: () => Navigator.push(
                            context, SubredditScreen.route(context, subreddit)),
                      ))
                  .toList(),
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
