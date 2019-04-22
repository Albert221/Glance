import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authStateReducer = combineReducers([
  TypedReducer<AuthState, SetAccessToken>(_setAccessToken),
  TypedReducer<AuthState, SetUsername>(_setUsername),
]);

AuthState _setAccessToken(AuthState state, SetAccessToken action) {
  return state.rebuild((b) => b..accessToken = action.accessToken);
}

AuthState _setUsername(AuthState state, SetUsername action) {
  return state.rebuild((b) => b..username = action.username);
}
