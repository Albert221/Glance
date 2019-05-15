import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/consts.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  final _methodChannel = const MethodChannel('me.wolszon.reddigram/oauth');

  const MainDrawer({Key key}) : super(key: key);

  void _connectToReddit(_OnConnectCallback onConnect) async {
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
          Expanded(child: _buildPreferences(context)),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return StoreConnector<ReddigramState, AuthState>(
      converter: (store) => store.state.authState,
      builder: (context, authState) => DrawerHeader(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.color,
            ),
            child: Text(
              authState.status == AuthStatus.authenticated
                  ? authState.username
                  : 'Guest',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
    );
  }

  Widget _buildPreferences(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StoreConnector<ReddigramState, _PreferenceViewModel>(
          converter: (store) => _PreferenceViewModel<AppTheme>(
                value: store.state.preferences.theme,
                onSwitch: (dark) => store
                    .dispatch(setTheme(dark ? AppTheme.dark : AppTheme.light)),
              ),
          builder: (context, vm) => SwitchListTile(
                title: const Text('Dark theme'),
                secondary: const Icon(Icons.invert_colors),
                value: vm.value == AppTheme.dark,
                onChanged: vm.onSwitch,
              ),
        ),
        StoreConnector<ReddigramState, _PreferenceViewModel>(
          converter: (store) => _PreferenceViewModel<bool>(
                value: store.state.preferences.showNsfw,
                onSwitch: (showNsfw) => store.dispatch(setShowNsfw(showNsfw)),
              ),
          builder: (context, vm) => SwitchListTile(
                title: const Text('Show adult content'),
                secondary: const Icon(Icons.block),
                value: vm.value,
                onChanged: vm.onSwitch,
              ),
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Material(
      elevation: 4.0,
      child: Column(
        children: [
          StoreConnector<ReddigramState, _ConnectViewModel>(
            converter: (store) => _ConnectViewModel.fromStore(store),
            builder: (context, vm) =>
                vm.authState.status == AuthStatus.authenticated
                    ? ListTile(
                        title: const Text('Sign out'),
                        leading: const Icon(Icons.power_settings_new),
                        onTap: vm.signOut,
                      )
                    : ListTile(
                        title: const Text('Connect to Reddit'),
                        leading: const Icon(Icons.account_circle),
                        onTap: () => _connectToReddit(vm.onConnect),
                      ),
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Theme.of(context).disabledColor),
                children: [
                  const TextSpan(text: 'Reddigram • '),
                  TextSpan(
                    text: 'Privacy policy',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () =>
                          launch('https://reddigram.wolszon.me/privacy.html'),
                  ),
                ],
              ),
            ),
            enabled: false,
            dense: true,
          ),
        ],
      ),
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

class _PreferenceViewModel<T> {
  final T value;
  final void Function(bool) onSwitch;

  _PreferenceViewModel({@required this.value, @required this.onSwitch})
      : assert(value != null),
        assert(onSwitch != null);
}
