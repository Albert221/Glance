import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/theme.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';
import 'package:uni_links/uni_links.dart';

class ReddigramApp extends StatefulWidget {
  static final analytics = FirebaseAnalytics();
  static final _navObserver = FirebaseAnalyticsObserver(analytics: analytics);

  final Store<ReddigramState> store;

  ReddigramApp({Key key, @required this.store})
      : assert(store != null),
        super(key: key);

  @override
  _ReddigramAppState createState() => _ReddigramAppState();
}

class _ReddigramAppState extends State<ReddigramApp> {
  StreamSubscription<Uri> _linkStream;

  @override
  void initState() {
    super.initState();

    _linkStream = getUriLinksStream().listen((uri) {
      if (uri.host == 'redirect' && uri.queryParameters.containsKey('code')) {
        widget.store
            .dispatch(authenticateUserFromCode(uri.queryParameters['code']));

        ReddigramApp.analytics.logLogin(loginMethod: 'Reddit');
      }
    });
  }

  @override
  void dispose() {
    _linkStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return StoreProvider<ReddigramState>(
      store: widget.store,
      child: StoreConnector<ReddigramState, PreferencesState>(
        onInit: (store) => store.dispatch(loadPreferences()),
        converter: (store) => store.state.preferences,
        builder: (context, preferences) {
          return PreferencesProvider(
            preferences: preferences,
            child: StoreConnector<ReddigramState, AuthStatus>(
              onInit: (store) => store.dispatch(loadUser()),
              converter: (store) => store.state.authState.status,
              builder: (context, authStatus) {
                return MaterialApp(
                  title: 'Reddigram',
                  theme: PreferencesProvider.of(context).theme == AppTheme.light
                      ? ReddigramTheme.light()
                      : ReddigramTheme.dark(),
                  routes: {
                    '/': (context) => MainScreen(),
                  },
                  navigatorObservers: [ReddigramApp._navObserver],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
