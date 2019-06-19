import 'package:flutter/material.dart';
import 'package:reddigram/widgets/widgets.dart';

class PreferencesScreen extends StatelessWidget {
  static PageRoute route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: 'PreferencesScreen'),
      builder: (context) => PreferencesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Column(
        children: [
          const DarkThemePreferenceTile(),
          const ShowNsfwPreferenceTile(),
        ],
      ),
    );
  }
}
