import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'subreddit_response.g.dart';

abstract class SubredditListResponse
    implements Built<SubredditListResponse, SubredditListResponseBuilder> {
  SubredditListData get data;

  SubredditListResponse._();

  factory SubredditListResponse([updates(SubredditListResponseBuilder b)]) =
      _$SubredditListResponse;

  static Serializer<SubredditListResponse> get serializer =>
      _$subredditListResponseSerializer;
}

abstract class SubredditListData
    implements Built<SubredditListData, SubredditListDataBuilder> {
  BuiltList<SubredditResponse> get children;

  SubredditListData._();

  factory SubredditListData([updates(SubredditListDataBuilder b)]) =
      _$SubredditListData;

  static Serializer<SubredditListData> get serializer =>
      _$subredditListDataSerializer;
}

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
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @BuiltValueField(wireName: 'over18')
  @nullable
  bool get nsfw;

  @BuiltValueField(wireName: 'primary_color')
  @nullable
  String get primaryColor;

  @BuiltValueField(wireName: 'icon_img')
  @nullable
  String get iconUrl;

  @BuiltValueField(wireName: 'subreddit_type')
  String get subredditType;

  Subreddit._();

  factory Subreddit([updates(SubredditBuilder b)]) = _$Subreddit;

  static Serializer<Subreddit> get serializer => _$subredditSerializer;
}
