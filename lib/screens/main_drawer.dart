import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/consts.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

typedef OnConnectCallback = void Function(String);

class MainDrawer extends StatelessWidget {
  final _methodChannel = MethodChannel('me.wolszon.reddigram/oauth');

  void _connectToReddit(OnConnectCallback onConnect) async {
    try {
      final response = await _methodChannel.invokeMethod(
          'showOauthScreen', {'clientId': ReddigramConsts.oauthClientId});
      onConnect(response['code']);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          onTap: () {
                            vm.signOut();
                          },
                        )
                      : ListTile(
                          title: const Text('Connect to Reddit'),
                          leading: const Icon(Icons.account_circle),
                          onTap: () => _connectToReddit(vm.onConnect),
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
}

class _ConnectViewModel {
  final AuthState authState;
  final OnConnectCallback onConnect;
  final VoidCallback signOut;

  _ConnectViewModel(
      {@required this.authState,
      @required this.onConnect,
      @required this.signOut})
      : assert(authState != null),
        assert(onConnect != null),
        assert(signOut != null);

  factory _ConnectViewModel.fromStore(Store<ReddigramState> store) {
    return _ConnectViewModel(
      authState: store.state.authState,
      onConnect: (accessToken) =>
          store.dispatch(authenticateUserFromCode(accessToken)),
      signOut: () => store.dispatch(signUserOut()),
    );
  }
}
