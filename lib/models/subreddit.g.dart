// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subreddit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Subreddit extends Subreddit {
  @override
  final String name;
  @override
  final String redditUrl;
  @override
  final String iconImageUrl;
  @override
  final BuiltList<Photo> photos;

  factory _$Subreddit([void Function(SubredditBuilder) updates]) =>
      (new SubredditBuilder()..update(updates)).build();

  _$Subreddit._({this.name, this.redditUrl, this.iconImageUrl, this.photos})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'name');
    }
    if (redditUrl == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'redditUrl');
    }
    if (iconImageUrl == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'iconImageUrl');
    }
    if (photos == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'photos');
    }
  }

  @override
  Subreddit rebuild(void Function(SubredditBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubredditBuilder toBuilder() => new SubredditBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Subreddit &&
        name == other.name &&
        redditUrl == other.redditUrl &&
        iconImageUrl == other.iconImageUrl &&
        photos == other.photos;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, name.hashCode), redditUrl.hashCode),
            iconImageUrl.hashCode),
        photos.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Subreddit')
          ..add('name', name)
          ..add('redditUrl', redditUrl)
          ..add('iconImageUrl', iconImageUrl)
          ..add('photos', photos))
        .toString();
  }
}

class SubredditBuilder implements Builder<Subreddit, SubredditBuilder> {
  _$Subreddit _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _redditUrl;
  String get redditUrl => _$this._redditUrl;
  set redditUrl(String redditUrl) => _$this._redditUrl = redditUrl;

  String _iconImageUrl;
  String get iconImageUrl => _$this._iconImageUrl;
  set iconImageUrl(String iconImageUrl) => _$this._iconImageUrl = iconImageUrl;

  ListBuilder<Photo> _photos;
  ListBuilder<Photo> get photos => _$this._photos ??= new ListBuilder<Photo>();
  set photos(ListBuilder<Photo> photos) => _$this._photos = photos;

  SubredditBuilder();

  SubredditBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _redditUrl = _$v.redditUrl;
      _iconImageUrl = _$v.iconImageUrl;
      _photos = _$v.photos?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Subreddit other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Subreddit;
  }

  @override
  void update(void Function(SubredditBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Subreddit build() {
    _$Subreddit _$result;
    try {
      _$result = _$v ??
          new _$Subreddit._(
              name: name,
              redditUrl: redditUrl,
              iconImageUrl: iconImageUrl,
              photos: photos.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'photos';
        photos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Subreddit', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
