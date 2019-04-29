import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<AppTheme> themeReducer = combineReducers([
  TypedReducer<AppTheme, SetTheme>(_setTheme),
]);

AppTheme _setTheme(AppTheme state, SetTheme action) {
  return action.theme;
}
