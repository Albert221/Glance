import 'package:shared_preferences/shared_preferences.dart';

class ApiLocalRepository {
  static const preferencesKey = "local_subscriptions";

  Future<List<String>> fetchSubscriptions() {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.getStringList(preferencesKey) ?? []);
  }

  Future<void> subscribeSubreddit(String name) {
    return SharedPreferences.getInstance().then((prefs) {
      final subs = prefs.getStringList(preferencesKey) ?? [];

      if (!subs.contains(name)) {
        subs.add(name);
        prefs.setStringList(preferencesKey, subs);
      }
    });
  }

  Future<void> unsubscribeSubreddit(String name) {
    return SharedPreferences.getInstance().then((prefs) {
      final subs = prefs.getStringList(preferencesKey) ?? [];

      subs.removeWhere((sub) => sub == name);
      prefs.setStringList(preferencesKey, subs);
    });
  }
}
