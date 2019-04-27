import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _scrollController = ScrollController();

  double Function() _offsetToLoad = () => 0;
  VoidCallback _fetchMore = () {};

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final position = _scrollController.position;
      if (position.pixels + _offsetToLoad() >= position.maxScrollExtent) {
        _fetchMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _offsetToLoad = () => MediaQuery.of(context).size.height * 3;

    return StoreConnector<ReddigramState, bool>(
      converter: (store) => store.state.authState.inProgress,
      builder: (context, authInProgress) => Stack(
            children: [
              Scaffold(
                appBar: _buildAppBar(context),
                drawer: MainDrawer(),
                body: _buildBody(context),
              ),
              authInProgress
                  ? const FullscreenProgressIndicator()
                  : const SizedBox(),
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

  Widget _buildBody(BuildContext context) {
    return StoreConnector<ReddigramState, _BodyViewModel>(
      onInit: (store) => store.dispatch(fetchFreshFeed()),
      converter: (store) => _BodyViewModel.fromStore(store),
      builder: (context, vm) {
        _fetchMore = vm.fetchMore;

        return RefreshIndicator(
          onRefresh: () {
            final completer = Completer();
            vm.fetchFresh(completer);
            return completer.future;
          },
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: vm.feedState.photos.length + 1,
            itemBuilder: (context, i) {
              // Last item is a loading indicator.
              if (i == vm.feedState.photos.length) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  alignment: Alignment.center,
                  child: vm.feedState.photos.isEmpty
                      ? const Text(
                          'There is no feed! 😲\n\nTry subscribing to some subreddits.',
                          textAlign: TextAlign.center,
                        )
                      : const CircularProgressIndicator(),
                );
              }

              return StoreConnector<ReddigramState, _PhotoViewModel>(
                converter: (store) => _PhotoViewModel.fromStore(store, i),
                builder: (context, vm) => PhotoListItem(
                      photo: vm.photo,
                      onUpvote: vm.onUpvote,
                      onUpvoteCanceled: vm.onUpvoteCanceled,
                    ),
              );
            },
          ),
        );
      },
    );
  }
}

typedef CompleterCallback = void Function(Completer);

class _BodyViewModel {
  final FeedState feedState;
  final CompleterCallback fetchFresh;
  final VoidCallback fetchMore;

  _BodyViewModel(
      {@required this.feedState,
      @required this.fetchFresh,
      @required this.fetchMore})
      : assert(feedState != null),
        assert(fetchFresh != null),
        assert(fetchMore != null);

  factory _BodyViewModel.fromStore(Store<ReddigramState> store) {
    return _BodyViewModel(
      feedState: store.state.feedState,
      fetchFresh: (completer) {
        if (!store.state.feedState.fetching) {
          store.dispatch(fetchFreshFeed(completer));
        }
      },
      fetchMore: () {
        if (!store.state.feedState.fetching) {
          store.dispatch(fetchMoreFeed());
        }
      },
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
      : assert(photo != null),
        assert(onUpvote != null),
        assert(onUpvoteCanceled != null);

  factory _PhotoViewModel.fromStore(Store<ReddigramState> store, int i) {
    final photo = store.state.feedState.photos[i];

    return _PhotoViewModel(
      photo: photo,
      onUpvote: () => store.dispatch(upvote(photo)),
      onUpvoteCanceled: () => store.dispatch(cancelUpvote(photo)),
    );
  }
}
