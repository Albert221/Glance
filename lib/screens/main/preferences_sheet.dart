import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/app.dart';
import 'package:reddigram/consts.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class PreferencesSheet extends StatefulWidget {
  @override
  _PreferencesSheetState createState() => _PreferencesSheetState();
}

class _PreferencesSheetState extends State<PreferencesSheet> {
  StreamSubscription<Uri> _linkStream;

  @override
  void dispose() {
    _linkStream?.cancel();
    super.dispose();
  }

  void _connectToReddit(BuildContext context) async {
    ReddigramApp.analytics.logEvent(name: 'login_attempt');

    if (await _showRedditBugWarningAlert(context) != true) return;

    launch('https://www.reddit.com/api/v1/authorize'
        '?client_id=${ReddigramConsts.oauthClientId}&response_type=code'
        '&state=x&scope=read+mysubreddits+vote+identity&duration=permanent'
        '&redirect_uri=${ReddigramConsts.oauthRedirectUrl}');

    _linkStream = getUriLinksStream().listen((uri) {
      if (uri.host == 'redirect' && uri.queryParameters.containsKey('code')) {
        StoreProvider.of<ReddigramState>(context)
            .dispatch(authenticateUserFromCode(uri.queryParameters['code']));

        _linkStream.cancel();
        ReddigramApp.analytics.logLogin(loginMethod: 'Reddit');
      }
    });
  }

  Future<bool> _showRedditBugWarningAlert(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Warning'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.body1,
                children: [
                  const TextSpan(text: 'Due to Reddit\'s bug, if you are unable to sign in please turn on '),
                  const TextSpan(
                    text: 'Desktop site',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                      text: ' option and try again. '),
                  TextSpan(
                    text: 'Read more',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launch(
                          'https://www.reddit.com/r/bugs/comments/dc8cea/cant_sign_in_on_mobile_on_logindest/'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Image.asset('assets/chrome_desktop_site.png'),
          ],
        ),
        actions: [
          FlatButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
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
        const DarkThemePreferenceTile(),
        const ShowNsfwPreferenceTile(),
//        ListTile(
//          leading: const SizedBox(),
//          title: const Text('More preferences'),
//          trailing: const Icon(Icons.chevron_right),
//          onTap: () => Navigator.push(context, PreferencesScreen.route()),
//        ),
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
