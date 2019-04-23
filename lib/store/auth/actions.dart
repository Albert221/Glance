import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> authenticateUser(String code,
    [Completer completer]) {
  return (Store<ReddigramState> store) async {
    await apiRepository.retrieveAccessToken(code);

    final futures = <Future>[];

    futures.add(apiRepository
        .username()
        .then((username) => store.dispatch(SetUsername(username))));

    // todo(Albert221): authenticate to subscriptions database and then fetch:
    store.dispatch(fetchSubscribedSubreddits());

    final freshFeedCompleter = Completer();
    futures.add(freshFeedCompleter.future);
    store.dispatch(fetchFreshFeed(freshFeedCompleter));

    Future.wait(futures).whenComplete(() => completer?.complete());
  };
}

class SetUsername {
  final String username;

  SetUsername(this.username);
}

class SetSubscribedSubreddits {
  final List<Subreddit> subreddits;

  SetSubscribedSubreddits(this.subreddits);
}
