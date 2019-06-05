// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subreddit_info_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubredditsInfoResponse> _$subredditsInfoResponseSerializer =
    new _$SubredditsInfoResponseSerializer();
Serializer<SubredditInfoResponse> _$subredditInfoResponseSerializer =
    new _$SubredditInfoResponseSerializer();

class _$SubredditsInfoResponseSerializer
    implements StructuredSerializer<SubredditsInfoResponse> {
  @override
  final Iterable<Type> types = const [
    SubredditsInfoResponse,
    _$SubredditsInfoResponse
  ];
  @override
  final String wireName = 'SubredditsInfoResponse';

  @override
  Iterable serialize(Serializers serializers, SubredditsInfoResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SubredditInfoResponse)])),
    ];

    return result;
  }

  @override
  SubredditsInfoResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubredditsInfoResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SubredditInfoResponse)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$SubredditInfoResponseSerializer
    implements StructuredSerializer<SubredditInfoResponse> {
  @override
  final Iterable<Type> types = const [
    SubredditInfoResponse,
    _$SubredditInfoResponse
  ];
  @override
  final String wireName = 'SubredditInfoResponse';

  @override
  Iterable serialize(Serializers serializers, SubredditInfoResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'nsfw',
      serializers.serialize(object.nsfw, specifiedType: const FullType(bool)),
      'iconUrl',
      serializers.serialize(object.iconUrl,
          specifiedType: const FullType(String)),
      'primaryColor',
      serializers.serialize(object.primaryColor,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  SubredditInfoResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubredditInfoResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'nsfw':
          result.nsfw = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'iconUrl':
          result.iconUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'primaryColor':
          result.primaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SubredditsInfoResponse extends SubredditsInfoResponse {
  @override
  final BuiltList<SubredditInfoResponse> items;

  factory _$SubredditsInfoResponse(
          [void Function(SubredditsInfoResponseBuilder) updates]) =>
      (new SubredditsInfoResponseBuilder()..update(updates)).build();

  _$SubredditsInfoResponse._({this.items}) : super._() {
    if (items == null) {
      throw new BuiltValueNullFieldError('SubredditsInfoResponse', 'items');
    }
  }

  @override
  SubredditsInfoResponse rebuild(
          void Function(SubredditsInfoResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubredditsInfoResponseBuilder toBuilder() =>
      new SubredditsInfoResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubredditsInfoResponse && items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(0, items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubredditsInfoResponse')
          ..add('items', items))
        .toString();
  }
}

class SubredditsInfoResponseBuilder
    implements Builder<SubredditsInfoResponse, SubredditsInfoResponseBuilder> {
  _$SubredditsInfoResponse _$v;

  ListBuilder<SubredditInfoResponse> _items;
  ListBuilder<SubredditInfoResponse> get items =>
      _$this._items ??= new ListBuilder<SubredditInfoResponse>();
  set items(ListBuilder<SubredditInfoResponse> items) => _$this._items = items;

  SubredditsInfoResponseBuilder();

  SubredditsInfoResponseBuilder get _$this {
    if (_$v != null) {
      _items = _$v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubredditsInfoResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubredditsInfoResponse;
  }

  @override
  void update(void Function(SubredditsInfoResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubredditsInfoResponse build() {
    _$SubredditsInfoResponse _$result;
    try {
      _$result = _$v ?? new _$SubredditsInfoResponse._(items: items.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubredditsInfoResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SubredditInfoResponse extends SubredditInfoResponse {
  @override
  final String id;
  @override
  final String name;
  @override
  final bool nsfw;
  @override
  final String iconUrl;
  @override
  final String primaryColor;

  factory _$SubredditInfoResponse(
          [void Function(SubredditInfoResponseBuilder) updates]) =>
      (new SubredditInfoResponseBuilder()..update(updates)).build();

  _$SubredditInfoResponse._(
      {this.id, this.name, this.nsfw, this.iconUrl, this.primaryColor})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('SubredditInfoResponse', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SubredditInfoResponse', 'name');
    }
    if (nsfw == null) {
      throw new BuiltValueNullFieldError('SubredditInfoResponse', 'nsfw');
    }
    if (iconUrl == null) {
      throw new BuiltValueNullFieldError('SubredditInfoResponse', 'iconUrl');
    }
    if (primaryColor == null) {
      throw new BuiltValueNullFieldError(
          'SubredditInfoResponse', 'primaryColor');
    }
  }

  @override
  SubredditInfoResponse rebuild(
          void Function(SubredditInfoResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubredditInfoResponseBuilder toBuilder() =>
      new SubredditInfoResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubredditInfoResponse &&
        id == other.id &&
        name == other.name &&
        nsfw == other.nsfw &&
        iconUrl == other.iconUrl &&
        primaryColor == other.primaryColor;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), name.hashCode), nsfw.hashCode),
            iconUrl.hashCode),
        primaryColor.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubredditInfoResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('nsfw', nsfw)
          ..add('iconUrl', iconUrl)
          ..add('primaryColor', primaryColor))
        .toString();
  }
}

class SubredditInfoResponseBuilder
    implements Builder<SubredditInfoResponse, SubredditInfoResponseBuilder> {
  _$SubredditInfoResponse _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _nsfw;
  bool get nsfw => _$this._nsfw;
  set nsfw(bool nsfw) => _$this._nsfw = nsfw;

  String _iconUrl;
  String get iconUrl => _$this._iconUrl;
  set iconUrl(String iconUrl) => _$this._iconUrl = iconUrl;

  String _primaryColor;
  String get primaryColor => _$this._primaryColor;
  set primaryColor(String primaryColor) => _$this._primaryColor = primaryColor;

  SubredditInfoResponseBuilder();

  SubredditInfoResponseBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _nsfw = _$v.nsfw;
      _iconUrl = _$v.iconUrl;
      _primaryColor = _$v.primaryColor;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubredditInfoResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubredditInfoResponse;
  }

  @override
  void update(void Function(SubredditInfoResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubredditInfoResponse build() {
    final _$result = _$v ??
        new _$SubredditInfoResponse._(
            id: id,
            name: name,
            nsfw: nsfw,
            iconUrl: iconUrl,
            primaryColor: primaryColor);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
