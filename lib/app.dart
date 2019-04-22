import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:reddigram/theme.dart';
import 'package:reddigram/screens/screens.dart';

class ReddigramApp extends StatelessWidget {
  static final analytics = FirebaseAnalytics();
  static final navObserver = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reddigram',
      theme: ReddigramTheme.theme(),
      routes: {
        '/': (context) => MainScreen(),
        '/subscribed': (context) => SubscribedScreen(),
      },
      navigatorObservers: [navObserver],
    );
  }
}
