import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authStateReducer = combineReducers([
  TypedReducer<AuthState, SetUsername>(_setUsername),
  TypedReducer<AuthState, SetAuthStatus>(_setAuthStatus),
]);

AuthState _setUsername(AuthState state, SetUsername action) {
  return state.rebuild((b) => b..username = action.username);
}

AuthState _setAuthStatus(AuthState state, SetAuthStatus action) {
  return state.rebuild((b) => b..status = action.status);
}
