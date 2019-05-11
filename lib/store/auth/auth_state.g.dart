// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AuthStatus _$unknown = const AuthStatus._('unknown');
const AuthStatus _$guest = const AuthStatus._('guest');
const AuthStatus _$authenticating = const AuthStatus._('authenticating');
const AuthStatus _$authenticated = const AuthStatus._('authenticated');
const AuthStatus _$signingOut = const AuthStatus._('signingOut');

AuthStatus _$valueOf(String name) {
  switch (name) {
    case 'unknown':
      return _$unknown;
    case 'guest':
      return _$guest;
    case 'authenticating':
      return _$authenticating;
    case 'authenticated':
      return _$authenticated;
    case 'signingOut':
      return _$signingOut;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<AuthStatus> _$values =
    new BuiltSet<AuthStatus>(const <AuthStatus>[
  _$unknown,
  _$guest,
  _$authenticating,
  _$authenticated,
  _$signingOut,
]);

class _$AuthState extends AuthState {
  @override
  final String username;
  @override
  final AuthStatus status;

  factory _$AuthState([void Function(AuthStateBuilder) updates]) =>
      (new AuthStateBuilder()..update(updates)).build();

  _$AuthState._({this.username, this.status}) : super._() {
    if (status == null) {
      throw new BuiltValueNullFieldError('AuthState', 'status');
    }
  }

  @override
  AuthState rebuild(void Function(AuthStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthStateBuilder toBuilder() => new AuthStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthState &&
        username == other.username &&
        status == other.status;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, username.hashCode), status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthState')
          ..add('username', username)
          ..add('status', status))
        .toString();
  }
}

class AuthStateBuilder implements Builder<AuthState, AuthStateBuilder> {
  _$AuthState _$v;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  AuthStatus _status;
  AuthStatus get status => _$this._status;
  set status(AuthStatus status) => _$this._status = status;

  AuthStateBuilder();

  AuthStateBuilder get _$this {
    if (_$v != null) {
      _username = _$v.username;
      _status = _$v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AuthState;
  }

  @override
  void update(void Function(AuthStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AuthState build() {
    final _$result =
        _$v ?? new _$AuthState._(username: username, status: status);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
