import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltMap<String, Subreddit>> subredditsReducer = combineReducers([
  TypedReducer<BuiltMap<String, Subreddit>, FetchedSubreddits>(
      _fetchedSubreddits),
]);

BuiltMap<String, Subreddit> _fetchedSubreddits(
    BuiltMap<String, Subreddit> state, FetchedSubreddits action) {
  return state
      .rebuild((b) => action.subreddits.forEach((sub) => b[sub.id] = sub));
}
