import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'feed.g.dart';

abstract class Feed implements Built<Feed, FeedBuilder> {
  BuiltList<String> get photosIds;

  bool get nsfw;

  Feed._();

  factory Feed([updates(FeedBuilder b)]) {
    return _$Feed._(
      photosIds: BuiltList<String>(),
      nsfw: false,
    );
  }
}
