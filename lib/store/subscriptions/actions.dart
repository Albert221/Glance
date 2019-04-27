import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchSubscribedSubreddits([Completer completer]) {
  return (Store<ReddigramState> store) {
    reddigramRepository.fetchSubscribedSubreddits().then((subreddits) {
      store.dispatch(FetchedSubscribedSubreddits(subreddits));
      store.dispatch(fetchFreshFeed(completer));
    });
  };
}

ThunkAction<ReddigramState> subscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
    reddigramRepository.subscribeSubreddit(name).then((_) {
      store.dispatch(SubscribedSubreddit(name));
      store.dispatch(fetchFreshFeed());
    });
  };
}

ThunkAction<ReddigramState> unsubscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
    reddigramRepository.unsubscribeSubreddit(name).then((_) {
      store.dispatch(UnsubscribedSubreddit(name));
      store.dispatch(fetchFreshFeed());
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
