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
  final BuiltMap<String, Photo> photos;
  @override
  final BuiltMap<String, BuiltList<String>> feeds;
  @override
  final BuiltSet<String> subscriptions;

  factory _$ReddigramState([void Function(ReddigramStateBuilder) updates]) =>
      (new ReddigramStateBuilder()..update(updates)).build();

  _$ReddigramState._(
      {this.authState,
      this.preferences,
      this.photos,
      this.feeds,
      this.subscriptions})
      : super._() {
    if (authState == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'authState');
    }
    if (preferences == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'preferences');
    }
    if (photos == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'photos');
    }
    if (feeds == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'feeds');
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
        photos == other.photos &&
        feeds == other.feeds &&
        subscriptions == other.subscriptions;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, authState.hashCode), preferences.hashCode),
                photos.hashCode),
            feeds.hashCode),
        subscriptions.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReddigramState')
          ..add('authState', authState)
          ..add('preferences', preferences)
          ..add('photos', photos)
          ..add('feeds', feeds)
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

  MapBuilder<String, Photo> _photos;
  MapBuilder<String, Photo> get photos =>
      _$this._photos ??= new MapBuilder<String, Photo>();
  set photos(MapBuilder<String, Photo> photos) => _$this._photos = photos;

  MapBuilder<String, BuiltList<String>> _feeds;
  MapBuilder<String, BuiltList<String>> get feeds =>
      _$this._feeds ??= new MapBuilder<String, BuiltList<String>>();
  set feeds(MapBuilder<String, BuiltList<String>> feeds) =>
      _$this._feeds = feeds;

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
      _photos = _$v.photos?.toBuilder();
      _feeds = _$v.feeds?.toBuilder();
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
              photos: photos.build(),
              feeds: feeds.build(),
              subscriptions: subscriptions.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'authState';
        authState.build();
        _$failedField = 'preferences';
        preferences.build();
        _$failedField = 'photos';
        photos.build();
        _$failedField = 'feeds';
        feeds.build();
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
