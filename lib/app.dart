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

class ReddigramApp extends StatelessWidget {
  static final _analytics = FirebaseAnalytics();
  static final _navObserver = FirebaseAnalyticsObserver(analytics: _analytics);

  final Store<ReddigramState> store;

  ReddigramApp({Key key, @required this.store})
      : assert(store != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return StoreProvider<ReddigramState>(
      store: store,
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
                  navigatorObservers: [_navObserver],
                  builder: (context, child) {
                    return Stack(
                      children: [
                        child,
                        if (authStatus == AuthStatus.unknown)
                          const FullscreenProgressIndicator(),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
