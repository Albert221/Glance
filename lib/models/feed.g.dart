// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Feed extends Feed {
  @override
  final String id;
  @override
  final String name;
  @override
  final BuiltList<String> photosIds;
  @override
  final bool photosLoaded;
  @override
  final bool nsfw;
  @override
  final String primaryColor;
  @override
  final String iconUrl;

  factory _$Feed([void Function(FeedBuilder) updates]) =>
      (new FeedBuilder()..update(updates)).build();

  _$Feed._(
      {this.id,
      this.name,
      this.photosIds,
      this.photosLoaded,
      this.nsfw,
      this.primaryColor,
      this.iconUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Feed', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Feed', 'name');
    }
    if (photosIds == null) {
      throw new BuiltValueNullFieldError('Feed', 'photosIds');
    }
    if (photosLoaded == null) {
      throw new BuiltValueNullFieldError('Feed', 'photosLoaded');
    }
    if (nsfw == null) {
      throw new BuiltValueNullFieldError('Feed', 'nsfw');
    }
    if (primaryColor == null) {
      throw new BuiltValueNullFieldError('Feed', 'primaryColor');
    }
    if (iconUrl == null) {
      throw new BuiltValueNullFieldError('Feed', 'iconUrl');
    }
  }

  @override
  Feed rebuild(void Function(FeedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedBuilder toBuilder() => new FeedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Feed &&
        id == other.id &&
        name == other.name &&
        photosIds == other.photosIds &&
        photosLoaded == other.photosLoaded &&
        nsfw == other.nsfw &&
        primaryColor == other.primaryColor &&
        iconUrl == other.iconUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, id.hashCode), name.hashCode),
                        photosIds.hashCode),
                    photosLoaded.hashCode),
                nsfw.hashCode),
            primaryColor.hashCode),
        iconUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Feed')
          ..add('id', id)
          ..add('name', name)
          ..add('photosIds', photosIds)
          ..add('photosLoaded', photosLoaded)
          ..add('nsfw', nsfw)
          ..add('primaryColor', primaryColor)
          ..add('iconUrl', iconUrl))
        .toString();
  }
}

class FeedBuilder implements Builder<Feed, FeedBuilder> {
  _$Feed _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  ListBuilder<String> _photosIds;
  ListBuilder<String> get photosIds =>
      _$this._photosIds ??= new ListBuilder<String>();
  set photosIds(ListBuilder<String> photosIds) => _$this._photosIds = photosIds;

  bool _photosLoaded;
  bool get photosLoaded => _$this._photosLoaded;
  set photosLoaded(bool photosLoaded) => _$this._photosLoaded = photosLoaded;

  bool _nsfw;
  bool get nsfw => _$this._nsfw;
  set nsfw(bool nsfw) => _$this._nsfw = nsfw;

  String _primaryColor;
  String get primaryColor => _$this._primaryColor;
  set primaryColor(String primaryColor) => _$this._primaryColor = primaryColor;

  String _iconUrl;
  String get iconUrl => _$this._iconUrl;
  set iconUrl(String iconUrl) => _$this._iconUrl = iconUrl;

  FeedBuilder();

  FeedBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _photosIds = _$v.photosIds?.toBuilder();
      _photosLoaded = _$v.photosLoaded;
      _nsfw = _$v.nsfw;
      _primaryColor = _$v.primaryColor;
      _iconUrl = _$v.iconUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Feed other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Feed;
  }

  @override
  void update(void Function(FeedBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Feed build() {
    _$Feed _$result;
    try {
      _$result = _$v ??
          new _$Feed._(
              id: id,
              name: name,
              photosIds: photosIds.build(),
              photosLoaded: photosLoaded,
              nsfw: nsfw,
              primaryColor: primaryColor,
              iconUrl: iconUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'photosIds';
        photosIds.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Feed', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
