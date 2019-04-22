import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<FeedState> feedStateReducer = combineReducers([
  TypedReducer<FeedState, SetFeedFetching>(_setFeedFetching),
  TypedReducer<FeedState, AddMoreFeed>(_addMoreFeed),
]);

FeedState _setFeedFetching(FeedState state, SetFeedFetching action) {
  return state.rebuild((b) => b..fetching = action.fetching);
}

FeedState _addMoreFeed(FeedState state, AddMoreFeed action) {
  return state.rebuild((b) => b
    ..photos = BuiltList<Photo>([]..addAll(state.photos)..addAll(action.photos))
        .toBuilder());
}
