import 'package:reddigram/api/response_models/response_models.dart';
import 'package:reddigram/models/models.dart';
import 'package:validators/validators.dart';

class LinkListingPhotosMapper {
  static List<Photo> map(LinkListingResponse response) {
    return response.data.children
        .map((child) {
          if (['self', 'spoiler'].contains(child.data.thumbnail) ||
              !isURL(child.data.thumbnail) && child.data.thumbnail != 'nsfw') {
            return null;
          }

          RedditVideo redditVideo;
          if (child.data.isVideo) {
            redditVideo = child.data.media?.redditVideo;
          } else {
            redditVideo = child.data.preview?.redditVideoPreview;
          }

          try {
            return Photo((b) => b
              ..id = child.data.name
              ..authorName = child.data.author
              ..subredditName = child.data.subreddit
              ..subredditId = child.data.subredditId
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
              ..video = redditVideo != null
                  ? Video((b) => b..url = redditVideo.fallbackUrl).toBuilder()
                  : null
              ..upvotes = child.data.score
              ..upvoted = child.data.likes ?? false
              ..nsfw = child.data.over18
              ..redditUrl = 'https://reddit.com${child.data.permalink}');
          } catch (e) {
            // Catch deserialization errors
            return null;
          }
        })
        .where((photo) => photo != null)
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
