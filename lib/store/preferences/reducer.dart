import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<PreferencesState> preferencesReducer = combineReducers([
  TypedReducer<PreferencesState, SetPreferencesBulk>(_setPreferencesBulk),
  TypedReducer<PreferencesState, SetTheme>(_setTheme),
  TypedReducer<PreferencesState, SetShowNsfw>(_setShowNsfw),
  TypedReducer<PreferencesState, SetCutLongPhotos>(_setCutLongPhotos),
]);

PreferencesState _setPreferencesBulk(
    PreferencesState state, SetPreferencesBulk action) {
  return action.preferences;
}

PreferencesState _setTheme(PreferencesState state, SetTheme action) {
  return state.rebuild((b) => b..theme = action.theme);
}

PreferencesState _setShowNsfw(PreferencesState state, SetShowNsfw action) {
  return state.rebuild((b) => b..showNsfw = action.showNsfw);
}

PreferencesState _setCutLongPhotos(
    PreferencesState state, SetCutLongPhotos action) {
  return state.rebuild((b) => b..cutLongPhotos = action.cutLongPhotos);
}
