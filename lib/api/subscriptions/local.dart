import 'package:reddigram/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionsLocalRepository implements SubscriptionRepository {
  static const preferencesKey = "local_subscriptions";

  @override
  Future<List<String>> fetchSubscribedSubreddits() {
    return SharedPreferences.getInstance()
        .then((prefs) => prefs.getStringList(preferencesKey) ?? []);
  }

  @override
  Future<void> subscribeSubreddit(String name) {
    return SharedPreferences.getInstance().then((prefs) {
      final subs = prefs.getStringList(preferencesKey) ?? [];

      if (!subs.contains(name)) {
        subs.add(name);
        prefs.setStringList(preferencesKey, subs);
      }
    });
  }

  @override
  Future<void> unsubscribeSubreddit(String name) {
    return SharedPreferences.getInstance().then((prefs) {
      final subs = prefs.getStringList(preferencesKey) ?? [];

      subs.removeWhere((sub) => sub == name);
      prefs.setStringList(preferencesKey, subs);
    });
  }
}
