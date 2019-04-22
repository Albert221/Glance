// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ListingResponse> _$listingResponseSerializer =
    new _$ListingResponseSerializer();
Serializer<ListingData> _$listingDataSerializer = new _$ListingDataSerializer();
Serializer<Child> _$childSerializer = new _$ChildSerializer();
Serializer<ChildData> _$childDataSerializer = new _$ChildDataSerializer();
Serializer<Preview> _$previewSerializer = new _$PreviewSerializer();
Serializer<PreviewImage> _$previewImageSerializer =
    new _$PreviewImageSerializer();
Serializer<Image> _$imageSerializer = new _$ImageSerializer();

class _$ListingResponseSerializer
    implements StructuredSerializer<ListingResponse> {
  @override
  final Iterable<Type> types = const [ListingResponse, _$ListingResponse];
  @override
  final String wireName = 'ListingResponse';

  @override
  Iterable serialize(Serializers serializers, ListingResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ListingData)),
    ];

    return result;
  }

  @override
  ListingResponse deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListingResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(ListingData)) as ListingData);
          break;
      }
    }

    return result.build();
  }
}

class _$ListingDataSerializer implements StructuredSerializer<ListingData> {
  @override
  final Iterable<Type> types = const [ListingData, _$ListingData];
  @override
  final String wireName = 'ListingData';

  @override
  Iterable serialize(Serializers serializers, ListingData object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'children',
      serializers.serialize(object.children,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Child)])),
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
  ListingData deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ListingDataBuilder();

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
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Child)]))
              as BuiltList);
          break;
      }
    }

    return result.build();
  }
}

class _$ChildSerializer implements StructuredSerializer<Child> {
  @override
  final Iterable<Type> types = const [Child, _$Child];
  @override
  final String wireName = 'Child';

  @override
  Iterable serialize(Serializers serializers, Child object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'data',
      serializers.serialize(object.data,
          specifiedType: const FullType(ChildData)),
    ];

    return result;
  }

  @override
  Child deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChildBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'data':
          result.data.replace(serializers.deserialize(value,
              specifiedType: const FullType(ChildData)) as ChildData);
          break;
      }
    }

    return result.build();
  }
}

class _$ChildDataSerializer implements StructuredSerializer<ChildData> {
  @override
  final Iterable<Type> types = const [ChildData, _$ChildData];
  @override
  final String wireName = 'ChildData';

  @override
  Iterable serialize(Serializers serializers, ChildData object,
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
    ];
    if (object.preview != null) {
      result
        ..add('preview')
        ..add(serializers.serialize(object.preview,
            specifiedType: const FullType(Preview)));
    }

    return result;
  }

  @override
  ChildData deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChildDataBuilder();

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
        case 'thumbnail':
          result.thumbnail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$ListingResponse extends ListingResponse {
  @override
  final ListingData data;

  factory _$ListingResponse([void Function(ListingResponseBuilder) updates]) =>
      (new ListingResponseBuilder()..update(updates)).build();

  _$ListingResponse._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('ListingResponse', 'data');
    }
  }

  @override
  ListingResponse rebuild(void Function(ListingResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListingResponseBuilder toBuilder() =>
      new ListingResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListingResponse && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ListingResponse')..add('data', data))
        .toString();
  }
}

class ListingResponseBuilder
    implements Builder<ListingResponse, ListingResponseBuilder> {
  _$ListingResponse _$v;

  ListingDataBuilder _data;
  ListingDataBuilder get data => _$this._data ??= new ListingDataBuilder();
  set data(ListingDataBuilder data) => _$this._data = data;

  ListingResponseBuilder();

  ListingResponseBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListingResponse other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListingResponse;
  }

  @override
  void update(void Function(ListingResponseBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListingResponse build() {
    _$ListingResponse _$result;
    try {
      _$result = _$v ?? new _$ListingResponse._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListingResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ListingData extends ListingData {
  @override
  final String after;
  @override
  final String before;
  @override
  final BuiltList<Child> children;

  factory _$ListingData([void Function(ListingDataBuilder) updates]) =>
      (new ListingDataBuilder()..update(updates)).build();

  _$ListingData._({this.after, this.before, this.children}) : super._() {
    if (children == null) {
      throw new BuiltValueNullFieldError('ListingData', 'children');
    }
  }

  @override
  ListingData rebuild(void Function(ListingDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ListingDataBuilder toBuilder() => new ListingDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListingData &&
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
    return (newBuiltValueToStringHelper('ListingData')
          ..add('after', after)
          ..add('before', before)
          ..add('children', children))
        .toString();
  }
}

class ListingDataBuilder implements Builder<ListingData, ListingDataBuilder> {
  _$ListingData _$v;

  String _after;
  String get after => _$this._after;
  set after(String after) => _$this._after = after;

  String _before;
  String get before => _$this._before;
  set before(String before) => _$this._before = before;

  ListBuilder<Child> _children;
  ListBuilder<Child> get children =>
      _$this._children ??= new ListBuilder<Child>();
  set children(ListBuilder<Child> children) => _$this._children = children;

  ListingDataBuilder();

  ListingDataBuilder get _$this {
    if (_$v != null) {
      _after = _$v.after;
      _before = _$v.before;
      _children = _$v.children?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ListingData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ListingData;
  }

  @override
  void update(void Function(ListingDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ListingData build() {
    _$ListingData _$result;
    try {
      _$result = _$v ??
          new _$ListingData._(
              after: after, before: before, children: children.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'children';
        children.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ListingData', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Child extends Child {
  @override
  final ChildData data;

  factory _$Child([void Function(ChildBuilder) updates]) =>
      (new ChildBuilder()..update(updates)).build();

  _$Child._({this.data}) : super._() {
    if (data == null) {
      throw new BuiltValueNullFieldError('Child', 'data');
    }
  }

  @override
  Child rebuild(void Function(ChildBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChildBuilder toBuilder() => new ChildBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Child && data == other.data;
  }

  @override
  int get hashCode {
    return $jf($jc(0, data.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Child')..add('data', data)).toString();
  }
}

class ChildBuilder implements Builder<Child, ChildBuilder> {
  _$Child _$v;

  ChildDataBuilder _data;
  ChildDataBuilder get data => _$this._data ??= new ChildDataBuilder();
  set data(ChildDataBuilder data) => _$this._data = data;

  ChildBuilder();

  ChildBuilder get _$this {
    if (_$v != null) {
      _data = _$v.data?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Child other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Child;
  }

  @override
  void update(void Function(ChildBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Child build() {
    _$Child _$result;
    try {
      _$result = _$v ?? new _$Child._(data: data.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'data';
        data.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Child', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ChildData extends ChildData {
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
  final String thumbnail;
  @override
  final Preview preview;

  factory _$ChildData([void Function(ChildDataBuilder) updates]) =>
      (new ChildDataBuilder()..update(updates)).build();

  _$ChildData._(
      {this.name,
      this.title,
      this.subreddit,
      this.permalink,
      this.author,
      this.score,
      this.thumbnail,
      this.preview})
      : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('ChildData', 'name');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('ChildData', 'title');
    }
    if (subreddit == null) {
      throw new BuiltValueNullFieldError('ChildData', 'subreddit');
    }
    if (permalink == null) {
      throw new BuiltValueNullFieldError('ChildData', 'permalink');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('ChildData', 'author');
    }
    if (score == null) {
      throw new BuiltValueNullFieldError('ChildData', 'score');
    }
    if (thumbnail == null) {
      throw new BuiltValueNullFieldError('ChildData', 'thumbnail');
    }
  }

  @override
  ChildData rebuild(void Function(ChildDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChildDataBuilder toBuilder() => new ChildDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChildData &&
        name == other.name &&
        title == other.title &&
        subreddit == other.subreddit &&
        permalink == other.permalink &&
        author == other.author &&
        score == other.score &&
        thumbnail == other.thumbnail &&
        preview == other.preview;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, name.hashCode), title.hashCode),
                            subreddit.hashCode),
                        permalink.hashCode),
                    author.hashCode),
                score.hashCode),
            thumbnail.hashCode),
        preview.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChildData')
          ..add('name', name)
          ..add('title', title)
          ..add('subreddit', subreddit)
          ..add('permalink', permalink)
          ..add('author', author)
          ..add('score', score)
          ..add('thumbnail', thumbnail)
          ..add('preview', preview))
        .toString();
  }
}

class ChildDataBuilder implements Builder<ChildData, ChildDataBuilder> {
  _$ChildData _$v;

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

  String _thumbnail;
  String get thumbnail => _$this._thumbnail;
  set thumbnail(String thumbnail) => _$this._thumbnail = thumbnail;

  PreviewBuilder _preview;
  PreviewBuilder get preview => _$this._preview ??= new PreviewBuilder();
  set preview(PreviewBuilder preview) => _$this._preview = preview;

  ChildDataBuilder();

  ChildDataBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _title = _$v.title;
      _subreddit = _$v.subreddit;
      _permalink = _$v.permalink;
      _author = _$v.author;
      _score = _$v.score;
      _thumbnail = _$v.thumbnail;
      _preview = _$v.preview?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChildData other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ChildData;
  }

  @override
  void update(void Function(ChildDataBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChildData build() {
    _$ChildData _$result;
    try {
      _$result = _$v ??
          new _$ChildData._(
              name: name,
              title: title,
              subreddit: subreddit,
              permalink: permalink,
              author: author,
              score: score,
              thumbnail: thumbnail,
              preview: _preview?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'preview';
        _preview?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ChildData', _$failedField, e.toString());
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
