import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<FeedState> feedStateReducer = combineReducers([
  TypedReducer<FeedState, SetFeedFetching>(_setFeedFetching),
  TypedReducer<FeedState, FetchedFeed>(_fetchedFeed),
  TypedReducer<FeedState, FetchedMoreFeed>(_fetchedMoreFeed),
  TypedReducer<FeedState, PhotoUpvoted>(_photoUpvoted),
  TypedReducer<FeedState, PhotoUpvoteCanceled>(_photoUpvoteCanceled),
]);

FeedState _setFeedFetching(FeedState state, SetFeedFetching action) {
  return state.rebuild((b) => b..fetching = action.fetching);
}

FeedState _fetchedFeed(FeedState state, FetchedFeed action) {
  return state
      .rebuild((b) => b..photos = BuiltList<Photo>(action.photos).toBuilder());
}

FeedState _fetchedMoreFeed(FeedState state, FetchedMoreFeed action) {
  return state.rebuild((b) => b
    ..photos = BuiltList<Photo>([]..addAll(state.photos)..addAll(action.photos))
        .toBuilder());
}

FeedState _photoUpvoted(FeedState state, PhotoUpvoted action) {
  return state.rebuild((b) => b.photos.replace(state.photos.map((photo) =>
      photo.id == action.id
          ? photo.rebuild((b) => b..upvoted = true)
          : photo)));
}

FeedState _photoUpvoteCanceled(FeedState state, PhotoUpvoteCanceled action) {
  return state.rebuild((b) => b.photos.replace(state.photos.map((photo) =>
      photo.id == action.id
          ? photo.rebuild((b) => b..upvoted = false)
          : photo)));
}
