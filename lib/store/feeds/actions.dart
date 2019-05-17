import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/photos/actions.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

const POPULAR = 'POPULAR';
const NEW_SUBSCRIBED = 'NEW_SUBSCRIBED';
const BEST_SUBSCRIBED = 'BEST_SUBSCRIBED';

bool isSubreddit(String feed) => feed.contains(RegExp(r'^r\/'));

String _getProperFeedName(Store<ReddigramState> store, String feed) {
  switch (feed) {
    case POPULAR:
      return '/r/popular';
    case NEW_SUBSCRIBED:
      return store.state.subscriptions.isEmpty
          ? '_EMPTY'
          : 'r/' + store.state.subscriptions.join('+') + '/new';
    case BEST_SUBSCRIBED:
      return store.state.subscriptions.isEmpty
          ? '_EMPTY'
          : 'r/' + store.state.subscriptions.join('+');
    default:
      return feed;
  }
}

ThunkAction<ReddigramState> fetchFreshFeed(String feedName,
    {int limit, Completer completer}) {
  return (Store<ReddigramState> store) {
    final futures = <Future>[
      redditRepository.feed(_getProperFeedName(store, feedName), limit: limit),
      if (isSubreddit(feedName))
        redditRepository.subreddit(feedName.substring(2)),
    ];

    Future.wait(futures).then((results) {
      final photos = results[0] as List<Photo>;

      store.dispatch(FetchedPhotos(photos));

      final feedBuilder = FeedBuilder()
        ..photosIds.replace(photosIds(photos))
        ..nsfw = results.length == 2 ? (results[1] as Feed).nsfw : false;
      final feed = feedBuilder.build();

      store.dispatch(FetchedFreshFeed(feedName, feed));
    }).whenComplete(() => completer?.complete());
  };
}

ThunkAction<ReddigramState> fetchMoreFeed(String feedName,
    {int limit, Completer completer}) {
  return (Store<ReddigramState> store) {
    final feed = store.state.feeds[feedName];
    final after = feed.photosIds.isEmpty ? '' : feed.photosIds.last;

    redditRepository
        .feed(_getProperFeedName(store, feedName), after: after, limit: limit)
        .then((photos) {
      store.dispatch(FetchedPhotos(photos));
      store.dispatch(FetchedMoreFeed(feedName, photosIds(photos)));
    }).whenComplete(() => completer?.complete());
  };
}

class FetchedFreshFeed {
  final String name;
  final Feed feed;

  FetchedFreshFeed(this.name, this.feed);
}

class FetchedMoreFeed {
  final String name;
  final List<String> photosIds;

  FetchedMoreFeed(this.name, this.photosIds);
}
