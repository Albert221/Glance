import 'dart:ui';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subreddit_info.g.dart';

abstract class SubredditInfo
    implements Built<SubredditInfo, SubredditInfoBuilder> {
  String get id;

  String get name;

  bool get nsfw;

  String get primaryColor;

  Color get primaryColorMapped {
    return primaryColor.isNotEmpty
        ? Color(int.parse('FF' + primaryColor.replaceAll('#', ''), radix: 16))
        : null;
  }

  String get iconUrl;

  SubredditInfo._();

  factory SubredditInfo([updates(SubredditInfoBuilder b)]) {
    return _$SubredditInfo
        ._(
          id: '',
          name: '',
          nsfw: false,
          primaryColor: '',
          iconUrl: '',
        )
        .rebuild(updates);
  }

  static Serializer<SubredditInfo> get serializer => _$subredditInfoSerializer;
}
