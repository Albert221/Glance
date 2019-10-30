import 'package:reddigram/api/response_models/response_models.dart';
import 'package:reddigram/models/models.dart' as models;

class SubredditInfoMapper {
  static models.Subreddit map(SubredditResponse response) {
    return models.Subreddit((b) => b
      ..id = response.data.name
      ..name = response.data.displayName
      ..nsfw = response.data.nsfw ?? false
      ..primaryColor = response.data.primaryColor ?? ''
      ..iconUrl = response.data.iconUrl ?? ''
      ..submissionType = response.data.submissionType ?? '');
  }

  static List<models.Subreddit> mapList(SubredditListResponse response) {
    return response.data.children
        .skipWhile((feed) => feed.data.subredditType == 'private')
        .map(map)
        .toList();
  }
}
