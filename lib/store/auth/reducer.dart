import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<AuthState> authStateReducer = combineReducers([
  TypedReducer<AuthState, SetUsername>(_setUsername),
  TypedReducer<AuthState, SetInProgress>(_setInProgress),
]);

AuthState _setUsername(AuthState state, SetUsername action) {
  return state.rebuild((b) => b..username = action.username);
}

AuthState _setInProgress(AuthState state, SetInProgress action) {
  return state.rebuild((b) => b..inProgress = action.inProgress);
}
