import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'link_listing_response.g.dart';

abstract class LinkListingResponse
    implements Built<LinkListingResponse, LinkListingResponseBuilder> {
  LinkListingData get data;

  LinkListingResponse._();

  factory LinkListingResponse([updates(LinkListingResponseBuilder b)]) =
      _$LinkListingResponse;

  static Serializer<LinkListingResponse> get serializer =>
      _$linkListingResponseSerializer;
}

abstract class LinkListingData
    implements Built<LinkListingData, LinkListingDataBuilder> {
  @nullable
  String get after;

  @nullable
  String get before;

  BuiltList<LinkChild> get children;

  LinkListingData._();

  factory LinkListingData([updates(LinkListingDataBuilder b)]) =
      _$LinkListingData;

  static Serializer<LinkListingData> get serializer =>
      _$linkListingDataSerializer;
}

abstract class LinkChild implements Built<LinkChild, LinkChildBuilder> {
  LinkChildData get data;

  LinkChild._();

  factory LinkChild([updates(LinkChildBuilder b)]) = _$LinkChild;

  static Serializer<LinkChild> get serializer => _$linkChildSerializer;
}

abstract class LinkChildData
    implements Built<LinkChildData, LinkChildDataBuilder> {
  String get name;

  String get title;

  String get subreddit;

  @BuiltValueField(wireName: 'subreddit_id')
  String get subredditId;

  String get permalink;

  String get author;

  int get score;

  @nullable
  bool get likes;

  String get thumbnail;

  @BuiltValueField(wireName: 'thumbnail_width')
  @nullable
  int get thumbnailWidth;

  @BuiltValueField(wireName: 'thumbnail_height')
  @nullable
  int get thumbnailHeight;

  @BuiltValueField(wireName: 'over_18')
  bool get over18;

  @nullable
  Preview get preview;

  @nullable
  Media get media;

  @BuiltValueField(wireName: 'is_video')
  bool get isVideo;

  LinkChildData._();

  factory LinkChildData([updates(LinkChildDataBuilder b)]) = _$LinkChildData;

  static Serializer<LinkChildData> get serializer => _$linkChildDataSerializer;
}

abstract class Preview implements Built<Preview, PreviewBuilder> {
  BuiltList<PreviewImage> get images;

  @BuiltValueField(wireName: 'reddit_video_preview')
  @nullable
  RedditVideo get redditVideoPreview;

  Preview._();

  factory Preview([updates(PreviewBuilder b)]) = _$Preview;

  static Serializer<Preview> get serializer => _$previewSerializer;
}

abstract class PreviewImage
    implements Built<PreviewImage, PreviewImageBuilder> {
  Image get source;

  BuiltList<Image> get resolutions;

  PreviewImage._();

  factory PreviewImage([updates(PreviewImageBuilder b)]) = _$PreviewImage;

  static Serializer<PreviewImage> get serializer => _$previewImageSerializer;
}

abstract class Image implements Built<Image, ImageBuilder> {
  String get url;

  int get width;

  int get height;

  Image._();

  factory Image([updates(ImageBuilder b)]) = _$Image;

  static Serializer<Image> get serializer => _$imageSerializer;
}

abstract class Media implements Built<Media, MediaBuilder> {
  @BuiltValueField(wireName: 'reddit_video')
  @nullable
  RedditVideo get redditVideo;

  Media._();

  factory Media([updates(MediaBuilder b)]) = _$Media;

  static Serializer<Media> get serializer => _$mediaSerializer;
}

abstract class RedditVideo implements Built<RedditVideo, RedditVideoBuilder> {
  @BuiltValueField(wireName: 'fallback_url')
  String get fallbackUrl;

  RedditVideo._();

  factory RedditVideo([updates(RedditVideoBuilder b)]) = _$RedditVideo;

  static Serializer<RedditVideo> get serializer => _$redditVideoSerializer;
}
