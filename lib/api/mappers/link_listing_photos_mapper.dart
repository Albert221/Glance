import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';

class LinkListingPhotosMapper {
  static List<Photo> map(LinkListingResponse response) {
    return response.data.children
        .map((child) => Photo((b) => b
          ..id = child.data.name
          ..authorName = child.data.author
          ..subredditName = child.data.subreddit
          ..source = PhotoMedia((b) => b
                ..url = child.data.preview.images.first.source.url
                    .replaceAll('&amp;', '&')
                ..width = child.data.preview.images.first.source.width
                ..height = child.data.preview.images.first.source.height)
              .toBuilder()
          ..fullImage = _fullImage(child)
          ..thumbnail = child.data.thumbnail != 'nsfw'
              ? PhotoMedia((b) => b
                ..url = child.data.thumbnail
                ..width = child.data.thumbnailWidth ?? 1
                ..height = child.data.thumbnailHeight ?? 1).toBuilder()
              : _fullImage(child)
          ..upvotes = child.data.score
          ..upvoted = child.data.likes ?? false
          ..nsfw = child.data.over18
          ..redditUrl = 'https://reddit.com${child.data.permalink}'))
        .toList();
  }

  static PhotoMediaBuilder _fullImage(LinkChild child) {
    return PhotoMedia((b) => b
          ..url = child.data.preview.images.first.resolutions.last.url
              .replaceAll('&amp;', '&')
          ..width = child.data.preview.images.first.resolutions.last.width
          ..height = child.data.preview.images.first.resolutions.last.height)
        .toBuilder();
  }
}
