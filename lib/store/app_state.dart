import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:reddigram/store/store.dart';

part 'app_state.g.dart';

abstract class ReddigramState
    implements Built<ReddigramState, ReddigramStateBuilder> {
  AuthState get authState;

  AppTheme get theme;

  FeedState get feedState;

  BuiltSet<String> get subscriptions;

  ReddigramState._();

  factory ReddigramState([updates(ReddigramStateBuilder b)]) {
    return _$ReddigramState._(
      authState: AuthState(),
      theme: AppTheme.light,
      feedState: FeedState(),
      subscriptions: BuiltSet(),
    );
  }
}
