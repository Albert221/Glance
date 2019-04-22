import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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

  void _connectToReddit() {
    debugPrint('Connecting!');
  }

  @override
  Widget build(BuildContext context) {
    _offsetToLoad = () => MediaQuery.of(context).size.height * 3;

    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(context),
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
                              ? authState.username
                              : 'Guest',
                          style: Theme.of(context).textTheme.title,
                        ),
                      ),
                ),
                ListTile(
                  title: const Text('Some empty space (temporarily).'),
                ),
              ],
            ),
          ),
          Material(
            elevation: 4.0,
            child: Column(
              children: [
                StoreConnector<ReddigramState, AuthState>(
                  converter: (store) => store.state.authState,
                  builder: (context, authState) => authState.authenticated
                      ? ListTile(
                          title: const Text('Sign out'),
                          leading: const Icon(Icons.power_settings_new),
                          onTap: () {},
                        )
                      : ListTile(
                          title: const Text('Connect to Reddit'),
                          leading: const Icon(Icons.account_circle),
                          onTap: _connectToReddit,
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
    return StoreConnector<ReddigramState, _ViewModel>(
      onInit: (store) => store.dispatch(fetchMoreFeed()),
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, vm) {
        _fetchMore = vm.fetchMore;

        return ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: vm.feedState.photos.length + 1,
          itemBuilder: (context, i) {
            // Is last?
            if (i == vm.feedState.photos.length) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            }

            return PhotoListItem(photo: vm.feedState.photos[i]);
          },
        );
      },
    );
  }
}

class _ViewModel {
  final FeedState feedState;
  final VoidCallback fetchMore;

  _ViewModel({@required this.feedState, @required this.fetchMore})
      : assert(feedState != null),
        assert(fetchMore != null);

  factory _ViewModel.fromStore(Store<ReddigramState> store) {
    return _ViewModel(
      feedState: store.state.feedState,
      fetchMore: () {
        if (!store.state.feedState.fetching) {
          store.dispatch(fetchMoreFeed());
        }
      },
    );
  }
}
