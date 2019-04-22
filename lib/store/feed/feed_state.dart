import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:reddigram/models/models.dart';

part 'feed_state.g.dart';

abstract class FeedState implements Built<FeedState, FeedStateBuilder> {
  BuiltList<Photo> get photos;

  bool get fetching;

  FeedState._();

  factory FeedState([updates(FeedStateBuilder b)]) {
    return _$FeedState._(
      photos: BuiltList<Photo>(),
      fetching: false,
    );
  }
}
