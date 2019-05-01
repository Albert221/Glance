import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<PreferencesState> preferencesReducer = combineReducers([
  TypedReducer<PreferencesState, SetTheme>(_setTheme),
]);

PreferencesState _setTheme(PreferencesState state, SetTheme action) {
  return state.rebuild((b) => b..theme = action.theme);
}
