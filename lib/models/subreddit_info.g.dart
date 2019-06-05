// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subreddit_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubredditInfo> _$subredditInfoSerializer =
    new _$SubredditInfoSerializer();

class _$SubredditInfoSerializer implements StructuredSerializer<SubredditInfo> {
  @override
  final Iterable<Type> types = const [SubredditInfo, _$SubredditInfo];
  @override
  final String wireName = 'SubredditInfo';

  @override
  Iterable serialize(Serializers serializers, SubredditInfo object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'nsfw',
      serializers.serialize(object.nsfw, specifiedType: const FullType(bool)),
      'primaryColor',
      serializers.serialize(object.primaryColor,
          specifiedType: const FullType(String)),
      'iconUrl',
      serializers.serialize(object.iconUrl,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  SubredditInfo deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubredditInfoBuilder();

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
        case 'primaryColor':
          result.primaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'iconUrl':
          result.iconUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SubredditInfo extends SubredditInfo {
  @override
  final String id;
  @override
  final String name;
  @override
  final bool nsfw;
  @override
  final String primaryColor;
  @override
  final String iconUrl;

  factory _$SubredditInfo([void Function(SubredditInfoBuilder) updates]) =>
      (new SubredditInfoBuilder()..update(updates)).build();

  _$SubredditInfo._(
      {this.id, this.name, this.nsfw, this.primaryColor, this.iconUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('SubredditInfo', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('SubredditInfo', 'name');
    }
    if (nsfw == null) {
      throw new BuiltValueNullFieldError('SubredditInfo', 'nsfw');
    }
    if (primaryColor == null) {
      throw new BuiltValueNullFieldError('SubredditInfo', 'primaryColor');
    }
    if (iconUrl == null) {
      throw new BuiltValueNullFieldError('SubredditInfo', 'iconUrl');
    }
  }

  @override
  SubredditInfo rebuild(void Function(SubredditInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubredditInfoBuilder toBuilder() => new SubredditInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubredditInfo &&
        id == other.id &&
        name == other.name &&
        nsfw == other.nsfw &&
        primaryColor == other.primaryColor &&
        iconUrl == other.iconUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, id.hashCode), name.hashCode), nsfw.hashCode),
            primaryColor.hashCode),
        iconUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubredditInfo')
          ..add('id', id)
          ..add('name', name)
          ..add('nsfw', nsfw)
          ..add('primaryColor', primaryColor)
          ..add('iconUrl', iconUrl))
        .toString();
  }
}

class SubredditInfoBuilder
    implements Builder<SubredditInfo, SubredditInfoBuilder> {
  _$SubredditInfo _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _nsfw;
  bool get nsfw => _$this._nsfw;
  set nsfw(bool nsfw) => _$this._nsfw = nsfw;

  String _primaryColor;
  String get primaryColor => _$this._primaryColor;
  set primaryColor(String primaryColor) => _$this._primaryColor = primaryColor;

  String _iconUrl;
  String get iconUrl => _$this._iconUrl;
  set iconUrl(String iconUrl) => _$this._iconUrl = iconUrl;

  SubredditInfoBuilder();

  SubredditInfoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _name = _$v.name;
      _nsfw = _$v.nsfw;
      _primaryColor = _$v.primaryColor;
      _iconUrl = _$v.iconUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubredditInfo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubredditInfo;
  }

  @override
  void update(void Function(SubredditInfoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubredditInfo build() {
    final _$result = _$v ??
        new _$SubredditInfo._(
            id: id,
            name: name,
            nsfw: nsfw,
            primaryColor: primaryColor,
            iconUrl: iconUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
