// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subreddit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Subreddit> _$subredditSerializer = new _$SubredditSerializer();

class _$SubredditSerializer implements StructuredSerializer<Subreddit> {
  @override
  final Iterable<Type> types = const [Subreddit, _$Subreddit];
  @override
  final String wireName = 'Subreddit';

  @override
  Iterable serialize(Serializers serializers, Subreddit object,
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
  Subreddit deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubredditBuilder();

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

class _$Subreddit extends Subreddit {
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

  factory _$Subreddit([void Function(SubredditBuilder) updates]) =>
      (new SubredditBuilder()..update(updates)).build();

  _$Subreddit._(
      {this.id, this.name, this.nsfw, this.primaryColor, this.iconUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'id');
    }
    if (name == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'name');
    }
    if (nsfw == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'nsfw');
    }
    if (primaryColor == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'primaryColor');
    }
    if (iconUrl == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'iconUrl');
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
    return (newBuiltValueToStringHelper('Subreddit')
          ..add('id', id)
          ..add('name', name)
          ..add('nsfw', nsfw)
          ..add('primaryColor', primaryColor)
          ..add('iconUrl', iconUrl))
        .toString();
  }
}

class SubredditBuilder implements Builder<Subreddit, SubredditBuilder> {
  _$Subreddit _$v;

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

  SubredditBuilder();

  SubredditBuilder get _$this {
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
    final _$result = _$v ??
        new _$Subreddit._(
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
