import 'dart:ui';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subreddit.g.dart';

abstract class Subreddit implements Built<Subreddit, SubredditBuilder> {
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

  String get submissionType;

  Subreddit._();

  factory Subreddit([updates(SubredditBuilder b)]) {
    return _$Subreddit
        ._(
          id: '',
          name: '',
          nsfw: false,
          primaryColor: '',
          iconUrl: '',
          submissionType: '',
        )
        .rebuild(updates);
  }

  static Serializer<Subreddit> get serializer => _$subredditSerializer;
}
