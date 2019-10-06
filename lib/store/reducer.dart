import 'package:reddigram/store/store.dart';

ReddigramState rootReducer(ReddigramState state, action) {
  return state.rebuild((b) => b
    ..authState.replace(authStateReducer(state.authState, action))
    ..preferences.replace(preferencesReducer(state.preferences, action))
    ..photos.replace(photosReducer(state.photos, action))
    ..feeds.replace(feedsReducer(state.feeds, action))
    ..subreddits.replace(subredditsReducer(state.subreddits, action))
    ..subscriptions.replace(subscriptionsReducer(state.subscriptions, action))
    ..suggestedSubscriptions.replace(
        suggestedSubscriptionsReducer(state.suggestedSubscriptions, action))
    ..subredditsSearch
        .replace(subredditsSearchReducer(state.subredditsSearch, action)));
}
