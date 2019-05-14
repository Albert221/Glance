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
  final _pageController = PageController();

  Set<String> _shownNsfwIds = Set();
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainScreen.scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: MainDrawer(),
      body: StoreConnector<ReddigramState, void>(
        onInit: (store) => store.dispatch(fetchFreshFeed(BEST)),
        converter: (store) => null,
        builder: (context, _) => PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                _buildFeed(context, BEST),
                _buildFeed(context, NEW_SUBSCRIBED),
                _buildFeed(context, BEST_SUBSCRIBED),
                Icon(Icons.view_list),
              ],
            ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            title: Text('Best'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('Your new'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Your best'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('Subbed'),
          ),
        ],
      ),
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

  Widget _buildFeed(BuildContext context, String feedName) {
    return StoreConnector<ReddigramState, _BodyViewModel>(
      converter: (store) => _BodyViewModel.fromStore(store, feedName),
      builder: (context, vm) {
        return RefreshIndicator(
          onRefresh: () {
            final completer = Completer();
            vm.fetchFresh(completer);

            return completer.future;
          },
          child: InfiniteList(
            keepAlive: true,
            fetchMore: vm.fetchMore,
            itemCount: vm.photos.length + 1,
            itemBuilder: (context, i) {
              // Last item is a loading indicator.
              if (i == vm.photos.length) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  alignment: Alignment.center,
                  child: vm.photos.isEmpty
                      ? const Text('That feed is empty! 😲')
                      : const CircularProgressIndicator(),
                );
              }

              return _buildPhoto(context, feedName, i);
            },
          ),
        );
      },
    );
  }

  Widget _buildPhoto(BuildContext context, String feedName, int index) {
    return StoreConnector<ReddigramState, _PhotoViewModel>(
      converter: (store) => _PhotoViewModel.fromStore(store, feedName, index),
      builder: (context, vm) => PhotoListItem(
            photo: vm.photo,
            onUpvote: vm.onUpvote,
            onUpvoteCanceled: vm.onUpvoteCanceled,
            onPhotoTap: () => Navigator.push(
                context, PhotoPreviewScreen.route(context, vm.photo)),
            onSubredditTap: () => Navigator.push(context,
                SubredditScreen.route(context, vm.photo.subredditName)),
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

  factory _BodyViewModel.fromStore(
      Store<ReddigramState> store, String feedName) {
    return _BodyViewModel(
      photos: store.state.feeds[feedName].photosIds
          .map((photoId) => store.state.photos[photoId])
          .toList(),
      fetchFresh: (completer) =>
          store.dispatch(fetchFreshFeed(feedName, completer: completer)),
      fetchMore: (completer) =>
          store.dispatch(fetchMoreFeed(feedName, completer: completer)),
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
      Store<ReddigramState> store, String feedName, int index) {
    final photoId = store.state.feeds[feedName].photosIds[index];
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
