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
  final subscriptions = store.state.subscriptions;
  final subscribedSubsNames =
      subscriptions.map((id) => store.state.subreddits[id].name);

  switch (feed) {
    case POPULAR:
      return '/r/popular';
    case NEW_SUBSCRIBED:
      return subscriptions.isEmpty
          ? '_EMPTY'
          : 'r/' + subscribedSubsNames.join('+') + '/new';
    case BEST_SUBSCRIBED:
      return subscriptions.isEmpty
          ? '_EMPTY'
          : 'r/' + subscribedSubsNames.join('+');
    default:
      return feed;
  }
}

ThunkAction<ReddigramState> fetchFreshFeed(String feedName,
    {int limit, Completer completer}) {
  return (Store<ReddigramState> store) {
    redditRepository
        .feed(_getProperFeedName(store, feedName), limit: limit)
        .then((photos) async {
      store.dispatch(FetchedPhotos(photos));

      final subredditIds = photos.map((photo) => photo.subredditId).toList();
      final subredditCompleter = Completer();
      store.dispatch(
          fetchSubreddits(subredditIds, completer: subredditCompleter));

      await subredditCompleter.future;

      // If this feed is a subreddit, set feed's name to the subreddit's name
      // (thanks to this, feed has the same capitalization as the subreddit)
      if (isSubreddit(feedName)) {
        final subreditName = feedName.substring(2);

        feedName = 'r/' +
            store.state.subreddits.entries
                .firstWhere((entry) =>
                    entry.value.name.toLowerCase() ==
                    subreditName.toLowerCase())
                .value
                .name;
      }

      final feed = Feed((b) => b
        ..name = feedName
        ..photosIds.replace(photosIds(photos)));

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
        .then((photos) async {
      store.dispatch(FetchedPhotos(photos));
      store.dispatch(FetchedMoreFeed(feedName, photosIds(photos)));

      final subredditIds = photos.map((photo) => photo.subredditId).toList();
      final subredditCompleter = Completer();
      store.dispatch(
          fetchSubreddits(subredditIds, completer: subredditCompleter));
      await subredditCompleter.future;
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
