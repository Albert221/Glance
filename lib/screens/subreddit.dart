import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SubredditScreen extends StatefulWidget {
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

  bool _nsfwPhotoShown(_FeedViewModel vm, Photo photo) =>
      vm.feed.nsfw || _shownNsfwIds.contains(photo.id);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReddigramState, bool>(
      onInit: (store) {
        if (!_subredditLoaded(store)) {
          store
              .dispatch(fetchFreshFeed('r/${widget.subredditName}', limit: 99));
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
      title: StoreConnector<ReddigramState, bool>(
        converter: (store) =>
            store.state.feeds['r/${widget.subredditName}']?.nsfw ?? false,
        builder: (context, nsfw) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (nsfw)
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Colors.grey,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 4.0),
                    child: const Text(
                      '18+',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
    return StoreConnector<ReddigramState, _FeedViewModel>(
      converter: (store) =>
          _FeedViewModel.fromStore(store, widget.subredditName),
      builder: (context, feedVm) => InfiniteList(
            fetchMore: feedVm.fetchMore,
            keepAlive: true,
            itemCount: 2,
            itemBuilder: (context, i) => [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: feedVm.photos.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150),
                      itemBuilder: (context, i) => Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: _buildPhotoGridItem(context, feedVm, i),
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

  Widget _buildPhotoGridItem(
      BuildContext context, _FeedViewModel vm, int photoIndex) {
    final photo = vm.photos[photoIndex];

    return PhotoGridItem(
      photo: photo,
      onTap: () {
        final width = MediaQuery.of(context).size.width;

        final offset = photoIndex == 0
            ? 0.0
            : vm.photos
                .sublist(0, photoIndex)
                .map((photo) => width / photo.fullImage.aspectRatio)
                // 123 is the padding (2*8) + top and bottom bar height (51, 56)
                .map((height) => (height > width ? width : height) + 123)
                .reduce((a, b) => a + b);

        DefaultTabController.of(context).animateTo(1);
        // Delay so that the column InfiniteList can get its state built
        Future.delayed(Duration(milliseconds: 300), () {
          _columnListKey.currentState.scrollToOffset(offset);
        });
      },
      showNsfw: _nsfwPhotoShown(vm, photo),
      onShowNsfw: () => setState(() => _shownNsfwIds.add(photo.id)),
    );
  }

  Widget _buildList(BuildContext context) {
    return StoreConnector<ReddigramState, _FeedViewModel>(
      converter: (store) =>
          _FeedViewModel.fromStore(store, widget.subredditName),
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
    );
  }

  Widget _buildPhotoListItem(
      BuildContext context, _FeedViewModel feedVm, int photoIndex) {
    return StoreConnector<ReddigramState, _PhotoViewModel>(
      converter: (store) =>
          _PhotoViewModel.fromStore(store, widget.subredditName, photoIndex),
      builder: (context, vm) => PhotoListItem(
            photo: vm.photo,
            onUpvote: vm.onUpvote,
            onUpvoteCanceled: vm.onUpvoteCanceled,
            showNsfw: _nsfwPhotoShown(feedVm, vm.photo),
            onShowNsfw: () => setState(() => _shownNsfwIds.add(vm.photo.id)),
            onPhotoTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PhotoPreviewScreen(photo: vm.photo))),
          ),
    );
  }
}

class _FeedViewModel {
  final List<Photo> photos;
  final Feed feed;
  final void Function(Completer) fetchMore;

  _FeedViewModel(
      {@required this.photos, @required this.feed, @required this.fetchMore})
      : assert(photos != null),
        assert(feed != null),
        assert(fetchMore != null);

  factory _FeedViewModel.fromStore(
      Store<ReddigramState> store, String subredditName) {
    return _FeedViewModel(
      photos: store.state.feeds['r/$subredditName'].photosIds
          .map((photoId) => store.state.photos[photoId])
          .toList(),
      feed: store.state.feeds['r/$subredditName'],
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
    final photoId = store.state.feeds['r/$subredditName'].photosIds[index];
    final photo = store.state.photos[photoId];

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
