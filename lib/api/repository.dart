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

  static Future<ListingResponse> subreddit(String name) async {
    return http
        .get('https://reddit.com/r/$name.json')
        .then((response) => serializers.deserializeWith(
            ListingResponse.serializer, json.decode(response.body)))
        .then((listings) => _filterOnlyPhotos(listings));
  }
}
