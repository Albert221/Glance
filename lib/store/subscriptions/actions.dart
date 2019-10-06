import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchSubscriptions([Completer completer]) {
  return (Store<ReddigramState> store) {
    apiRepository.fetchSubscriptions().then((subreddits) async {
      final completer = Completer();
      store.dispatch(fetchSubreddits(subreddits, completer: completer));
      await completer.future;

      store.dispatch(FetchedSubscriptions(subreddits));
    }).whenComplete(() => completer.complete());
  };
}

ThunkAction<ReddigramState> subscribeSubreddit(String id) {
  return (Store<ReddigramState> store) {
    apiRepository.subscribeSubreddit(id).then((_) {
      store.dispatch(SubscribedSubreddit(id));
      store.dispatch(fetchFreshFeed(NEW_SUBSCRIBED));
      store.dispatch(fetchFreshFeed(BEST_SUBSCRIBED));
    });
  };
}

ThunkAction<ReddigramState> unsubscribeSubreddit(String id) {
  return (Store<ReddigramState> store) {
    apiRepository.unsubscribeSubreddit(id).then((_) {
      store.dispatch(UnsubscribedSubreddit(id));
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
