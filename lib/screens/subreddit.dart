import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SubredditScreen extends StatelessWidget {
  final String subredditName;

  const SubredditScreen({Key key, this.subredditName}) : super(key: key);

  bool _subredditLoaded(Store<ReddigramState> store) =>
      store.state.subredditFeeds[subredditName] != null;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReddigramState, bool>(
      onInit: (store) {
        if (!_subredditLoaded(store)) {
          store.dispatch(fetchFreshSubreddit(subredditName));
        }
      },
      converter: (store) => _subredditLoaded(store),
      builder: (context, loaded) => DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: _buildAppBar(context),
              body: !loaded
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildGrid(context),
                        _buildList(context),
                      ],
                    ),
            ),
          ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final primaryColor = Theme.of(context).buttonTheme.colorScheme.primary;
    final onPrimaryColor = Theme.of(context).buttonTheme.colorScheme.onPrimary;
    final backgroundColor =
        Theme.of(context).buttonTheme.colorScheme.background;
    final onBackgroundColor =
        Theme.of(context).buttonTheme.colorScheme.onBackground;

    return AppBar(
      title: Text('r/$subredditName'),
      bottom: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.grid_on)),
          Tab(icon: Icon(Icons.list)),
        ],
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 16.0),
          child: StoreConnector<ReddigramState, _SubscribeViewModel>(
            converter: (store) =>
                _SubscribeViewModel.fromStore(store, subredditName),
            builder: (context, vm) => vm.subscribed
                ? FlatButton(
                    onPressed: vm.unsubscribe,
                    child: Text(
                      'Unsubscribe'.toUpperCase(),
                      style: TextStyle(color: onBackgroundColor),
                    ),
                    color: backgroundColor,
                  )
                : FlatButton.icon(
                    onPressed: vm.subscribe,
                    icon: Icon(Icons.add, color: onPrimaryColor),
                    label: Text(
                      'Subscribe'.toUpperCase(),
                      style: TextStyle(color: onPrimaryColor),
                    ),
                    color: primaryColor,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(BuildContext context) {
    return StoreConnector<ReddigramState, _SubredditViewModel>(
      converter: (store) => _SubredditViewModel.fromStore(store, subredditName),
      builder: (context, vm) => InfiniteList(
            fetchMore: vm.fetchMore,
            keepAlive: true,
            itemCount: 2,
            itemBuilder: (context, i) => [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: vm.subreddit.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: PhotoGridItem(
                              photo: vm.subreddit[i],
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoPreviewScreen(
                                          photo: vm.subreddit[i]),
                                    ));
                              },
                            ),
                          ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                ][i],
          ),
    );
  }

  Widget _buildList(BuildContext context) {
    return StoreConnector<ReddigramState, _SubredditViewModel>(
      converter: (store) => _SubredditViewModel.fromStore(store, subredditName),
      builder: (context, vm) => InfiniteList(
            fetchMore: vm.fetchMore,
            keepAlive: true,
            itemCount: vm.subreddit.length + 1,
            itemBuilder: (context, i) {
              if (i == vm.subreddit.length) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }

              return StoreConnector<ReddigramState, _PhotoViewModel>(
                converter: (store) =>
                    _PhotoViewModel.fromStore(store, subredditName, i),
                builder: (context, vm) => PhotoListItem(
                      photo: vm.photo,
                      onUpvote: vm.onUpvote,
                      onUpvoteCanceled: vm.onUpvoteCanceled,
                      showNsfw: true,
                    ),
              );
            },
          ),
    );
  }
}

class _SubredditViewModel {
  final List<Photo> subreddit;
  final void Function(Completer) fetchMore;

  _SubredditViewModel({@required this.subreddit, @required this.fetchMore})
      : assert(fetchMore != null);

  factory _SubredditViewModel.fromStore(
      Store<ReddigramState> store, String subredditName) {
    return _SubredditViewModel(
      subreddit: store.state.subredditFeeds[subredditName].toList(),
      fetchMore: (completer) =>
          store.dispatch(fetchMoreSubreddit(subredditName, completer)),
    );
  }
}

class _SubscribeViewModel {
  final bool subscribed;
  final VoidCallback subscribe;
  final VoidCallback unsubscribe;

  _SubscribeViewModel(
      {@required this.subscribed,
      @required this.subscribe,
      @required this.unsubscribe})
      : assert(subscribed != null),
        assert(subscribe != null),
        assert(unsubscribe != null);

  factory _SubscribeViewModel.fromStore(
      Store<ReddigramState> store, String subredditName) {
    return _SubscribeViewModel(
      subscribed: store.state.subscriptions.contains(subredditName),
      subscribe: () => store.dispatch(subscribeSubreddit(subredditName)),
      unsubscribe: () => store.dispatch(unsubscribeSubreddit(subredditName)),
    );
  }
}

class _PhotoViewModel {
  final Photo photo;
  final VoidCallback onUpvote;
  final VoidCallback onUpvoteCanceled;

  _PhotoViewModel(
      {@required this.photo,
      @required this.onUpvote,
      @required this.onUpvoteCanceled})
      : assert(photo != null);

  factory _PhotoViewModel.fromStore(
      Store<ReddigramState> store, String subredditName, int index) {
    final photo = store.state.subredditFeeds[subredditName][index];

    return _PhotoViewModel(
      photo: photo,
      onUpvote: store.state.authState.authenticated
          ? () => store.dispatch(upvote(photo))
          : null,
      onUpvoteCanceled: store.state.authState.authenticated
          ? () => store.dispatch(cancelUpvote(photo))
          : null,
    );
  }
}
