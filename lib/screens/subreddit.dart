import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SubredditScreen extends StatefulWidget {
  static PageRoute route(String subredditName) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: 'SubredditScreen'),
      builder: (context) => SubredditScreen(subredditName: subredditName),
    );
  }

  final String subredditName;

  const SubredditScreen({Key key, this.subredditName}) : super(key: key);

  @override
  _SubredditScreenState createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen> {
  final _shownNsfwIds = Set<String>();
  final _columnListKey = GlobalKey<InfiniteListState>();

  bool _subredditLoaded(Store<ReddigramState> store) =>
      store.state.feeds['r/${widget.subredditName}'] != null;

  bool _nsfwPhotoShown(
          BuildContext context, _SubredditViewModel vm, Photo photo) =>
      vm.subreddit.nsfw ||
      _shownNsfwIds.contains(photo.id) ||
      PreferencesProvider.of(context).showNsfw;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReddigramState, void>(
      onInit: (store) {
        if (!_subredditLoaded(store)) {
          store
              .dispatch(fetchFreshFeed('r/${widget.subredditName}', limit: 99));
        }
      },
      converter: (store) => null,
      builder: (context, _) => DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: _buildAppBar(context),
              body: TabBarView(
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
      title: StoreConnector<ReddigramState, Subreddit>(
        // fixme: this definitely should have this subreddit info stuff
        converter: (store) =>
            store.state.subreddits['r/${widget.subredditName}'] ??
            Subreddit((b) => b..name = widget.subredditName),
        builder: (context, subreddit) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (subreddit.nsfw) const NsfwBadge(),
                Expanded(
                  child: Text(
                    'r/${widget.subredditName}',
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
      ),
      bottom: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.apps)),
          Tab(icon: Icon(Icons.view_list)),
        ],
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 16.0),
          child: StoreConnector<ReddigramState, _SubscribeViewModel>(
            converter: (store) =>
                _SubscribeViewModel.fromStore(store, widget.subredditName),
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
    return StoreConnector<ReddigramState, bool>(
      converter: _subredditLoaded,
      builder: (context, loaded) => loaded
          ? StoreConnector<ReddigramState, _SubredditViewModel>(
              converter: (store) =>
                  _SubredditViewModel.fromStore(store, widget.subredditName),
              builder: (context, feedVm) => InfiniteList(
                    fetchMore: feedVm.fetchMore,
                    keepAlive: true,
                    itemCount: 2,
                    itemBuilder: (context, i) => [
                          GridView.builder(
                            padding: const EdgeInsets.all(2.0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: feedVm.photos.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, i) =>
                                _buildPhotoGridItem(context, feedVm, i),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 32.0),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                        ][i],
                  ),
            )
          : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, i) => PhotoGridItem.placeholder(),
            ),
    );
  }

  Widget _buildPhotoGridItem(
      BuildContext context, _SubredditViewModel vm, int photoIndex) {
    final photo = vm.photos[photoIndex];

    return PhotoGridItem(
      photo: photo,
      onTap: () async {
        final offset = photoIndex == 0
            ? 0.0
            : vm.photos
                .sublist(0, photoIndex)
                // 123 is the padding (2*8) + top and bottom bar height (51, 56)
                .map((photo) =>
                    PhotoListItem.calculateImageHeight(context, photo) + 123)
                .reduce((a, b) => a + b);

        DefaultTabController.of(context).animateTo(1);

        // Delay so that the column InfiniteList can get its state built
        while (true) {
          if (_columnListKey.currentState != null) {
            _columnListKey.currentState.scrollToOffset(offset);
            break;
          }

          await Future.delayed(Duration(milliseconds: 50));
        }
      },
      showNsfw: _nsfwPhotoShown(context, vm, photo),
      onShowNsfw: () => setState(() => _shownNsfwIds.add(photo.id)),
    );
  }

  Widget _buildList(BuildContext context) {
    return StoreConnector<ReddigramState, bool>(
      converter: _subredditLoaded,
      builder: (context, loaded) => loaded
          ? StoreConnector<ReddigramState, _SubredditViewModel>(
              converter: (store) =>
                  _SubredditViewModel.fromStore(store, widget.subredditName),
              builder: (context, feedVm) => InfiniteList(
                    key: _columnListKey,
                    fetchMore: feedVm.fetchMore,
                    keepAlive: true,
                    itemCount: feedVm.photos.length + 1,
                    itemBuilder: (context, i) {
                      if (i == feedVm.photos.length) {
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 32.0),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        );
                      }

                      return _buildPhotoListItem(context, feedVm, i);
                    },
                  ),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => PhotoListItem.placeholder(),
            ),
    );
  }

  Widget _buildPhotoListItem(
      BuildContext context, _SubredditViewModel feedVm, int photoIndex) {
    return StoreConnector<ReddigramState, _PhotoViewModel>(
      converter: (store) =>
          _PhotoViewModel.fromStore(store, widget.subredditName, photoIndex),
      builder: (context, vm) => PhotoListItem(
            photo: vm.photo,
            upvotingEnabled: vm.authenticated,
            onUpvote: vm.onUpvote,
            onUpvoteCanceled: vm.onUpvoteCanceled,
            showNsfw: _nsfwPhotoShown(context, feedVm, vm.photo),
            onShowNsfw: () => setState(() => _shownNsfwIds.add(vm.photo.id)),
            onPhotoTap: () =>
                Navigator.push(context, PhotoPreviewScreen.route(vm.photo)),
          ),
    );
  }
}

class _SubredditViewModel {
  final List<Photo> photos;
  final Feed feed;
  final Subreddit subreddit;
  final void Function(Completer) fetchMore;

  _SubredditViewModel(
      {@required this.photos,
      @required this.feed,
      @required this.subreddit,
      @required this.fetchMore})
      : assert(photos != null),
        assert(feed != null),
        assert(subreddit != null),
        assert(fetchMore != null);

  factory _SubredditViewModel.fromStore(
      Store<ReddigramState> store, String subredditName) {
    return _SubredditViewModel(
      photos: store.state.feeds['r/$subredditName'].photosIds
          .map((photoId) => store.state.photos[photoId])
          .toList(),
      feed: store.state.feeds['r/$subredditName'],
      subreddit: store.state.subreddits[subredditName],
      fetchMore: (completer) => store.dispatch(
          fetchMoreFeed('r/$subredditName', limit: 27, completer: completer)),
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
      subscribed: store.state.subscriptions
          .any((sub) => sub.toLowerCase() == subredditName.toLowerCase()),
      subscribe: () => store.dispatch(subscribeSubreddit(subredditName)),
      unsubscribe: () => store.dispatch(unsubscribeSubreddit(subredditName)),
    );
  }
}

class _PhotoViewModel {
  final bool authenticated;
  final Photo photo;
  final VoidCallback onUpvote;
  final VoidCallback onUpvoteCanceled;

  _PhotoViewModel(
      {@required this.authenticated,
      @required this.photo,
      @required this.onUpvote,
      @required this.onUpvoteCanceled})
      : assert(authenticated != null),
        assert(photo != null);

  factory _PhotoViewModel.fromStore(
      Store<ReddigramState> store, String subredditName, int index) {
    final photoId = store.state.feeds['r/$subredditName'].photosIds[index];
    final photo = store.state.photos[photoId];

    return _PhotoViewModel(
      authenticated: store.state.authState.status == AuthStatus.authenticated,
      photo: photo,
      onUpvote: () => store.dispatch(upvote(photo)),
      onUpvoteCanceled: () => store.dispatch(cancelUpvote(photo)),
    );
  }
}
