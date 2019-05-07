import 'package:built_collection/built_collection.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/photos/actions.dart';
import 'package:redux/redux.dart';

List<String> photosIds(Iterable<Photo> photos) =>
    photos.map((photo) => photo.id).toList();

Reducer<BuiltMap<String, Photo>> photosReducer = combineReducers([
  TypedReducer<BuiltMap<String, Photo>, FetchedPhotos>(_fetchedPhotos),
  TypedReducer<BuiltMap<String, Photo>, PhotoUpvoted>(_photoUpvoted),
  TypedReducer<BuiltMap<String, Photo>, PhotoUpvoteCanceled>(
      _photoUpvoteCanceled),
]);

BuiltMap<String, Photo> _fetchedPhotos(
    BuiltMap<String, Photo> state, FetchedPhotos action) {
  return state
      .rebuild((b) => b.addIterable(action.photos, key: (photo) => photo.id));
}

BuiltMap<String, Photo> _photoUpvoted(
    BuiltMap<String, Photo> state, PhotoUpvoted action) {
  return state.rebuild((b) => b.updateValue(
      action.id,
      (photo) => photo.rebuild((b) => b
        ..upvoted = true
        ..upvotes = b.upvotes + 1)));
}

BuiltMap<String, Photo> _photoUpvoteCanceled(
    BuiltMap<String, Photo> state, PhotoUpvoteCanceled action) {
  return state.rebuild((b) => b.updateValue(
      action.id,
      (photo) => photo.rebuild((b) => b
        ..upvoted = false
        ..upvotes = b.upvotes - 1)));
}
