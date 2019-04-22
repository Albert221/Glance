import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<FeedState> feedStateReducer = combineReducers([
  TypedReducer<FeedState, SetFeedFetching>(_setFeedFetching),
  TypedReducer<FeedState, SetFeed>(_setFeed),
  TypedReducer<FeedState, AddMoreFeed>(_addMoreFeed),
]);

FeedState _setFeedFetching(FeedState state, SetFeedFetching action) {
  return state.rebuild((b) => b..fetching = action.fetching);
}

FeedState _setFeed(FeedState state, SetFeed action) {
  return state
      .rebuild((b) => b..photos = BuiltList<Photo>(action.photos).toBuilder());
}

FeedState _addMoreFeed(FeedState state, AddMoreFeed action) {
  return state.rebuild((b) => b
    ..photos = BuiltList<Photo>([]..addAll(state.photos)..addAll(action.photos))
        .toBuilder());
}
