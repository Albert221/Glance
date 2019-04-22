import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> authenticateUser(String accessToken) {
  return (Store<ReddigramState> store) async {
    store.dispatch(SetAccessToken(accessToken));

    final repo = RedditRepository();
    repo.accessToken = accessToken;

    repo.username().then((username) => store.dispatch(SetUsername(username)));
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
