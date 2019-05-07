import 'package:built_collection/built_collection.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltSet<String>> subscriptionsReducer = combineReducers([
  TypedReducer<BuiltSet<String>, FetchedSubscribedSubreddits>(
      _fetchedSubscribedSubreddits),
  TypedReducer<BuiltSet<String>, SubscribedSubreddit>(_subscribedSubreddit),
  TypedReducer<BuiltSet<String>, UnsubscribedSubreddit>(_unsubscribedSubreddit),
]);

BuiltSet<String> _fetchedSubscribedSubreddits(
    BuiltSet<String> state, FetchedSubscribedSubreddits action) {
  return BuiltSet(action.subreddits);
}

BuiltSet<String> _subscribedSubreddit(
    BuiltSet<String> state, SubscribedSubreddit action) {
  return state.rebuild((b) => b.add(action.name));
}

BuiltSet<String> _unsubscribedSubreddit(
    BuiltSet<String> state, UnsubscribedSubreddit action) {
  return state.rebuild((b) =>
      b.removeWhere((sub) => sub.toLowerCase() == action.name.toLowerCase()));
}
