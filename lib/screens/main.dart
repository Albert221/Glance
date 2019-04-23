import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/consts.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _methodChannel = MethodChannel('me.wolszon.reddigram/oauth');
  final _scrollController = ScrollController();

  double Function() _offsetToLoad = () => 0;
  VoidCallback _fetchMore = () {};

  bool authInProgress = false;

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

  void _connectToReddit(OnConnectCallback onConnect) async {
    setState(() => authInProgress = true);
    final completer = Completer()
      ..future.then((_) => setState(() => authInProgress = false));

    try {
      final response = await _methodChannel.invokeMethod(
          'showOauthScreen', {'clientId': ReddigramConsts.oauthClientId});
      onConnect(response['accessToken'], completer);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      completer.complete();
    }
  }

  @override
  Widget build(BuildContext context) {
    _offsetToLoad = () => MediaQuery.of(context).size.height * 3;

    return Stack(
      children: [
        Scaffold(
          appBar: _buildAppBar(context),
          drawer: _buildDrawer(context),
          body: _buildBody(context),
        ),
        authInProgress ? const FullscreenProgressIndicator() : const SizedBox(),
      ],
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

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                StoreConnector<ReddigramState, AuthState>(
                  converter: (store) => store.state.authState,
                  builder: (context, authState) => DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.tealAccent.shade100,
                        ),
                        child: Text(
                          authState.authenticated
                              ? authState.username ?? 'No username'
                              : 'Guest',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                ),
                const ListTile(
                  title: Text('Subreddits'),
                  trailing: Icon(Icons.add),
                ),
                StoreConnector<ReddigramState, List<String>>(
                  converter: (store) => store.state.subscriptions.toList(),
                  builder: (context, subreddits) {
                    if (subreddits.isEmpty) {
                      return const ListTile(
                        title: Text('No subreddits'),
                        dense: true,
                      );
                    }

                    return Column(
                      children: subreddits
                          .map((subreddit) => ListTile(
                                dense: true,
                                title: Text('r/$subreddit'),
                              ))
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          Material(
            elevation: 4.0,
            child: Column(
              children: [
                StoreConnector<ReddigramState, _ConnectViewModel>(
                  converter: (store) => _ConnectViewModel.fromStore(store),
                  builder: (context, vm) => vm.authState.authenticated
                      ? ListTile(
                          title: const Text('Sign out'),
                          leading: const Icon(Icons.power_settings_new),
                          onTap: () {},
                        )
                      : ListTile(
                          title: const Text('Connect to Reddit'),
                          leading: const Icon(Icons.account_circle),
                          onTap: () => _connectToReddit(vm.authenticate),
                        ),
                ),
                ListTile(
                  title: const Text('Settings'),
                  leading: const Icon(Icons.settings),
//                  onTap: () => Navigator.pushNamed(context, '/settings'),
                ),
              ],
            ),
          ),
        ],
      ),
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
                  child: const CircularProgressIndicator(),
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

typedef OnConnectCallback = void Function(String, Completer);

class _ConnectViewModel {
  final AuthState authState;
  final OnConnectCallback authenticate;

  _ConnectViewModel({@required this.authState, @required this.authenticate})
      : assert(authState != null),
        assert(authenticate != null);

  factory _ConnectViewModel.fromStore(Store<ReddigramState> store) {
    return _ConnectViewModel(
      authState: store.state.authState,
      authenticate: (accessToken, completer) =>
          store.dispatch(authenticateUser(accessToken, completer)),
    );
  }
}

class _BodyViewModel {
  final FeedState feedState;
  final void Function(Completer) fetchFresh;
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
