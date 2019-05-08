import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';

class SubredditFeedMapper {
  static Feed map(SubredditResponse response) {
    final builder = FeedBuilder()..nsfw = response.data.nsfw;

    return builder.build();
  }
}
