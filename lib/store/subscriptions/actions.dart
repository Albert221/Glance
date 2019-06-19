import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchSubscriptions([Completer completer]) {
  return (Store<ReddigramState> store) {
    apiRepository.fetchSubscriptions().then((subreddits) {
      // Fetch subreddits' data from cache for feeds not existing in state.
      // That's because we want to have all metadata of subscribed subreddits,
      // but it's impossible to fetch this data from Reddit API in a single
      // request. We just cache that metadata on every fetch and retrieve it
      // here.
      store.dispatch(fetchSubreddits(subreddits));
      store.dispatch(FetchedSubscriptions(subreddits));
    }).whenComplete(() => completer.complete());
  };
}

ThunkAction<ReddigramState> subscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
    apiRepository.subscribeSubreddit(name).then((_) {
      store.dispatch(SubscribedSubreddit(name));
      store.dispatch(fetchFreshFeed(NEW_SUBSCRIBED));
      store.dispatch(fetchFreshFeed(BEST_SUBSCRIBED));
    });
  };
}

ThunkAction<ReddigramState> unsubscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
    apiRepository.unsubscribeSubreddit(name).then((_) {
      store.dispatch(UnsubscribedSubreddit(name));
      store.dispatch(fetchFreshFeed(NEW_SUBSCRIBED));
      store.dispatch(fetchFreshFeed(BEST_SUBSCRIBED));
    });
  };
}

class FetchedSubscriptions {
  final List<String> subreddits;

  FetchedSubscriptions(this.subreddits);
}

class SubscribedSubreddit {
  final String name;

  SubscribedSubreddit(this.name);
}

class UnsubscribedSubreddit {
  final String name;

  UnsubscribedSubreddit(this.name);
}
