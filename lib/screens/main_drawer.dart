import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/consts.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

class MainDrawer extends StatelessWidget {
  final _methodChannel = MethodChannel('me.wolszon.reddigram/oauth');

  void _connectToReddit(_OnConnectCallback onConnect) async {
    try {
      final response = await _methodChannel.invokeMethod(
          'showOauthScreen', {'clientId': ReddigramConsts.oauthClientId});
      onConnect(response['code']);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _subscribe(BuildContext context, _StringCallback callback) async {
    final controller = TextEditingController();
    final focusNode = FocusNode();

    FocusScope.of(context).requestFocus(focusNode);

    final subreddit = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
            title: const Text('Subscribe to subreddit'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      focusNode: focusNode,
                      controller: controller,
                      decoration:
                          const InputDecoration(hintText: 'Enter name here'),
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) => Navigator.of(context).pop(value),
                    ),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: const Text('SUBSCRIBE'),
                        onPressed: () =>
                            Navigator.of(context).pop(controller.text),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );

    if (subreddit != null && subreddit.isNotEmpty) {
      callback(subreddit);
    }
  }

  void _unsubscribe(
      BuildContext context, String subreddit, VoidCallback callback) async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Unsubscribing'),
          content: Text('Do you really want to unsubscribe from r/$subreddit?'),
          actions: [
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: const Text('Unsubscribe'),
              onPressed: () {
                Navigator.of(context).pop();
                callback();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildHeader(context),
                _buildSubredditsList(context),
              ],
            ),
          ),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return StoreConnector<ReddigramState, AuthState>(
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
    );
  }

  Widget _buildSubredditsList(BuildContext context) {
    return StoreConnector<ReddigramState, _SubredditsViewModel>(
      converter: (store) => _SubredditsViewModel.fromStore(store),
      builder: (context, vm) => Column(
            children: [
              ListTile(
                title: const Text('Subreddits'),
                trailing: const Icon(Icons.add),
                onTap: () => _subscribe(context, vm.subscribe),
              ),
              if (vm.subreddits.isEmpty)
                const ListTile(
                  title: Text('No subreddits'),
                  dense: true,
                ),
              ...vm.subreddits
                  .map((subreddit) => ListTile(
                        dense: true,
                        title: Text('r/$subreddit'),
                        onTap: () {
                          _unsubscribe(context, subreddit,
                              () => vm.unsubscribe(subreddit));
                        },
                      ))
                  .toList(),
            ],
          ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Material(
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
          SwitchListTile(
            title: const Text('Dark theme'),
            secondary: const Icon(Icons.invert_colors),
            value: false,
            onChanged: (x) {},
          ),
        ],
      ),
    );
  }
}

typedef _StringCallback = void Function(String);

class _SubredditsViewModel {
  final List<String> subreddits;
  final _StringCallback subscribe;
  final _StringCallback unsubscribe;

  _SubredditsViewModel(
      {@required this.subreddits,
      @required this.subscribe,
      @required this.unsubscribe})
      : assert(subreddits != null),
        assert(subscribe != null),
        assert(unsubscribe != null);

  factory _SubredditsViewModel.fromStore(Store<ReddigramState> store) {
    return _SubredditsViewModel(
      subreddits: store.state.subscriptions.toList(),
      subscribe: (subreddit) => store.dispatch(subscribeSubreddit(subreddit)),
      unsubscribe: (subreddit) =>
          store.dispatch(unsubscribeSubreddit(subreddit)),
    );
  }
}

typedef _OnConnectCallback = void Function(String);

class _ConnectViewModel {
  final AuthState authState;
  final _OnConnectCallback onConnect;
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
