import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/consts.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class PreferencesSheet extends StatelessWidget {
  final _methodChannel = const MethodChannel('me.wolszon.reddigram');

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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StoreConnector<ReddigramState, _ConnectViewModel>(
          converter: (store) => _ConnectViewModel.fromStore(store),
          builder: (context, vm) =>
              vm.authState.status == AuthStatus.authenticated
                  ? ListTile(
                      title: const Text('Sign out'),
                      trailing: Text(vm.authState.username),
                      leading: const Icon(Icons.power_settings_new),
                      onTap: vm.signOut,
                    )
                  : ListTile(
                      title: const Text('Connect to Reddit'),
                      leading: const Icon(Icons.account_circle),
                      onTap: () => _connectToReddit(vm.onConnect),
                      trailing: vm.authState.status == AuthStatus.authenticating
                          ? Transform.scale(
                              scale: 0.5,
                              child: const CircularProgressIndicator(),
                            )
                          : null,
                    ),
        ),
        ListTile(
          title: const Text(
            'PREFERENCES',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          dense: true,
        ),
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
        ListTile(
          leading: SizedBox(),
          title: Text('More preferences'),
          trailing: Icon(Icons.chevron_right),
          onTap: () => Navigator.push(context, PreferencesScreen.route()),
        ),
        ListTile(
          enabled: false,
          dense: true,
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
        ),
      ],
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
