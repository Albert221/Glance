import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subreddit_info_response.g.dart';

abstract class SubredditsInfoResponse
    implements Built<SubredditsInfoResponse, SubredditsInfoResponseBuilder> {
  BuiltList<SubredditInfoResponse> get items;

  SubredditsInfoResponse._();

  factory SubredditsInfoResponse([updates(SubredditsInfoResponseBuilder b)]) =
      _$SubredditsInfoResponse;

  static Serializer<SubredditsInfoResponse> get serializer =>
      _$subredditsInfoResponseSerializer;
}

abstract class SubredditInfoResponse
    implements Built<SubredditInfoResponse, SubredditInfoResponseBuilder> {
  String get id;

  String get name;

  bool get nsfw;

  String get iconUrl;

  String get primaryColor;

  SubredditInfoResponse._();

  factory SubredditInfoResponse([updates(SubredditInfoResponseBuilder b)]) =
      _$SubredditInfoResponse;

  static Serializer<SubredditInfoResponse> get serializer =>
      _$subredditInfoResponseSerializer;
}
