import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _refreshTokenKey = 'reddit_refresh_token';

void _loadUserData(Store<ReddigramState> store, String redditAccessToken,
    [Completer completer]) {
  final futures = <Future>[];

  futures.add(redditRepository
      .username()
      .then((username) => store.dispatch(SetUsername(username))));

  futures.add(reddigramRepository
      .authenticate(redditAccessToken)
      .then((_) => store.dispatch(fetchSubscribedSubreddits())));

  Future.wait(futures).whenComplete(() => completer?.complete());
}

ThunkAction<ReddigramState> authenticateUserFromStorage() {
  return (Store<ReddigramState> store) {
    SharedPreferences.getInstance().then((prefs) async {
      final refreshToken = prefs.getString(_refreshTokenKey);

      if (refreshToken != null) {
        final tokens = await redditRepository.refreshAccessToken(refreshToken);
        _loadUserData(store, tokens.accessToken);
      }
    });
  };
}

ThunkAction<ReddigramState> authenticateUserFromCode(String code,
    [Completer completer]) {
  return (Store<ReddigramState> store) async {
    final tokens = await redditRepository.retrieveTokens(code);
    SharedPreferences.getInstance().then(
        (prefs) => prefs.setString(_refreshTokenKey, tokens.refreshToken));

    _loadUserData(store, tokens.accessToken, completer);
  };
}

ThunkAction<ReddigramState> signUserOut([Completer completer]) {
  return (Store<ReddigramState> store) {
    redditRepository.clearTokens();
    SharedPreferences.getInstance()
        .then((prefs) => prefs.remove(_refreshTokenKey));

    reddigramRepository.clearToken();

    store.dispatch(SetUsername(null));
    store.dispatch(FetchedSubscribedSubreddits(['aww']));
    store.dispatch(fetchFreshFeed(completer));
  };
}

class SetUsername {
  final String username;

  SetUsername(this.username);
}
