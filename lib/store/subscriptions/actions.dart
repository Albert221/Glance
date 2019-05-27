import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchSubscribedSubreddits([Completer completer]) {
  return (Store<ReddigramState> store) {
    subscriptionRepository.fetchSubscribedSubreddits().then((subreddits) {
      // Fetch subreddits' data from cache for feeds not existing in state.
      // That's because we want to have all metadata of subscribed subreddits,
      // but it's impossible to fetch this data from Reddit API in a single
      // request. We just cache that metadata on every fetch and retrieve it
      // here.
      subredditCache.get(subreddits).then((feeds) {
        feeds.forEach((feed) {
          if (!store.state.feeds.containsKey('r/${feed.name}')) {
            store.dispatch(FetchedFreshFeed('r/${feed.name}', feed));
          }
        });
      });

      store.dispatch(FetchedSubscribedSubreddits(subreddits));
    }).whenComplete(() => completer.complete());
  };
}

ThunkAction<ReddigramState> subscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
    redditRepository.subreddit(name).then((feed) {
      subredditCache.put(feed);
    });

    subscriptionRepository.subscribeSubreddit(name).then((_) {
      store.dispatch(SubscribedSubreddit(name));
      store.dispatch(fetchFreshFeed(NEW_SUBSCRIBED));
      store.dispatch(fetchFreshFeed(BEST_SUBSCRIBED));
    });
  };
}

ThunkAction<ReddigramState> unsubscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
    subscriptionRepository.unsubscribeSubreddit(name).then((_) {
      store.dispatch(UnsubscribedSubreddit(name));
      store.dispatch(fetchFreshFeed(NEW_SUBSCRIBED));
      store.dispatch(fetchFreshFeed(BEST_SUBSCRIBED));
    });
  };
}

class FetchedSubscribedSubreddits {
  final List<String> subreddits;

  FetchedSubscribedSubreddits(this.subreddits);
}

class SubscribedSubreddit {
  final String name;

  SubscribedSubreddit(this.name);
}

class UnsubscribedSubreddit {
  final String name;

  UnsubscribedSubreddit(this.name);
}
