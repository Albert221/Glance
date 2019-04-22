import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> authenticateUser(String accessToken) {
  return (Store<ReddigramState> store) {
    store.dispatch(SetAccessToken(accessToken));
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