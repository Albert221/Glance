import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/app.dart';
import 'package:reddigram/consts.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PreferencesSheet extends StatelessWidget {
  final _methodChannel = const MethodChannel('me.wolszon.reddigram');

  void _connectToReddit(BuildContext context) async {
    try {
      ReddigramApp.analytics.logEvent(name: 'login_attempt');

      final response = await _methodChannel.invokeMethod(
          'showOauthScreen', {'clientId': ReddigramConsts.oauthClientId});

      StoreProvider.of<ReddigramState>(context)
          .dispatch(authenticateUserFromCode(response['code']));
      ReddigramApp.analytics.logLogin(loginMethod: 'Reddit');
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _signOut(BuildContext context) {
    StoreProvider.of<ReddigramState>(context).dispatch(signUserOut());
    ReddigramApp.analytics.logEvent(name: 'sign_out');
  }

  void _openPrivacyPolicy() async {
    launch('https://reddigram.wolszon.me/privacy.html');
    ReddigramApp.analytics.logEvent(name: 'open_privacy_policy');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildConnectTile(),
        const ListTile(
          title: Text(
            'PREFERENCES',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          dense: true,
        ),
        const DarkThemeTile(),
        ListTile(
          leading: const SizedBox(),
          title: const Text('More preferences'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(context, PreferencesScreen.route()),
        ),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildConnectTile() {
    return StoreConnector<ReddigramState, AuthState>(
      converter: (store) => store.state.authState,
      builder: (context, authState) =>
          authState.status == AuthStatus.authenticated
              ? ListTile(
                  title: const Text('Sign out'),
                  trailing: Text(authState.username),
                  leading: const Icon(Icons.power_settings_new),
                  onTap: () => _signOut(context),
                )
              : ListTile(
                  title: const Text('Connect to Reddit'),
                  leading: const Icon(Icons.account_circle),
                  onTap: () => _connectToReddit(context),
                  trailing: authState.status == AuthStatus.authenticating
                      ? Transform.scale(
                          scale: 0.5,
                          child: const CircularProgressIndicator(),
                        )
                      : null,
                ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return ListTile(
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
              recognizer: TapGestureRecognizer()..onTap = _openPrivacyPolicy,
            ),
          ],
        ),
      ),
    );
  }
}
