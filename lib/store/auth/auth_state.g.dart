// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthState extends AuthState {
  @override
  final String username;

  factory _$AuthState([void Function(AuthStateBuilder) updates]) =>
      (new AuthStateBuilder()..update(updates)).build();

  _$AuthState._({this.username}) : super._();

  @override
  AuthState rebuild(void Function(AuthStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthStateBuilder toBuilder() => new AuthStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthState && username == other.username;
  }

  @override
  int get hashCode {
    return $jf($jc(0, username.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthState')..add('username', username))
        .toString();
  }
}

class AuthStateBuilder implements Builder<AuthState, AuthStateBuilder> {
  _$AuthState _$v;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  AuthStateBuilder();

  AuthStateBuilder get _$this {
    if (_$v != null) {
      _username = _$v.username;
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
    final _$result = _$v ?? new _$AuthState._(username: username);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
