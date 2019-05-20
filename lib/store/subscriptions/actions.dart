import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchSubscribedSubreddits([Completer completer]) {
  return (Store<ReddigramState> store) {
    subscriptionRepository
        .fetchSubscribedSubreddits()
        .then((subreddits) {
          // TODO: Fetch feeds metadata from cache.

          store.dispatch(FetchedSubscribedSubreddits(subreddits));
        })
        .whenComplete(() => completer.complete());
  };
}

ThunkAction<ReddigramState> subscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
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
