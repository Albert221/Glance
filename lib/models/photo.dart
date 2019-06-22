import 'package:built_value/built_value.dart';

part 'photo.g.dart';

abstract class Photo implements Built<Photo, PhotoBuilder> {
  String get id;

  String get authorName;

  String get subredditName;

  String get subredditId;

  PhotoMedia get source;

  PhotoMedia get fullImage;

  PhotoMedia get thumbnail;

  @nullable
  Video get video;

  bool get isVideo => video != null;

  int get upvotes;

  bool get upvoted;

  bool get nsfw;

  String get redditUrl;

  Photo._();

  factory Photo([updates(PhotoBuilder b)]) = _$Photo;
}

abstract class PhotoMedia implements Built<PhotoMedia, PhotoMediaBuilder> {
  String get url;

  int get width;

  int get height;

  double get aspectRatio => width / height;

  PhotoMedia._();

  factory PhotoMedia([updates(PhotoMediaBuilder b)]) = _$PhotoMedia;
}

abstract class Video implements Built<Video, VideoBuilder> {
  String get url;

  Video._();

  factory Video([updates(VideoBuilder b)]) = _$Video;
}
