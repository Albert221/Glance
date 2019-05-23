import 'dart:convert';

import 'package:reddigram/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubredditCache {
  static const cacheKey = 'subreddit_cache';

  Future<List<Feed>> get(List<String> subreddits) async {
    final cacheJson = await SharedPreferences.getInstance()
            .then((prefs) => prefs.getString(cacheKey)) ??
        '{}';

    final cache = json.decode(cacheJson) as Map<String, dynamic>;

    final results = <Feed>[];
    subreddits.forEach((subreddit) {
      try {
        if (!cache.containsKey(subreddit)) {
          return;
        }

        final cachedSub = cache[subreddit] as Map<String, dynamic>;
        results.add(Feed().rebuild((b) => b
          ..id = cachedSub['id']
          ..name = subreddit
          ..iconUrl = cachedSub['iconUrl']
          ..primaryColor = cachedSub['primaryColor']
          ..nsfw = cachedSub['nsfw']));
      } catch (_) {}
    });

    return results;
  }

  Future<void> put(Feed subreddit) async {
    final cacheJson = await SharedPreferences.getInstance()
            .then((prefs) => prefs.getString(cacheKey)) ??
        '{}';

    final cache = json.decode(cacheJson) as Map<String, dynamic>;

    cache[subreddit.name] = {
      'id': subreddit.id,
      'iconUrl': subreddit.iconUrl,
      'primaryColor': subreddit.primaryColor,
      'nsfw': subreddit.nsfw,
    };

    await SharedPreferences.getInstance()
        .then((prefs) => prefs.setString(cacheKey, json.encode(cache)));
  }
}
