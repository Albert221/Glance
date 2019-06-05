import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'feed.g.dart';

abstract class Feed implements Built<Feed, FeedBuilder> {
  String get name;

  BuiltList<String> get photosIds;

  Feed._();

  factory Feed([updates(FeedBuilder b)]) {
    return _$Feed._(
          name: '',
          photosIds: BuiltList<String>(),
        )
        .rebuild(updates);
  }

  factory Feed.blank(String name) {
    return Feed().rebuild((b) => b..name = name);
  }
}
