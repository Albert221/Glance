import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';
import 'package:reddigram/api/api.dart';

class RedditRepository {
  static PackageInfo _packageInfo;

  static Future<http.Response> _get(String url) async {
    if (_packageInfo == null) {
      _packageInfo = await PackageInfo.fromPlatform();
    }

    return http.get(url, headers: {
      'User-Agent':
          '${_packageInfo.packageName}:${_packageInfo.version} (by /u/Albert221)'
    });
  }

  static ListingResponse _filterOnlyPhotos(ListingResponse response) {
    return response.rebuild((b) => b
      ..data = response.data
          .rebuild((b) => b
            ..children = ListBuilder(response.data.children
                .where((child) => child.data.preview != null)))
          .toBuilder());
  }

  static Future<ListingResponse> subreddit(String name,
      {String after = '', int limit = 25}) async {
    return _get('https://reddit.com/r/$name.json?after=$after&limit=$limit')
        .then((response) => serializers.deserializeWith(
            ListingResponse.serializer, json.decode(response.body)))
        .then(_filterOnlyPhotos);
  }
}
