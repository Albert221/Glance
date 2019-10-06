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
  final BuiltMap<String, Feed> feeds;
  @override
  final BuiltMap<String, Subreddit> subreddits;
  @override
  final BuiltSet<String> subscriptions;
  @override
  final BuiltSet<String> suggestedSubscriptions;
  @override
  final SubredditsSearchState subredditsSearch;

  factory _$ReddigramState([void Function(ReddigramStateBuilder) updates]) =>
      (new ReddigramStateBuilder()..update(updates)).build();

  _$ReddigramState._(
      {this.authState,
      this.preferences,
      this.photos,
      this.feeds,
      this.subreddits,
      this.subscriptions,
      this.suggestedSubscriptions,
      this.subredditsSearch})
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
    if (subreddits == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'subreddits');
    }
    if (subscriptions == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'subscriptions');
    }
    if (suggestedSubscriptions == null) {
      throw new BuiltValueNullFieldError(
          'ReddigramState', 'suggestedSubscriptions');
    }
    if (subredditsSearch == null) {
      throw new BuiltValueNullFieldError('ReddigramState', 'subredditsSearch');
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
        subreddits == other.subreddits &&
        subscriptions == other.subscriptions &&
        suggestedSubscriptions == other.suggestedSubscriptions &&
        subredditsSearch == other.subredditsSearch;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, authState.hashCode),
                                preferences.hashCode),
                            photos.hashCode),
                        feeds.hashCode),
                    subreddits.hashCode),
                subscriptions.hashCode),
            suggestedSubscriptions.hashCode),
        subredditsSearch.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReddigramState')
          ..add('authState', authState)
          ..add('preferences', preferences)
          ..add('photos', photos)
          ..add('feeds', feeds)
          ..add('subreddits', subreddits)
          ..add('subscriptions', subscriptions)
          ..add('suggestedSubscriptions', suggestedSubscriptions)
          ..add('subredditsSearch', subredditsSearch))
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

  MapBuilder<String, Feed> _feeds;
  MapBuilder<String, Feed> get feeds =>
      _$this._feeds ??= new MapBuilder<String, Feed>();
  set feeds(MapBuilder<String, Feed> feeds) => _$this._feeds = feeds;

  MapBuilder<String, Subreddit> _subreddits;
  MapBuilder<String, Subreddit> get subreddits =>
      _$this._subreddits ??= new MapBuilder<String, Subreddit>();
  set subreddits(MapBuilder<String, Subreddit> subreddits) =>
      _$this._subreddits = subreddits;

  SetBuilder<String> _subscriptions;
  SetBuilder<String> get subscriptions =>
      _$this._subscriptions ??= new SetBuilder<String>();
  set subscriptions(SetBuilder<String> subscriptions) =>
      _$this._subscriptions = subscriptions;

  SetBuilder<String> _suggestedSubscriptions;
  SetBuilder<String> get suggestedSubscriptions =>
      _$this._suggestedSubscriptions ??= new SetBuilder<String>();
  set suggestedSubscriptions(SetBuilder<String> suggestedSubscriptions) =>
      _$this._suggestedSubscriptions = suggestedSubscriptions;

  SubredditsSearchStateBuilder _subredditsSearch;
  SubredditsSearchStateBuilder get subredditsSearch =>
      _$this._subredditsSearch ??= new SubredditsSearchStateBuilder();
  set subredditsSearch(SubredditsSearchStateBuilder subredditsSearch) =>
      _$this._subredditsSearch = subredditsSearch;

  ReddigramStateBuilder();

  ReddigramStateBuilder get _$this {
    if (_$v != null) {
      _authState = _$v.authState?.toBuilder();
      _preferences = _$v.preferences?.toBuilder();
      _photos = _$v.photos?.toBuilder();
      _feeds = _$v.feeds?.toBuilder();
      _subreddits = _$v.subreddits?.toBuilder();
      _subscriptions = _$v.subscriptions?.toBuilder();
      _suggestedSubscriptions = _$v.suggestedSubscriptions?.toBuilder();
      _subredditsSearch = _$v.subredditsSearch?.toBuilder();
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
              subreddits: subreddits.build(),
              subscriptions: subscriptions.build(),
              suggestedSubscriptions: suggestedSubscriptions.build(),
              subredditsSearch: subredditsSearch.build());
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
        _$failedField = 'subreddits';
        subreddits.build();
        _$failedField = 'subscriptions';
        subscriptions.build();
        _$failedField = 'suggestedSubscriptions';
        suggestedSubscriptions.build();
        _$failedField = 'subredditsSearch';
        subredditsSearch.build();
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
