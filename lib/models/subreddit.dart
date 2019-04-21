import 'package:built_value/built_value.dart';

part 'subreddit.g.dart';

abstract class Subreddit implements Built<Subreddit, SubredditBuilder> {
  String get name;

  String get redditUrl;

  bool get subscribed;

  Subreddit._();

  factory Subreddit([updates(SubredditBuilder b)]) = _$Subreddit;
}
