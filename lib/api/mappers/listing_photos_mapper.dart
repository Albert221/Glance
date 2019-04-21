import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';

class ListingPhotosMapper {
  static List<Photo> map(ListingResponse response) {
    return response.data.children
        .map((child) => Photo((b) => b
          ..authorName = child.data.author
          ..subreddit = Subreddit((b) => b
                ..name = child.data.subreddit
                ..subscribed = false
                ..redditUrl = 'https://reddit.com/r/${child.data.subreddit}')
              .toBuilder()
          ..photoUrl = child.data.preview.images.first.source.url
              .replaceAll('&amp;', '&')
          ..upvotes = child.data.score
          ..upvoted = false
          ..redditUrl = 'https://reddit.com${child.data.permalink}'))
        .toList();
  }
}
