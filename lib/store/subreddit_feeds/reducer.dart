import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltMap<String, BuiltList<Photo>>> subredditFeeds = combineReducers([
  TypedReducer<BuiltMap<String, BuiltList<Photo>>, FetchedSubreddit>(
      _fetchedSubreddit),
  TypedReducer<BuiltMap<String, BuiltList<Photo>>, FetchedMoreSubreddit>(
      _fetchedMoreSubreddit),
]);

BuiltMap<String, BuiltList<Photo>> _fetchedSubreddit(
    BuiltMap<String, BuiltList<Photo>> state, FetchedSubreddit action) {
  return state.rebuild((b) => b[action.name] = BuiltList<Photo>(action.photos));
}

BuiltMap<String, BuiltList<Photo>> _fetchedMoreSubreddit(
    BuiltMap<String, BuiltList<Photo>> state, FetchedMoreSubreddit action) {
  return state.rebuild((b) => b.updateValue(
      action.name, (b) => b.rebuild((b) => b.addAll(action.photos))));
}