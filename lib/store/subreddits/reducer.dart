import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltMap<String, SubredditInfo>> subredditsReducer = combineReducers([
  TypedReducer<BuiltMap<String, SubredditInfo>, FetchedSubredditInfo>(
      _fetchedSubredditInfo),
]);

BuiltMap<String, SubredditInfo> _fetchedSubredditInfo(
    BuiltMap<String, SubredditInfo> state, FetchedSubredditInfo action) {
  return state.rebuild((b) => b[action.info.name] = action.info);
}
