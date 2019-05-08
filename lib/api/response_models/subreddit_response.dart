import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subreddit_response.g.dart';

abstract class SubredditResponse
    implements Built<SubredditResponse, SubredditResponseBuilder> {
  Subreddit get data;

  SubredditResponse._();

  factory SubredditResponse([updates(SubredditResponseBuilder b)]) =
      _$SubredditResponse;

  static Serializer<SubredditResponse> get serializer =>
      _$subredditResponseSerializer;
}

abstract class Subreddit implements Built<Subreddit, SubredditBuilder> {
  @BuiltValueField(wireName: 'over18')
  bool get nsfw;

  Subreddit._();

  factory Subreddit([updates(SubredditBuilder b)]) = _$Subreddit;

  static Serializer<Subreddit> get serializer => _$subredditSerializer;
}
