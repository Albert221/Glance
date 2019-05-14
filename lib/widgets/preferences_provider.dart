import 'package:flutter/material.dart';
import 'package:reddigram/store/store.dart';

class PreferencesProvider extends InheritedWidget {
  final PreferencesState preferences;
  final Widget child;

  PreferencesProvider({@required this.preferences, @required this.child})
      : assert(preferences != null),
        assert(child != null);

  static PreferencesState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PreferencesProvider)
            as PreferencesProvider)
        .preferences;
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  bool updateShouldNotify(PreferencesProvider oldWidget) {
    return preferences != oldWidget.preferences;
  }
}
