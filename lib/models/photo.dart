import 'package:built_value/built_value.dart';
import 'package:reddigram/models/models.dart';

part 'photo.g.dart';

abstract class Photo implements Built<Photo, PhotoBuilder> {
  String get id;

  String get authorName;

  Subreddit get subreddit;

  String get photoUrl;

  double get aspectRatio;

  String get thumbnailUrl;

  int get upvotes;

  bool get upvoted;

  String get redditUrl;

  Photo._();

  factory Photo([updates(PhotoBuilder b)]) = _$Photo;
}
