import 'package:built_collection/built_collection.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltSet<String>> subscriptionsReducer = combineReducers([
  TypedReducer<BuiltSet<String>, FetchedSubscriptions>(_fetchedSubscriptions),
  TypedReducer<BuiltSet<String>, SubscribedSubreddit>(_subscribedSubreddit),
  TypedReducer<BuiltSet<String>, UnsubscribedSubreddit>(_unsubscribedSubreddit),
]);

BuiltSet<String> _fetchedSubscriptions(
    BuiltSet<String> state, FetchedSubscriptions action) {
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
