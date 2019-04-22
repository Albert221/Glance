import 'package:built_value/built_value.dart';
import 'package:reddigram/store/store.dart';

part 'app_state.g.dart';

abstract class ReddigramState
    implements Built<ReddigramState, ReddigramStateBuilder> {
  AuthState get authState;

  FeedState get feedState;

  ReddigramState._();

  factory ReddigramState([updates(ReddigramStateBuilder b)]) {
    return _$ReddigramState._(
      authState: AuthState(),
      feedState: FeedState(),
    );
  }
}
