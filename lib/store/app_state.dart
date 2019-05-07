import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';

part 'app_state.g.dart';

abstract class ReddigramState
    implements Built<ReddigramState, ReddigramStateBuilder> {
  AuthState get authState;

  PreferencesState get preferences;

  FeedState get feedState;

  BuiltMap<String, BuiltList<Photo>> get subredditFeeds;

  BuiltSet<String> get subscriptions;

  ReddigramState._();

  factory ReddigramState([updates(ReddigramStateBuilder b)]) {
    return _$ReddigramState._(
      authState: AuthState(),
      preferences: PreferencesState(),
      feedState: FeedState(),
      subredditFeeds: BuiltMap<String, BuiltList<Photo>>(),
      subscriptions: BuiltSet(),
    );
  }
}
