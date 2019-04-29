import 'package:reddigram/store/store.dart';

ReddigramState rootReducer(ReddigramState state, action) {
  return state.rebuild((b) => b
    ..authState.replace(authStateReducer(state.authState, action))
    ..theme = themeReducer(state.theme, action)
    ..feedState.replace(feedStateReducer(state.feedState, action))
    ..subscriptions.replace(subscriptionsReducer(state.subscriptions, action)));
}
