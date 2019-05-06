import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltList<Subreddit>> subredditFeeds = combineReducers([
  TypedReducer<BuiltList<Subreddit>, FetchedSubreddit>(_fetchedSubreddit),
  TypedReducer<BuiltList<Subreddit>, FetchedMoreSubreddit>(
      _fetchedMoreSubreddit),
]);

BuiltList<Subreddit> _fetchedSubreddit(
    BuiltList<Subreddit> state, FetchedSubreddit action) {
  return state.rebuild((b) => b
    ..removeWhere((subreddit) => subreddit.name == action.subreddit.name)
    ..add(action.subreddit));
}

BuiltList<Subreddit> _fetchedMoreSubreddit(
    BuiltList<Subreddit> state, FetchedMoreSubreddit action) {
  return state.rebuild((b) => b.map((subreddit) =>
      subreddit.name == action.subredditName
          ? subreddit.rebuild((b) => b.photos.addAll(action.photos))
          : subreddit));
}
