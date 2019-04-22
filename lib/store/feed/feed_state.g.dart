// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FeedState extends FeedState {
  @override
  final BuiltList<Photo> photos;
  @override
  final bool fetching;

  factory _$FeedState([void Function(FeedStateBuilder) updates]) =>
      (new FeedStateBuilder()..update(updates)).build();

  _$FeedState._({this.photos, this.fetching}) : super._() {
    if (photos == null) {
      throw new BuiltValueNullFieldError('FeedState', 'photos');
    }
    if (fetching == null) {
      throw new BuiltValueNullFieldError('FeedState', 'fetching');
    }
  }

  @override
  FeedState rebuild(void Function(FeedStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeedStateBuilder toBuilder() => new FeedStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeedState &&
        photos == other.photos &&
        fetching == other.fetching;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, photos.hashCode), fetching.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('FeedState')
          ..add('photos', photos)
          ..add('fetching', fetching))
        .toString();
  }
}

class FeedStateBuilder implements Builder<FeedState, FeedStateBuilder> {
  _$FeedState _$v;

  ListBuilder<Photo> _photos;
  ListBuilder<Photo> get photos => _$this._photos ??= new ListBuilder<Photo>();
  set photos(ListBuilder<Photo> photos) => _$this._photos = photos;

  bool _fetching;
  bool get fetching => _$this._fetching;
  set fetching(bool fetching) => _$this._fetching = fetching;

  FeedStateBuilder();

  FeedStateBuilder get _$this {
    if (_$v != null) {
      _photos = _$v.photos?.toBuilder();
      _fetching = _$v.fetching;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeedState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$FeedState;
  }

  @override
  void update(void Function(FeedStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FeedState build() {
    _$FeedState _$result;
    try {
      _$result =
          _$v ?? new _$FeedState._(photos: photos.build(), fetching: fetching);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'photos';
        photos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'FeedState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
