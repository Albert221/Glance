import 'package:built_value/built_value.dart';

part 'photo.g.dart';

abstract class Photo implements Built<Photo, PhotoBuilder> {
  String get id;

  String get authorName;

  String get subredditName;

  PhotoMedia get source;

  PhotoMedia get fullImage;

  PhotoMedia get thumbnail;

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
