import 'package:built_value/built_value.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  bool get authenticated => username != null;

  @nullable
  String get username;

  bool get inProgress;

  AuthState._();

  factory AuthState([updates(AuthStateBuilder b)]) {
    return _$AuthState._(
      username: null,
      inProgress: false,
    );
  }
}
