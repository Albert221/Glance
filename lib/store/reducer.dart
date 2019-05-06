import 'package:reddigram/store/store.dart';

ReddigramState rootReducer(ReddigramState state, action) {
  return state.rebuild((b) => b
    ..authState.replace(authStateReducer(state.authState, action))
    ..preferences.replace(preferencesReducer(state.preferences, action))
    ..feedState.replace(feedStateReducer(state.feedState, action))
    ..subredditFeeds.replace(subredditFeeds(state.subredditFeeds, action))
    ..subscriptions.replace(subscriptionsReducer(state.subscriptions, action)));
}
