import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'listing_response.g.dart';

abstract class ListingResponse
    implements Built<ListingResponse, ListingResponseBuilder> {
  ListingData get data;

  ListingResponse._();

  factory ListingResponse([updates(ListingResponseBuilder b)]) =
      _$ListingResponse;

  static Serializer<ListingResponse> get serializer =>
      _$listingResponseSerializer;
}

abstract class ListingData implements Built<ListingData, ListingDataBuilder> {
  @nullable
  String get after;

  @nullable
  String get before;

  BuiltList<Child> get children;

  ListingData._();

  factory ListingData([updates(ListingDataBuilder b)]) = _$ListingData;

  static Serializer<ListingData> get serializer => _$listingDataSerializer;
}

abstract class Child implements Built<Child, ChildBuilder> {
  ChildData get data;

  Child._();

  factory Child([updates(ChildBuilder b)]) = _$Child;

  static Serializer<Child> get serializer => _$childSerializer;
}

abstract class ChildData implements Built<ChildData, ChildDataBuilder> {
  String get name;

  String get title;

  String get subreddit;

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

  ChildData._();

  factory ChildData([updates(ChildDataBuilder b)]) = _$ChildData;

  static Serializer<ChildData> get serializer => _$childDataSerializer;
}

abstract class Preview implements Built<Preview, PreviewBuilder> {
  BuiltList<PreviewImage> get images;

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
