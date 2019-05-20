// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subreddit_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubredditListResponse> _$subredditListResponseSerializer =
    new _$SubredditListResponseSerializer();
Serializer<SubredditListData> _$subredditListDataSerializer =
    new _$SubredditListDataSerializer();
Serializer<SubredditResponse> _$subredditResponseSerializer =
    new _$SubredditResponseSerializer();
Serializer<Subreddit> _$subredditSerializer = new _$SubredditSerializer();

class _$SubredditListResponseSerializer
    implements StructuredSerializer<SubredditListResponse> {
  @override
  final Iterable<Type> types = const [
    SubredditListResponse,
    _$SubredditListResponse
  ];
  @override
  final String wireName = 'SubredditListResponse';

  @override
  Iterable serialize(Serializers serializers, SubredditListResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(SubredditListData)),
    ];

    return result;
  }

  @override
  SubredditListResponse deserialize(
      Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubredditListResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(SubredditListData))
              as SubredditListData);
          break;
      }
    }

    return result.build();
  }
}

class _$SubredditListDataSerializer
    implements StructuredSerializer<SubredditListData> {
  @override
  final Iterable<Type> types = const [SubredditListData, _$SubredditListData];
  @override
  final String wireName = 'SubredditListData';

  @override
  Iterable serialize(Serializers serializers, SubredditListData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'children',
      serializers.serialize(object.children,
          specifiedType: const FullType(
              BuiltList, const [const FullType(SubredditResponse)])),
    ];

    return result;
  }

  @override
  SubredditListData deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubredditListDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'children':
          result.children.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(SubredditResponse)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

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
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'display_name',
      serializers.serialize(object.displayName,
          specifiedType: const FullType(String)),
      'subreddit_type',
      serializers.serialize(object.subredditType,
          specifiedType: const FullType(String)),
    ];
    if (object.nsfw != null) {
      result
        ..add('over18')
        ..add(serializers.serialize(object.nsfw,
            specifiedType: const FullType(bool)));
    }
    if (object.primaryColor != null) {
      result
        ..add('primary_color')
        ..add(serializers.serialize(object.primaryColor,
            specifiedType: const FullType(String)));
    }
    if (object.iconUrl != null) {
      result
        ..add('icon_img')
        ..add(serializers.serialize(object.iconUrl,
            specifiedType: const FullType(String)));
    }

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'over18':
          result.nsfw = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'primary_color':
          result.primaryColor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'icon_img':
          result.iconUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subreddit_type':
          result.subredditType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SubredditListResponse extends SubredditListResponse {
  @override
  final SubredditListData data;

  factory _$SubredditListResponse(
          [void Function(SubredditListResponseBuilder) updates]) =>
      (new SubredditListResponseBuilder()..update(updates)).build();

  _$SubredditListResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('SubredditListResponse', 'data');
    }
  }

  @override
  SubredditListResponse rebuild(
          void Function(SubredditListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubredditListResponseBuilder toBuilder() =>
      new SubredditListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubredditListResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubredditListResponse')
          ..add('data', data))
        .toString();
  }
}

class SubredditListResponseBuilder
    implements Builder<SubredditListResponse, SubredditListResponseBuilder> {
  _$SubredditListResponse _$v;

  SubredditListDataBuilder _data;
  SubredditListDataBuilder get data =>
      _$this._data ??= new SubredditListDataBuilder();
  set data(SubredditListDataBuilder data) => _$this._data = data;

  SubredditListResponseBuilder();

  SubredditListResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubredditListResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubredditListResponse;
  }

  @override
  void update(void Function(SubredditListResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubredditListResponse build() {
    _$SubredditListResponse _$result;
    try {
      _$result = _$v ?? new _$SubredditListResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubredditListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$SubredditListData extends SubredditListData {
  @override
  final BuiltList<SubredditResponse> children;

  factory _$SubredditListData(
          [void Function(SubredditListDataBuilder) updates]) =>
      (new SubredditListDataBuilder()..update(updates)).build();

  _$SubredditListData._({this.children}) : super._() {
    if (children == null) {
      throw new BuiltValueNullFieldError('SubredditListData', 'children');
    }
  }

  @override
  SubredditListData rebuild(void Function(SubredditListDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubredditListDataBuilder toBuilder() =>
      new SubredditListDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubredditListData && children == other.children;
  }

  @override
  int get hashCode {
    return $jf($jc(0, children.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubredditListData')
          ..add('children', children))
        .toString();
  }
}

class SubredditListDataBuilder
    implements Builder<SubredditListData, SubredditListDataBuilder> {
  _$SubredditListData _$v;

  ListBuilder<SubredditResponse> _children;
  ListBuilder<SubredditResponse> get children =>
      _$this._children ??= new ListBuilder<SubredditResponse>();
  set children(ListBuilder<SubredditResponse> children) =>
      _$this._children = children;

  SubredditListDataBuilder();

  SubredditListDataBuilder get _$this {
    if (_$v != null) {
      _children = _$v.children?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubredditListData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$SubredditListData;
  }

  @override
  void update(void Function(SubredditListDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubredditListData build() {
    _$SubredditListData _$result;
    try {
      _$result = _$v ?? new _$SubredditListData._(children: children.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubredditListData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
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
  final String name;
  @override
  final String displayName;
  @override
  final bool nsfw;
  @override
  final String primaryColor;
  @override
  final String iconUrl;
  @override
  final String subredditType;

  factory _$Subreddit([void Function(SubredditBuilder) updates]) =>
      (new SubredditBuilder()..update(updates)).build();

  _$Subreddit._(
      {this.name,
      this.displayName,
      this.nsfw,
      this.primaryColor,
      this.iconUrl,
      this.subredditType})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'name');
    }
    if (displayName == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'displayName');
    }
    if (subredditType == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'subredditType');
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
        displayName == other.displayName &&
        nsfw == other.nsfw &&
        primaryColor == other.primaryColor &&
        iconUrl == other.iconUrl &&
        subredditType == other.subredditType;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, name.hashCode), displayName.hashCode),
                    nsfw.hashCode),
                primaryColor.hashCode),
            iconUrl.hashCode),
        subredditType.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Subreddit')
          ..add('name', name)
          ..add('displayName', displayName)
          ..add('nsfw', nsfw)
          ..add('primaryColor', primaryColor)
          ..add('iconUrl', iconUrl)
          ..add('subredditType', subredditType))
        .toString();
  }
}

class SubredditBuilder implements Builder<Subreddit, SubredditBuilder> {
  _$Subreddit _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  bool _nsfw;
  bool get nsfw => _$this._nsfw;
  set nsfw(bool nsfw) => _$this._nsfw = nsfw;

  String _primaryColor;
  String get primaryColor => _$this._primaryColor;
  set primaryColor(String primaryColor) => _$this._primaryColor = primaryColor;

  String _iconUrl;
  String get iconUrl => _$this._iconUrl;
  set iconUrl(String iconUrl) => _$this._iconUrl = iconUrl;

  String _subredditType;
  String get subredditType => _$this._subredditType;
  set subredditType(String subredditType) =>
      _$this._subredditType = subredditType;

  SubredditBuilder();

  SubredditBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _displayName = _$v.displayName;
      _nsfw = _$v.nsfw;
      _primaryColor = _$v.primaryColor;
      _iconUrl = _$v.iconUrl;
      _subredditType = _$v.subredditType;
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
            name: name,
            displayName: displayName,
            nsfw: nsfw,
            primaryColor: primaryColor,
            iconUrl: iconUrl,
            subredditType: subredditType);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
