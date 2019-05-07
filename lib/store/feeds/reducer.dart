import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltMap<String, Feed>> feedsReducer = combineReducers([
  TypedReducer<BuiltMap<String, Feed>, FetchedFreshFeed>(_fetchedFreshFeed),
  TypedReducer<BuiltMap<String, Feed>, FetchedMoreFeed>(_fetchedMoreFeed),
]);

BuiltMap<String, Feed> _fetchedFreshFeed(
    BuiltMap<String, Feed> state, FetchedFreshFeed action) {
  return state.rebuild((b) => b[action.name] = action.feed);
}

BuiltMap<String, Feed> _fetchedMoreFeed(
    BuiltMap<String, Feed> state, FetchedMoreFeed action) {
  return state.rebuild((b) => b.updateValue(action.name,
      (b) => b.rebuild((b) => b.photosIds.addAll(action.photosIds))));
}
