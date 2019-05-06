import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:reddigram/models/models.dart';

part 'subreddit.g.dart';

abstract class Subreddit implements Built<Subreddit, SubredditBuilder> {
  String get name;

  String get redditUrl;

  String get iconImageUrl;

  BuiltList<Photo> get photos;

  Subreddit._();

  factory Subreddit([updates(SubredditBuilder b)]) = _$Subreddit;
}
