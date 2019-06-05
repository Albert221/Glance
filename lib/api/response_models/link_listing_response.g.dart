// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link_listing_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<LinkListingResponse> _$linkListingResponseSerializer =
    new _$LinkListingResponseSerializer();
Serializer<LinkListingData> _$linkListingDataSerializer =
    new _$LinkListingDataSerializer();
Serializer<LinkChild> _$linkChildSerializer = new _$LinkChildSerializer();
Serializer<LinkChildData> _$linkChildDataSerializer =
    new _$LinkChildDataSerializer();
Serializer<Preview> _$previewSerializer = new _$PreviewSerializer();
Serializer<PreviewImage> _$previewImageSerializer =
    new _$PreviewImageSerializer();
Serializer<Image> _$imageSerializer = new _$ImageSerializer();

class _$LinkListingResponseSerializer
    implements StructuredSerializer<LinkListingResponse> {
  @override
  final Iterable<Type> types = const [
    LinkListingResponse,
    _$LinkListingResponse
  ];
  @override
  final String wireName = 'LinkListingResponse';

  @override
  Iterable serialize(Serializers serializers, LinkListingResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(LinkListingData)),
    ];

    return result;
  }

  @override
  LinkListingResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LinkListingResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
                  specifiedType: const FullType(LinkListingData))
              as LinkListingData);
          break;
      }
    }

    return result.build();
  }
}

class _$LinkListingDataSerializer
    implements StructuredSerializer<LinkListingData> {
  @override
  final Iterable<Type> types = const [LinkListingData, _$LinkListingData];
  @override
  final String wireName = 'LinkListingData';

  @override
  Iterable serialize(Serializers serializers, LinkListingData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'children',
      serializers.serialize(object.children,
          specifiedType:
              const FullType(BuiltList, const [const FullType(LinkChild)])),
    ];
    if (object.after != null) {
      result
        ..add('after')
        ..add(serializers.serialize(object.after,
            specifiedType: const FullType(String)));
    }
    if (object.before != null) {
      result
        ..add('before')
        ..add(serializers.serialize(object.before,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  LinkListingData deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LinkListingDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'after':
          result.after = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'before':
          result.before = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'children':
          result.children.replace(serializers.deserialize(value,
              specifiedType: const FullType(
                  BuiltList, const [const FullType(LinkChild)])) as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$LinkChildSerializer implements StructuredSerializer<LinkChild> {
  @override
  final Iterable<Type> types = const [LinkChild, _$LinkChild];
  @override
  final String wireName = 'LinkChild';

  @override
  Iterable serialize(Serializers serializers, LinkChild object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(LinkChildData)),
    ];

    return result;
  }

  @override
  LinkChild deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LinkChildBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(LinkChildData)) as LinkChildData);
          break;
      }
    }

    return result.build();
  }
}

class _$LinkChildDataSerializer implements StructuredSerializer<LinkChildData> {
  @override
  final Iterable<Type> types = const [LinkChildData, _$LinkChildData];
  @override
  final String wireName = 'LinkChildData';

  @override
  Iterable serialize(Serializers serializers, LinkChildData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'subreddit',
      serializers.serialize(object.subreddit,
          specifiedType: const FullType(String)),
      'permalink',
      serializers.serialize(object.permalink,
          specifiedType: const FullType(String)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(String)),
      'score',
      serializers.serialize(object.score, specifiedType: const FullType(int)),
      'thumbnail',
      serializers.serialize(object.thumbnail,
          specifiedType: const FullType(String)),
      'over_18',
      serializers.serialize(object.over18, specifiedType: const FullType(bool)),
    ];
    if (object.likes != null) {
      result
        ..add('likes')
        ..add(serializers.serialize(object.likes,
            specifiedType: const FullType(bool)));
    }
    if (object.thumbnailWidth != null) {
      result
        ..add('thumbnail_width')
        ..add(serializers.serialize(object.thumbnailWidth,
            specifiedType: const FullType(int)));
    }
    if (object.thumbnailHeight != null) {
      result
        ..add('thumbnail_height')
        ..add(serializers.serialize(object.thumbnailHeight,
            specifiedType: const FullType(int)));
    }
    if (object.preview != null) {
      result
        ..add('preview')
        ..add(serializers.serialize(object.preview,
            specifiedType: const FullType(Preview)));
    }
    return result;
  }

  @override
  LinkChildData deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LinkChildDataBuilder();

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
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subreddit':
          result.subreddit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'permalink':
          result.permalink = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'author':
          result.author = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'score':
          result.score = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'likes':
          result.likes = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'thumbnail':
          result.thumbnail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumbnail_width':
          result.thumbnailWidth = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'thumbnail_height':
          result.thumbnailHeight = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'over_18':
          result.over18 = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'preview':
          result.preview.replace(serializers.deserialize(value,
              specifiedType: const FullType(Preview)) as Preview);
          break;
      }
    }

    return result.build();
  }
}

class _$PreviewSerializer implements StructuredSerializer<Preview> {
  @override
  final Iterable<Type> types = const [Preview, _$Preview];
  @override
  final String wireName = 'Preview';

  @override
  Iterable serialize(Serializers serializers, Preview object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'images',
      serializers.serialize(object.images,
          specifiedType:
              const FullType(BuiltList, const [const FullType(PreviewImage)])),
    ];

    return result;
  }

  @override
  Preview deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PreviewBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'images':
          result.images.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(PreviewImage)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$PreviewImageSerializer implements StructuredSerializer<PreviewImage> {
  @override
  final Iterable<Type> types = const [PreviewImage, _$PreviewImage];
  @override
  final String wireName = 'PreviewImage';

  @override
  Iterable serialize(Serializers serializers, PreviewImage object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'source',
      serializers.serialize(object.source,
          specifiedType: const FullType(Image)),
      'resolutions',
      serializers.serialize(object.resolutions,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Image)])),
    ];

    return result;
  }

  @override
  PreviewImage deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PreviewImageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'source':
          result.source.replace(serializers.deserialize(value,
              specifiedType: const FullType(Image)) as Image);
          break;
        case 'resolutions':
          result.resolutions.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Image)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$ImageSerializer implements StructuredSerializer<Image> {
  @override
  final Iterable<Type> types = const [Image, _$Image];
  @override
  final String wireName = 'Image';

  @override
  Iterable serialize(Serializers serializers, Image object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'width',
      serializers.serialize(object.width, specifiedType: const FullType(int)),
      'height',
      serializers.serialize(object.height, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  Image deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ImageBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'width':
          result.width = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'height':
          result.height = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$LinkListingResponse extends LinkListingResponse {
  @override
  final LinkListingData data;

  factory _$LinkListingResponse(
          [void Function(LinkListingResponseBuilder) updates]) =>
      (new LinkListingResponseBuilder()..update(updates)).build();

  _$LinkListingResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('LinkListingResponse', 'data');
    }
  }

  @override
  LinkListingResponse rebuild(
          void Function(LinkListingResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkListingResponseBuilder toBuilder() =>
      new LinkListingResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkListingResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LinkListingResponse')
          ..add('data', data))
        .toString();
  }
}

class LinkListingResponseBuilder
    implements Builder<LinkListingResponse, LinkListingResponseBuilder> {
  _$LinkListingResponse _$v;

  LinkListingDataBuilder _data;
  LinkListingDataBuilder get data =>
      _$this._data ??= new LinkListingDataBuilder();
  set data(LinkListingDataBuilder data) => _$this._data = data;

  LinkListingResponseBuilder();

  LinkListingResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkListingResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LinkListingResponse;
  }

  @override
  void update(void Function(LinkListingResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LinkListingResponse build() {
    _$LinkListingResponse _$result;
    try {
      _$result = _$v ?? new _$LinkListingResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LinkListingResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LinkListingData extends LinkListingData {
  @override
  final String after;
  @override
  final String before;
  @override
  final BuiltList<LinkChild> children;

  factory _$LinkListingData([void Function(LinkListingDataBuilder) updates]) =>
      (new LinkListingDataBuilder()..update(updates)).build();

  _$LinkListingData._({this.after, this.before, this.children}) : super._() {
    if (children == null) {
      throw new BuiltValueNullFieldError('LinkListingData', 'children');
    }
  }

  @override
  LinkListingData rebuild(void Function(LinkListingDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkListingDataBuilder toBuilder() =>
      new LinkListingDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkListingData &&
        after == other.after &&
        before == other.before &&
        children == other.children;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, after.hashCode), before.hashCode), children.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LinkListingData')
          ..add('after', after)
          ..add('before', before)
          ..add('children', children))
        .toString();
  }
}

class LinkListingDataBuilder
    implements Builder<LinkListingData, LinkListingDataBuilder> {
  _$LinkListingData _$v;

  String _after;
  String get after => _$this._after;
  set after(String after) => _$this._after = after;

  String _before;
  String get before => _$this._before;
  set before(String before) => _$this._before = before;

  ListBuilder<LinkChild> _children;
  ListBuilder<LinkChild> get children =>
      _$this._children ??= new ListBuilder<LinkChild>();
  set children(ListBuilder<LinkChild> children) => _$this._children = children;

  LinkListingDataBuilder();

  LinkListingDataBuilder get _$this {
    if (_$v != null) {
      _after = _$v.after;
      _before = _$v.before;
      _children = _$v.children?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkListingData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LinkListingData;
  }

  @override
  void update(void Function(LinkListingDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LinkListingData build() {
    _$LinkListingData _$result;
    try {
      _$result = _$v ??
          new _$LinkListingData._(
              after: after, before: before, children: children.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LinkListingData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LinkChild extends LinkChild {
  @override
  final LinkChildData data;

  factory _$LinkChild([void Function(LinkChildBuilder) updates]) =>
      (new LinkChildBuilder()..update(updates)).build();

  _$LinkChild._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('LinkChild', 'data');
    }
  }

  @override
  LinkChild rebuild(void Function(LinkChildBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkChildBuilder toBuilder() => new LinkChildBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkChild && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LinkChild')..add('data', data))
        .toString();
  }
}

class LinkChildBuilder implements Builder<LinkChild, LinkChildBuilder> {
  _$LinkChild _$v;

  LinkChildDataBuilder _data;
  LinkChildDataBuilder get data => _$this._data ??= new LinkChildDataBuilder();
  set data(LinkChildDataBuilder data) => _$this._data = data;

  LinkChildBuilder();

  LinkChildBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkChild other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LinkChild;
  }

  @override
  void update(void Function(LinkChildBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LinkChild build() {
    _$LinkChild _$result;
    try {
      _$result = _$v ?? new _$LinkChild._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LinkChild', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$LinkChildData extends LinkChildData {
  @override
  final String name;
  @override
  final String title;
  @override
  final String subreddit;
  @override
  final String permalink;
  @override
  final String author;
  @override
  final int score;
  @override
  final bool likes;
  @override
  final String thumbnail;
  @override
  final int thumbnailWidth;
  @override
  final int thumbnailHeight;
  @override
  final bool over18;
  @override
  final Preview preview;

  factory _$LinkChildData([void Function(LinkChildDataBuilder) updates]) =>
      (new LinkChildDataBuilder()..update(updates)).build();

  _$LinkChildData._(
      {this.name,
      this.title,
      this.subreddit,
      this.permalink,
      this.author,
      this.score,
      this.likes,
      this.thumbnail,
      this.thumbnailWidth,
      this.thumbnailHeight,
      this.over18,
      this.preview})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('LinkChildData', 'name');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('LinkChildData', 'title');
    }
    if (subreddit == null) {
      throw new BuiltValueNullFieldError('LinkChildData', 'subreddit');
    }
    if (permalink == null) {
      throw new BuiltValueNullFieldError('LinkChildData', 'permalink');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('LinkChildData', 'author');
    }
    if (score == null) {
      throw new BuiltValueNullFieldError('LinkChildData', 'score');
    }
    if (thumbnail == null) {
      throw new BuiltValueNullFieldError('LinkChildData', 'thumbnail');
    }
    if (over18 == null) {
      throw new BuiltValueNullFieldError('LinkChildData', 'over18');
    }
  }

  @override
  LinkChildData rebuild(void Function(LinkChildDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LinkChildDataBuilder toBuilder() => new LinkChildDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LinkChildData &&
        name == other.name &&
        title == other.title &&
        subreddit == other.subreddit &&
        permalink == other.permalink &&
        author == other.author &&
        score == other.score &&
        likes == other.likes &&
        thumbnail == other.thumbnail &&
        thumbnailWidth == other.thumbnailWidth &&
        thumbnailHeight == other.thumbnailHeight &&
        over18 == other.over18 &&
        preview == other.preview;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, name.hashCode),
                                                title.hashCode),
                                            subreddit.hashCode),
                                        permalink.hashCode),
                                    author.hashCode),
                                score.hashCode),
                            likes.hashCode),
                        thumbnail.hashCode),
                    thumbnailWidth.hashCode),
                thumbnailHeight.hashCode),
            over18.hashCode),
        preview.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LinkChildData')
          ..add('name', name)
          ..add('title', title)
          ..add('subreddit', subreddit)
          ..add('permalink', permalink)
          ..add('author', author)
          ..add('score', score)
          ..add('likes', likes)
          ..add('thumbnail', thumbnail)
          ..add('thumbnailWidth', thumbnailWidth)
          ..add('thumbnailHeight', thumbnailHeight)
          ..add('over18', over18)
          ..add('preview', preview))
        .toString();
  }
}

class LinkChildDataBuilder
    implements Builder<LinkChildData, LinkChildDataBuilder> {
  _$LinkChildData _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _subreddit;
  String get subreddit => _$this._subreddit;
  set subreddit(String subreddit) => _$this._subreddit = subreddit;

  String _permalink;
  String get permalink => _$this._permalink;
  set permalink(String permalink) => _$this._permalink = permalink;

  String _author;
  String get author => _$this._author;
  set author(String author) => _$this._author = author;

  int _score;
  int get score => _$this._score;
  set score(int score) => _$this._score = score;

  bool _likes;
  bool get likes => _$this._likes;
  set likes(bool likes) => _$this._likes = likes;

  String _thumbnail;
  String get thumbnail => _$this._thumbnail;
  set thumbnail(String thumbnail) => _$this._thumbnail = thumbnail;

  int _thumbnailWidth;
  int get thumbnailWidth => _$this._thumbnailWidth;
  set thumbnailWidth(int thumbnailWidth) =>
      _$this._thumbnailWidth = thumbnailWidth;

  int _thumbnailHeight;
  int get thumbnailHeight => _$this._thumbnailHeight;
  set thumbnailHeight(int thumbnailHeight) =>
      _$this._thumbnailHeight = thumbnailHeight;

  bool _over18;
  bool get over18 => _$this._over18;
  set over18(bool over18) => _$this._over18 = over18;

  PreviewBuilder _preview;
  PreviewBuilder get preview => _$this._preview ??= new PreviewBuilder();
  set preview(PreviewBuilder preview) => _$this._preview = preview;

  LinkChildDataBuilder();

  LinkChildDataBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _title = _$v.title;
      _subreddit = _$v.subreddit;
      _permalink = _$v.permalink;
      _author = _$v.author;
      _score = _$v.score;
      _likes = _$v.likes;
      _thumbnail = _$v.thumbnail;
      _thumbnailWidth = _$v.thumbnailWidth;
      _thumbnailHeight = _$v.thumbnailHeight;
      _over18 = _$v.over18;
      _preview = _$v.preview?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LinkChildData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LinkChildData;
  }

  @override
  void update(void Function(LinkChildDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LinkChildData build() {
    _$LinkChildData _$result;
    try {
      _$result = _$v ??
          new _$LinkChildData._(
              name: name,
              title: title,
              subreddit: subreddit,
              permalink: permalink,
              author: author,
              score: score,
              likes: likes,
              thumbnail: thumbnail,
              thumbnailWidth: thumbnailWidth,
              thumbnailHeight: thumbnailHeight,
              over18: over18,
              preview: _preview?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'preview';
        _preview?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LinkChildData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Preview extends Preview {
  @override
  final BuiltList<PreviewImage> images;

  factory _$Preview([void Function(PreviewBuilder) updates]) =>
      (new PreviewBuilder()..update(updates)).build();

  _$Preview._({this.images}) : super._() {
    if (images == null) {
      throw new BuiltValueNullFieldError('Preview', 'images');
    }
  }

  @override
  Preview rebuild(void Function(PreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreviewBuilder toBuilder() => new PreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Preview && images == other.images;
  }

  @override
  int get hashCode {
    return $jf($jc(0, images.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Preview')..add('images', images))
        .toString();
  }
}

class PreviewBuilder implements Builder<Preview, PreviewBuilder> {
  _$Preview _$v;

  ListBuilder<PreviewImage> _images;
  ListBuilder<PreviewImage> get images =>
      _$this._images ??= new ListBuilder<PreviewImage>();
  set images(ListBuilder<PreviewImage> images) => _$this._images = images;

  PreviewBuilder();

  PreviewBuilder get _$this {
    if (_$v != null) {
      _images = _$v.images?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Preview other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Preview;
  }

  @override
  void update(void Function(PreviewBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Preview build() {
    _$Preview _$result;
    try {
      _$result = _$v ?? new _$Preview._(images: images.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'images';
        images.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Preview', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PreviewImage extends PreviewImage {
  @override
  final Image source;
  @override
  final BuiltList<Image> resolutions;

  factory _$PreviewImage([void Function(PreviewImageBuilder) updates]) =>
      (new PreviewImageBuilder()..update(updates)).build();

  _$PreviewImage._({this.source, this.resolutions}) : super._() {
    if (source == null) {
      throw new BuiltValueNullFieldError('PreviewImage', 'source');
    }
    if (resolutions == null) {
      throw new BuiltValueNullFieldError('PreviewImage', 'resolutions');
    }
  }

  @override
  PreviewImage rebuild(void Function(PreviewImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PreviewImageBuilder toBuilder() => new PreviewImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PreviewImage &&
        source == other.source &&
        resolutions == other.resolutions;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, source.hashCode), resolutions.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PreviewImage')
          ..add('source', source)
          ..add('resolutions', resolutions))
        .toString();
  }
}

class PreviewImageBuilder
    implements Builder<PreviewImage, PreviewImageBuilder> {
  _$PreviewImage _$v;

  ImageBuilder _source;
  ImageBuilder get source => _$this._source ??= new ImageBuilder();
  set source(ImageBuilder source) => _$this._source = source;

  ListBuilder<Image> _resolutions;
  ListBuilder<Image> get resolutions =>
      _$this._resolutions ??= new ListBuilder<Image>();
  set resolutions(ListBuilder<Image> resolutions) =>
      _$this._resolutions = resolutions;

  PreviewImageBuilder();

  PreviewImageBuilder get _$this {
    if (_$v != null) {
      _source = _$v.source?.toBuilder();
      _resolutions = _$v.resolutions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PreviewImage other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PreviewImage;
  }

  @override
  void update(void Function(PreviewImageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PreviewImage build() {
    _$PreviewImage _$result;
    try {
      _$result = _$v ??
          new _$PreviewImage._(
              source: source.build(), resolutions: resolutions.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'source';
        source.build();
        _$failedField = 'resolutions';
        resolutions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PreviewImage', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Image extends Image {
  @override
  final String url;
  @override
  final int width;
  @override
  final int height;

  factory _$Image([void Function(ImageBuilder) updates]) =>
      (new ImageBuilder()..update(updates)).build();

  _$Image._({this.url, this.width, this.height}) : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('Image', 'url');
    }
    if (width == null) {
      throw new BuiltValueNullFieldError('Image', 'width');
    }
    if (height == null) {
      throw new BuiltValueNullFieldError('Image', 'height');
    }
  }

  @override
  Image rebuild(void Function(ImageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ImageBuilder toBuilder() => new ImageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Image &&
        url == other.url &&
        width == other.width &&
        height == other.height;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, url.hashCode), width.hashCode), height.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Image')
          ..add('url', url)
          ..add('width', width)
          ..add('height', height))
        .toString();
  }
}

class ImageBuilder implements Builder<Image, ImageBuilder> {
  _$Image _$v;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  int _width;
  int get width => _$this._width;
  set width(int width) => _$this._width = width;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  ImageBuilder();

  ImageBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _width = _$v.width;
      _height = _$v.height;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Image other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Image;
  }

  @override
  void update(void Function(ImageBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Image build() {
    final _$result =
        _$v ?? new _$Image._(url: url, width: width, height: height);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
