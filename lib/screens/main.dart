import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatefulWidget {
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Set<String> _shownNsfwIds = Set();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainScreen.scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: MainDrawer(),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Reddigram',
        style: Theme.of(context).appBarTheme.textTheme.display1,
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    return StoreConnector<ReddigramState, _BodyViewModel>(
      converter: (store) => _BodyViewModel.fromStore(store),
      builder: (context, vm) => RefreshIndicator(
            onRefresh: () {
              final completer = Completer();
              vm.fetchFresh(completer);
              return completer.future;
            },
            child: InfiniteList(
              fetchMore: vm.fetchMore,
              itemCount: vm.photos.length + 1,
              itemBuilder: (context, i) {
                // Last item is a loading indicator.
                if (i == vm.photos.length) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    alignment: Alignment.center,
                    child: vm.photos.isEmpty
                        ? const Text(
                            'There is no feed! 😲\n\nTry subscribing to some subreddits.',
                            textAlign: TextAlign.center,
                          )
                        : const CircularProgressIndicator(),
                  );
                }

                return _buildPhoto(context, i);
              },
            ),
          ),
    );
  }

  Widget _buildPhoto(BuildContext context, int index) {
    return StoreConnector<ReddigramState, _PhotoViewModel>(
      converter: (store) => _PhotoViewModel.fromStore(store, index),
      builder: (context, vm) => PhotoListItem(
            photo: vm.photo,
            onUpvote: vm.onUpvote,
            onUpvoteCanceled: vm.onUpvoteCanceled,
            onPhotoTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PhotoPreviewScreen(photo: vm.photo))),
            onSubredditTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SubredditScreen(
                        subredditName: vm.photo.subredditName))),
            showNsfw: _shownNsfwIds.contains(vm.photo.id),
            onShowNsfw: () => setState(() => _shownNsfwIds.add(vm.photo.id)),
          ),
    );
  }
}

typedef CompleterCallback = void Function(Completer);

class _BodyViewModel {
  final List<Photo> photos;
  final CompleterCallback fetchFresh;
  final void Function(Completer) fetchMore;

  _BodyViewModel(
      {@required this.photos,
      @required this.fetchFresh,
      @required this.fetchMore})
      : assert(photos != null),
        assert(fetchFresh != null),
        assert(fetchMore != null);

  factory _BodyViewModel.fromStore(Store<ReddigramState> store) {
    return _BodyViewModel(
      photos: store.state.feeds[BEST_SUBSCRIBED].photosIds
          .map((photoId) => store.state.photos[photoId])
          .toList(),
      fetchFresh: (completer) {
        store.dispatch(fetchFreshFeed(BEST_SUBSCRIBED, completer: completer));
      },
      fetchMore: (completer) =>
          store.dispatch(fetchMoreFeed(BEST_SUBSCRIBED, completer: completer)),
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

  factory _PhotoViewModel.fromStore(Store<ReddigramState> store, int index) {
    final photoId = store.state.feeds[BEST_SUBSCRIBED].photosIds[index];
    final photo = store.state.photos[photoId];

    return _PhotoViewModel(
      photo: photo,
      onUpvote: store.state.authState.status == AuthStatus.authenticated
          ? () => store.dispatch(upvote(photo))
          : null,
      onUpvoteCanceled: store.state.authState.status == AuthStatus.authenticated
          ? () => store.dispatch(cancelUpvote(photo))
          : null,
    );
  }
}
