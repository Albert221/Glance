import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThunkAction<ReddigramState> loadTheme() {
  return (Store<ReddigramState> store) async {
    final theme = (await SharedPreferences.getInstance()).getString("theme");

    store.dispatch(SetTheme(theme == "dark" ? AppTheme.dark : AppTheme.light));
  };
}

ThunkAction<ReddigramState> setTheme(AppTheme theme) {
  return (Store<ReddigramState> store) async {
    (await SharedPreferences.getInstance())
        .setString("theme", theme.toString());

    store.dispatch(SetTheme(theme));
  };
}

class SetTheme {
  final AppTheme theme;

  SetTheme(this.theme);
}
