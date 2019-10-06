import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';

part 'app_state.g.dart';

abstract class ReddigramState
    implements Built<ReddigramState, ReddigramStateBuilder> {
  AuthState get authState;

  PreferencesState get preferences;

  /// Map of all photos in application; index is an id of a photo.
  BuiltMap<String, Photo> get photos;

  /// Map with all feeds in application. There are three reserved values:
  /// [POPULAR], [NEW_SUBSCRIBED], and [BEST_SUBSCRIBED], the rest of values
  /// are subreddits' names with correct capitaliation, without "r/" prefix
  BuiltMap<String, Feed> get feeds;

  /// Names of subscribed subreddits
  BuiltSet<String> get subscriptions;

  /// Map of all subreddits in application (not only those which feed was
  /// loaded, but also all shown in badges). Index is a subreddit name without
  /// the "r/" prefix.
  BuiltMap<String, Subreddit> get subreddits;

  SubredditsSearchState get subredditsSearch;

  ReddigramState._();

  factory ReddigramState([updates(ReddigramStateBuilder b)]) {
    return _$ReddigramState._(
          authState: AuthState(),
          preferences: PreferencesState(),
          photos: BuiltMap<String, Photo>(),
          feeds: BuiltMap<String, Feed>({
            POPULAR: Feed(),
            NEW_SUBSCRIBED: Feed(),
            BEST_SUBSCRIBED: Feed(),
          }),
          subscriptions: BuiltSet(),
          subreddits: BuiltMap<String, Subreddit>(),
          subredditsSearch: SubredditsSearchState(),
        )
        .rebuild(updates);
  }
}
