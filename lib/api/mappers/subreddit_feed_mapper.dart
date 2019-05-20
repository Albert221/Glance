import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';

class SubredditFeedMapper {
  static Feed map(SubredditResponse response) {
    return Feed().rebuild((b) => b
      ..id = response.data.name
      ..name = response.data.displayName
      ..nsfw = response.data.nsfw ?? false
      ..primaryColor = response.data.primaryColor ?? ''
      ..iconUrl = response.data.iconUrl ?? '');
  }

  static List<Feed> mapList(SubredditListResponse response) {
    return response.data.children
        .skipWhile((feed) => feed.data.subredditType == 'private')
        .map(map)
        .toList();
  }
}
