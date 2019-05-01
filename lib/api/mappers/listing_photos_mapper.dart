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
          ..source = PhotoMedia((b) => b
                ..url = child.data.preview.images.first.source.url
                    .replaceAll('&amp;', '&')
                ..width = child.data.preview.images.first.source.width
                ..height = child.data.preview.images.first.source.height)
              .toBuilder()
          ..fullImage = PhotoMedia((b) => b
                ..url = child.data.preview.images.first.resolutions.last.url
                    .replaceAll('&amp;', '&')
                ..width = child.data.preview.images.first.resolutions.last.width
                ..height =
                    child.data.preview.images.first.resolutions.last.height)
              .toBuilder()
          ..thumbnail = PhotoMedia((b) => b
            ..url = child.data.thumbnail
            ..width = child.data.thumbnailWidth ?? 1
            ..height = child.data.thumbnailHeight ?? 1).toBuilder()
          ..upvotes = child.data.score
          ..upvoted = child.data.likes ?? false
          ..nsfw = child.data.over18
          ..redditUrl = 'https://reddit.com${child.data.permalink}'))
        .toList();
  }
}
