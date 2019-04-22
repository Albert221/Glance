import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart' as http;
import 'package:reddigram/api/api.dart';

class RedditRepository {
  static ListingResponse _filterOnlyPhotos(ListingResponse response) {
    return response.rebuild((b) => b
      ..data = response.data
          .rebuild((b) => b
            ..children = ListBuilder(response.data.children
                .where((child) => child.data.preview != null)))
          .toBuilder());
  }

  // FIXME: Change limit back to 25
  static Future<ListingResponse> subreddit(String name,
      {String after = '', int limit = 3}) async {
    return http
        .get('https://reddit.com/r/$name.json?after=$after&limit=$limit')
        .then((response) => serializers.deserializeWith(
            ListingResponse.serializer, json.decode(response.body)))
        .then(_filterOnlyPhotos);
  }
}
