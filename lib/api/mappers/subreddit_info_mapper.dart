import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';

class SubredditInfoMapper {
  static SubredditInfo map(SubredditInfoResponse response) {
    return SubredditInfo((b) => b
      ..id = response.id
      ..name = response.name
      ..nsfw = response.nsfw
      ..primaryColor = response.primaryColor
      ..iconUrl = response.iconUrl);
  }

  static SubredditInfo mapSubredditResponse(SubredditResponse response) {
    return SubredditInfo((b) => b
      ..id = response.data.name
      ..name = response.data.displayName
      ..nsfw = response.data.nsfw ?? false
      ..primaryColor = response.data.primaryColor ?? ''
      ..iconUrl = response.data.iconUrl ?? '');
  }

  static List<SubredditInfo> mapSubredditResponseList(
      SubredditListResponse response) {
    return response.data.children
        .skipWhile((feed) => feed.data.subredditType == 'private')
        .map(mapSubredditResponse)
        .toList();
  }
}
