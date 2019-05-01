import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/theme.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:redux/redux.dart';

class ReddigramApp extends StatelessWidget {
  static final _analytics = FirebaseAnalytics();
  static final _navObserver = FirebaseAnalyticsObserver(analytics: _analytics);

  final Store<ReddigramState> store;

  ReddigramApp({Key key, @required this.store})
      : assert(store != null),
        super(key: key) {
    store.dispatch(authenticateUserFromStorage());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ReddigramState>(
      store: store,
      child: StoreConnector<ReddigramState, AppTheme>(
        onInit: (store) => store.dispatch(loadTheme()),
        converter: (store) => store.state.preferences.theme,
        builder: (context, theme) => MaterialApp(
              title: 'Reddigram',
              theme: theme == AppTheme.light
                  ? ReddigramTheme.light()
                  : ReddigramTheme.dark(),
              routes: {
                '/': (context) => MainScreen(),
              },
              navigatorObservers: [_navObserver],
            ),
      ),
    );
  }
}
