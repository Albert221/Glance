// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subreddit_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubredditResponse> _$subredditResponseSerializer =
    new _$SubredditResponseSerializer();
Serializer<Subreddit> _$subredditSerializer = new _$SubredditSerializer();

class _$SubredditResponseSerializer
    implements StructuredSerializer<SubredditResponse> {
  @override
  final Iterable<Type> types = const [SubredditResponse, _$SubredditResponse];
  @override
  final String wireName = 'SubredditResponse';

  @override
  Iterable serialize(Serializers serializers, SubredditResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(Subreddit)),
    ];

    return result;
  }

  @override
  SubredditResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubredditResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(Subreddit)) as Subreddit);
          break;
      }
    }

    return result.build();
  }
}

class _$SubredditSerializer implements StructuredSerializer<Subreddit> {
  @override
  final Iterable<Type> types = const [Subreddit, _$Subreddit];
  @override
  final String wireName = 'Subreddit';

  @override
  Iterable serialize(Serializers serializers, Subreddit object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'over18',
      serializers.serialize(object.nsfw, specifiedType: const FullType(bool)),
    ];

    return result;
  }

  @override
  Subreddit deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubredditBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'over18':
          result.nsfw = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$SubredditResponse extends SubredditResponse {
  @override
  final Subreddit data;

  factory _$SubredditResponse(
          [void Function(SubredditResponseBuilder) updates]) =>
      (new SubredditResponseBuilder()..update(updates)).build();

  _$SubredditResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('SubredditResponse', 'data');
    }
  }

  @override
  SubredditResponse rebuild(void Function(SubredditResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubredditResponseBuilder toBuilder() =>
      new SubredditResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubredditResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubredditResponse')..add('data', data))
        .toString();
  }
}

class SubredditResponseBuilder
    implements Builder<SubredditResponse, SubredditResponseBuilder> {
  _$SubredditResponse _$v;

  SubredditBuilder _data;
  SubredditBuilder get data => _$this._data ??= new SubredditBuilder();
  set data(SubredditBuilder data) => _$this._data = data;

  SubredditResponseBuilder();

  SubredditResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubredditResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubredditResponse;
  }

  @override
  void update(void Function(SubredditResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubredditResponse build() {
    _$SubredditResponse _$result;
    try {
      _$result = _$v ?? new _$SubredditResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubredditResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Subreddit extends Subreddit {
  @override
  final bool nsfw;

  factory _$Subreddit([void Function(SubredditBuilder) updates]) =>
      (new SubredditBuilder()..update(updates)).build();

  _$Subreddit._({this.nsfw}) : super._() {
    if (nsfw == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'nsfw');
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
    return other is Subreddit && nsfw == other.nsfw;
  }

  @override
  int get hashCode {
    return $jf($jc(0, nsfw.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Subreddit')..add('nsfw', nsfw))
        .toString();
  }
}

class SubredditBuilder implements Builder<Subreddit, SubredditBuilder> {
  _$Subreddit _$v;

  bool _nsfw;
  bool get nsfw => _$this._nsfw;
  set nsfw(bool nsfw) => _$this._nsfw = nsfw;

  SubredditBuilder();

  SubredditBuilder get _$this {
    if (_$v != null) {
      _nsfw = _$v.nsfw;
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
    final _$result = _$v ?? new _$Subreddit._(nsfw: nsfw);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
