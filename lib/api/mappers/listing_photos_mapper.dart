import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';

class ListingPhotosMapper {
  static List<Photo> map(ListingResponse response) {
    return response.data.children
        .map((child) => Photo((b) => b
          ..id = child.data.name
          ..authorName = child.data.author
          ..subreddit = Subreddit((b) => b
                ..name = child.data.subreddit
                ..subscribed = false
                ..redditUrl = 'https://reddit.com/r/${child.data.subreddit}')
              .toBuilder()
          ..photoUrl = child.data.preview.images.first.resolutions.last.url
              .replaceAll('&amp;', '&')
          ..aspectRatio = child.data.preview.images.first.source.width /
              child.data.preview.images.first.source.height
          ..thumbnailUrl = child.data.thumbnail
          ..upvotes = child.data.score
          ..upvoted = child.data.likes ?? false
          ..redditUrl = 'https://reddit.com${child.data.permalink}'))
        .toList();
  }
}
