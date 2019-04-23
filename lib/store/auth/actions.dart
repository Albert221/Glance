import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> authenticateUser(String accessToken,
    [Completer completer]) {
  return (Store<ReddigramState> store) async {
    store.dispatch(SetAccessToken(accessToken));

    apiRepository.accessToken = accessToken;
    final futures = <Future>[];

    futures.add(apiRepository
        .username()
        .then((username) => store.dispatch(SetUsername(username))));

    // todo: authenticate to subscriptions database and then fetch:
    store.dispatch(fetchSubscribedSubreddits());

    store.dispatch(fetchFreshFeed());

    Future.wait(futures).whenComplete(() => completer?.complete());
  };
}

class SetAccessToken {
  final String accessToken;

  SetAccessToken(this.accessToken);
}

class SetUsername {
  final String username;

  SetUsername(this.username);
}

class SetSubscribedSubreddits {
  final List<Subreddit> subreddits;

  SetSubscribedSubreddits(this.subreddits);
}
