import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'feed.g.dart';

abstract class Feed implements Built<Feed, FeedBuilder> {
  String get name;

  BuiltList<String> get photosIds;

  bool get photosLoaded;

  bool get nsfw;

  String get primaryColor;

  Color get primaryColorMapped {
    return primaryColor.isNotEmpty
        ? Color(int.parse('FF' + primaryColor.replaceAll('#', ''), radix: 16))
        : null;
  }

  String get iconUrl;

  Feed._();

  factory Feed([updates(FeedBuilder b)]) {
    return _$Feed._(
      name: '',
      photosIds: BuiltList<String>(),
      photosLoaded: false,
      nsfw: false,
      primaryColor: '',
      iconUrl: '',
    );
  }

  factory Feed.blank(String name) {
    return Feed().rebuild((b) => b..name = name);
  }
}
