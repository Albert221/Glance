import 'package:built_collection/built_collection.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltMap<String, BuiltList<String>>> feedsReducer = combineReducers([
  TypedReducer<BuiltMap<String, BuiltList<String>>, FetchedFreshFeed>(
      _fetchedFeed),
  TypedReducer<BuiltMap<String, BuiltList<String>>, FetchedMoreFeed>(
      _fetchedMoreFeed),
]);

BuiltMap<String, BuiltList<String>> _fetchedFeed(
    BuiltMap<String, BuiltList<String>> state, FetchedFreshFeed action) {
  return state.rebuild((b) => b[action.name] = BuiltList<String>(action.photosIds));
}

BuiltMap<String, BuiltList<String>> _fetchedMoreFeed(
    BuiltMap<String, BuiltList<String>> state, FetchedMoreFeed action) {
  return state.rebuild((b) => b.updateValue(
      action.name, (b) => b.rebuild((b) => b.addAll(action.photosIds))));
}