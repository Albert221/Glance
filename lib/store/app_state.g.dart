// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ReddigramState extends ReddigramState {
  @override
  final AuthState authState;
  @override
  final PreferencesState preferences;
  @override
  final FeedState feedState;
  @override
  final BuiltSet<String> subscriptions;

  factory _$ReddigramState([void Function(ReddigramStateBuilder) updates]) =>
      (new ReddigramStateBuilder()..update(updates)).build();

  _$ReddigramState._(
      {this.authState, this.preferences, this.feedState, this.subscriptions})
      : super._() {
    if (authState == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'authState');
    }
    if (preferences == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'preferences');
    }
    if (feedState == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'feedState');
    }
    if (subscriptions == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'subscriptions');
    }
  }

  @override
  ReddigramState rebuild(void Function(ReddigramStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReddigramStateBuilder toBuilder() =>
      new ReddigramStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReddigramState &&
        authState == other.authState &&
        preferences == other.preferences &&
        feedState == other.feedState &&
        subscriptions == other.subscriptions;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, authState.hashCode), preferences.hashCode),
            feedState.hashCode),
        subscriptions.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReddigramState')
          ..add('authState', authState)
          ..add('preferences', preferences)
          ..add('feedState', feedState)
          ..add('subscriptions', subscriptions))
        .toString();
  }
}

class ReddigramStateBuilder
    implements Builder<ReddigramState, ReddigramStateBuilder> {
  _$ReddigramState _$v;

  AuthStateBuilder _authState;
  AuthStateBuilder get authState =>
      _$this._authState ??= new AuthStateBuilder();
  set authState(AuthStateBuilder authState) => _$this._authState = authState;

  PreferencesStateBuilder _preferences;
  PreferencesStateBuilder get preferences =>
      _$this._preferences ??= new PreferencesStateBuilder();
  set preferences(PreferencesStateBuilder preferences) =>
      _$this._preferences = preferences;

  FeedStateBuilder _feedState;
  FeedStateBuilder get feedState =>
      _$this._feedState ??= new FeedStateBuilder();
  set feedState(FeedStateBuilder feedState) => _$this._feedState = feedState;

  SetBuilder<String> _subscriptions;
  SetBuilder<String> get subscriptions =>
      _$this._subscriptions ??= new SetBuilder<String>();
  set subscriptions(SetBuilder<String> subscriptions) =>
      _$this._subscriptions = subscriptions;

  ReddigramStateBuilder();

  ReddigramStateBuilder get _$this {
    if (_$v != null) {
      _authState = _$v.authState?.toBuilder();
      _preferences = _$v.preferences?.toBuilder();
      _feedState = _$v.feedState?.toBuilder();
      _subscriptions = _$v.subscriptions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReddigramState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ReddigramState;
  }

  @override
  void update(void Function(ReddigramStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ReddigramState build() {
    _$ReddigramState _$result;
    try {
      _$result = _$v ??
          new _$ReddigramState._(
              authState: authState.build(),
              preferences: preferences.build(),
              feedState: feedState.build(),
              subscriptions: subscriptions.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'authState';
        authState.build();
        _$failedField = 'preferences';
        preferences.build();
        _$failedField = 'feedState';
        feedState.build();
        _$failedField = 'subscriptions';
        subscriptions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ReddigramState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
