import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<PreferencesState> preferencesReducer = combineReducers([
  TypedReducer<PreferencesState, SetTheme>(_setTheme),
  TypedReducer<PreferencesState, SetShowNsfw>(_setShowNsfw),
]);

PreferencesState _setTheme(PreferencesState state, SetTheme action) {
  return state.rebuild((b) => b..theme = action.theme);
}

PreferencesState _setShowNsfw(PreferencesState state, SetShowNsfw action) {
  return state.rebuild((b) => b..showNsfw = action.showNsfw);
}
