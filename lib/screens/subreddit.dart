import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SubredditScreen extends StatefulWidget {
  static PageRoute route(String subredditId) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: 'SubredditScreen'),
      builder: (context) => SubredditScreen(subredditId: subredditId),
    );
  }

  final String subredditId;

  const SubredditScreen({Key key, this.subredditId}) : super(key: key);

  @override
  _SubredditScreenState createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen> {
  final _shownNsfwIds = Set<String>();
  final _columnListKey = GlobalKey<InfiniteListState>();

  Subreddit _subreddit(Store<ReddigramState> store) =>
      store.state.subreddits[widget.subredditId];

  bool _subredditFeedLoaded(Store<ReddigramState> store) =>
      _subreddit(store) != null &&
      store.state.feeds['r/${_subreddit(store).name}'] != null;

  bool _nsfwPhotoShown(
          BuildContext context, _SubredditViewModel vm, Photo photo) =>
      vm.subreddit.nsfw ||
      _shownNsfwIds.contains(photo.id) ||
      PreferencesProvider.of(context).showNsfw;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReddigramState, bool>(
      onInit: (store) async {
        final subreddit = _subreddit(store);

        // That's an edge case, when subreddit isn't already fetched and we
        // open SubredditScreen with a completely fresh sub.
        if (subreddit == null) {
          final completer = Completer();
          store.dispatch(
            fetchSubreddits([widget.subredditId], completer: completer),
          );
          await completer.future;
        }

        store.dispatch(
          fetchFreshFeed('r/${_subreddit(store).name}', limit: 99),
        );
      },
      converter: (store) =>
          store.state.subreddits[widget.subredditId]?.submissionType == 'self',
      builder: (context, isTextOnly) {
        if (isTextOnly) {
          return Scaffold(
            appBar: AppBar(),
            extendBodyBehindAppBar: true,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '( ͡° ʖ̯ ͡°)',
                    style: Theme.of(context).textTheme.display1,
                  ),
                  const SizedBox(height: 16),
                  const Text('This subreddit is text only.'),
                ],
              ),
            ),
          );
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: TabBarView(
              children: [
                _buildGrid(context),
                _buildList(context),
              ],
            ),
          ),
        );
      },
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
      title: const TabBar(
        tabs: [
          // 5.0 padding so the tabs are 56.0 tall (same as the appbar height)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Tab(
              icon: Icon(Icons.apps),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Tab(icon: Icon(Icons.view_list)),
          ),
        ],
      ),
      actions: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 16.0),
          width: 150.0,
          child: StoreConnector<ReddigramState, _SubscribeViewModel>(
            converter: (store) =>
                _SubscribeViewModel.fromStore(store, widget.subredditId),
            builder: (context, vm) => vm.subscribed
                ? FlatButton(
                    onPressed: vm.unsubscribe,
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Unsubscribe'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: onBackgroundColor),
                      ),
                    ),
                    color: backgroundColor,
                  )
                : FlatButton.icon(
                    onPressed: vm.subscribe,
                    icon: Icon(Icons.add, color: onPrimaryColor),
                    label: Text(
                      'Subscribe'.toUpperCase(),
                      textAlign: TextAlign.center,
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
      converter: _subredditFeedLoaded,
      builder: (context, loaded) => loaded
          ? StoreConnector<ReddigramState, _SubredditViewModel>(
              converter: (store) => _SubredditViewModel.fromStore(
                store,
                widget.subredditId,
                _subreddit(store).name,
              ),
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
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.all(2),
                child: PhotoGridItem.placeholder(),
              ),
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
      converter: _subredditFeedLoaded,
      builder: (context, loaded) => loaded
          ? StoreConnector<ReddigramState, _SubredditViewModel>(
              converter: (store) => _SubredditViewModel.fromStore(
                store,
                widget.subredditId,
                _subreddit(store).name,
              ),
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
          _PhotoViewModel.fromStore(store, _subreddit(store).name, photoIndex),
      builder: (context, vm) => PhotoListItem(
        photo: vm.photo,
        subreddit: vm.subreddit,
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
      Store<ReddigramState> store, String subredditId, String subredditName) {
    return _SubredditViewModel(
      photos: store.state.feeds['r/$subredditName'].photosIds
          .map((photoId) => store.state.photos[photoId])
          .toList(),
      feed: store.state.feeds['r/$subredditName'],
      subreddit: store.state.subreddits[subredditId],
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
      Store<ReddigramState> store, String subredditId) {
    return _SubscribeViewModel(
      subscribed: store.state.subscriptions.any((sub) => sub == subredditId),
      subscribe: () => store.dispatch(subscribeSubreddit(subredditId)),
      unsubscribe: () => store.dispatch(unsubscribeSubreddit(subredditId)),
    );
  }
}

class _PhotoViewModel {
  final bool authenticated;
  final Photo photo;
  final Subreddit subreddit;
  final VoidCallback onUpvote;
  final VoidCallback onUpvoteCanceled;

  _PhotoViewModel(
      {@required this.authenticated,
      @required this.photo,
      @required this.subreddit,
      @required this.onUpvote,
      @required this.onUpvoteCanceled})
      : assert(authenticated != null),
        assert(photo != null);

  factory _PhotoViewModel.fromStore(
      Store<ReddigramState> store, String subredditName, int index) {
    final photoId = store.state.feeds['r/$subredditName'].photosIds[index];
    final photo = store.state.photos[photoId];
    final subreddit = store.state.subreddits[photo.subredditId];

    return _PhotoViewModel(
      authenticated: store.state.authState.status == AuthStatus.authenticated,
      photo: photo,
      subreddit: subreddit,
      onUpvote: () => store.dispatch(upvote(photo)),
      onUpvoteCanceled: () => store.dispatch(cancelUpvote(photo)),
    );
  }
}
