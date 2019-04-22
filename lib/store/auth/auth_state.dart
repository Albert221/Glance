import 'package:built_value/built_value.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  bool get authenticated => accessToken != null;

  @nullable
  String get accessToken;

  @nullable
  String get username;

  AuthState._();

  factory AuthState([updates(AuthStateBuilder b)]) {
    return _$AuthState._(
      accessToken: null,
      username: null,
    );
  }
}
