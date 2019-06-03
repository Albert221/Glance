import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'auth_state.g.dart';

abstract class AuthState implements Built<AuthState, AuthStateBuilder> {
  @nullable
  String get username;

  AuthStatus get status;

  AuthState._();

  factory AuthState([updates(AuthStateBuilder b)]) {
    return _$AuthState._(
      username: null,
      status: AuthStatus.unknown,
    ).rebuild(updates);
  }
}

class AuthStatus extends EnumClass {
  static const AuthStatus unknown = _$unknown;
  static const AuthStatus guest = _$guest;
  static const AuthStatus authenticating = _$authenticating;
  static const AuthStatus authenticated = _$authenticated;
  static const AuthStatus signingOut = _$signingOut;

  const AuthStatus._(String name) : super(name);

  static BuiltSet<AuthStatus> get values => _$values;

  static AuthStatus valueOf(String name) => _$valueOf(name);
}
