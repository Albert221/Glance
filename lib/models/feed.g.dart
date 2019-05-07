// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Feed extends Feed {
  @override
  final BuiltList<String> photosIds;
  @override
  final bool nsfw;

  factory _$Feed([void Function(FeedBuilder) updates]) =>
      (new FeedBuilder()..update(updates)).build();

  _$Feed._({this.photosIds, this.nsfw}) : super._() {
    if (photosIds == null) {
      throw new BuiltValueNullFieldError('Feed', 'photosIds');
    }
    if (nsfw == null) {
      throw new BuiltValueNullFieldError('Feed', 'nsfw');
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
    return other is Feed && photosIds == other.photosIds && nsfw == other.nsfw;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, photosIds.hashCode), nsfw.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Feed')
          ..add('photosIds', photosIds)
          ..add('nsfw', nsfw))
        .toString();
  }
}

class FeedBuilder implements Builder<Feed, FeedBuilder> {
  _$Feed _$v;

  ListBuilder<String> _photosIds;
  ListBuilder<String> get photosIds =>
      _$this._photosIds ??= new ListBuilder<String>();
  set photosIds(ListBuilder<String> photosIds) => _$this._photosIds = photosIds;

  bool _nsfw;
  bool get nsfw => _$this._nsfw;
  set nsfw(bool nsfw) => _$this._nsfw = nsfw;

  FeedBuilder();

  FeedBuilder get _$this {
    if (_$v != null) {
      _photosIds = _$v.photosIds?.toBuilder();
      _nsfw = _$v.nsfw;
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
      _$result = _$v ?? new _$Feed._(photosIds: photosIds.build(), nsfw: nsfw);
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
