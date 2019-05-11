import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _refreshTokenKey = 'reddit_refresh_token';

void _loadUserData(Store<ReddigramState> store, String redditAccessToken) {
  final futures = <Future>[];

  futures.add(redditRepository
      .username()
      .then((username) => store.dispatch(SetUsername(username))));

  final completer = Completer();
  futures.add(completer.future);
  futures.add(reddigramRepository.authenticate(redditAccessToken).then(
        (_) => store.dispatch(fetchSubscribedSubreddits(completer)),
        onError: (_) => completer.complete(),
      ));

  Future.wait(futures).then(
    (_) => store.dispatch(SetAuthStatus(AuthStatus.authenticated)),
    onError: (_) => store.dispatch(SetAuthStatus(AuthStatus.guest)),
  );
}

ThunkAction<ReddigramState> loadUser() {
  return (Store<ReddigramState> store) {
    SharedPreferences.getInstance().then((prefs) async {
      final refreshToken = prefs.getString(_refreshTokenKey);

      if (refreshToken != null) {
        store.dispatch(SetAuthStatus(AuthStatus.authenticating));

        final tokens = await redditRepository.refreshAccessToken(refreshToken);
        _loadUserData(store, tokens.accessToken);
      } else {
        store.dispatch(SetAuthStatus(AuthStatus.guest));
      }
    });
  };
}

ThunkAction<ReddigramState> authenticateUserFromCode(String code) {
  return (Store<ReddigramState> store) async {
    store.dispatch(SetAuthStatus(AuthStatus.authenticating));

    final tokens = await redditRepository.retrieveTokens(code);
    SharedPreferences.getInstance().then(
        (prefs) => prefs.setString(_refreshTokenKey, tokens.refreshToken));

    _loadUserData(store, tokens.accessToken);
  };
}

ThunkAction<ReddigramState> signUserOut() {
  return (Store<ReddigramState> store) {
    store.dispatch(SetAuthStatus(AuthStatus.signingOut));

    redditRepository.clearTokens();
    SharedPreferences.getInstance()
        .then((prefs) => prefs.remove(_refreshTokenKey));

    reddigramRepository.clearToken();

    store.dispatch(SetUsername(null));
    store.dispatch(FetchedSubscribedSubreddits([]));

    final completer = Completer()
      ..future
          .whenComplete(() => store.dispatch(SetAuthStatus(AuthStatus.guest)));
    store.dispatch(fetchFreshFeed(BEST_SUBSCRIBED, completer: completer));
  };
}

class SetUsername {
  final String username;

  SetUsername(this.username);
}

class SetAuthStatus {
  final AuthStatus status;

  SetAuthStatus(this.status);
}
