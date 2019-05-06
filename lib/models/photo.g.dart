// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Photo extends Photo {
  @override
  final String id;
  @override
  final String authorName;
  @override
  final String subredditName;
  @override
  final PhotoMedia source;
  @override
  final PhotoMedia fullImage;
  @override
  final PhotoMedia thumbnail;
  @override
  final int upvotes;
  @override
  final bool upvoted;
  @override
  final bool nsfw;
  @override
  final String redditUrl;

  factory _$Photo([void Function(PhotoBuilder) updates]) =>
      (new PhotoBuilder()..update(updates)).build();

  _$Photo._(
      {this.id,
      this.authorName,
      this.subredditName,
      this.source,
      this.fullImage,
      this.thumbnail,
      this.upvotes,
      this.upvoted,
      this.nsfw,
      this.redditUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Photo', 'id');
    }
    if (authorName == null) {
      throw new BuiltValueNullFieldError('Photo', 'authorName');
    }
    if (subredditName == null) {
      throw new BuiltValueNullFieldError('Photo', 'subredditName');
    }
    if (source == null) {
      throw new BuiltValueNullFieldError('Photo', 'source');
    }
    if (fullImage == null) {
      throw new BuiltValueNullFieldError('Photo', 'fullImage');
    }
    if (thumbnail == null) {
      throw new BuiltValueNullFieldError('Photo', 'thumbnail');
    }
    if (upvotes == null) {
      throw new BuiltValueNullFieldError('Photo', 'upvotes');
    }
    if (upvoted == null) {
      throw new BuiltValueNullFieldError('Photo', 'upvoted');
    }
    if (nsfw == null) {
      throw new BuiltValueNullFieldError('Photo', 'nsfw');
    }
    if (redditUrl == null) {
      throw new BuiltValueNullFieldError('Photo', 'redditUrl');
    }
  }

  @override
  Photo rebuild(void Function(PhotoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PhotoBuilder toBuilder() => new PhotoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Photo &&
        id == other.id &&
        authorName == other.authorName &&
        subredditName == other.subredditName &&
        source == other.source &&
        fullImage == other.fullImage &&
        thumbnail == other.thumbnail &&
        upvotes == other.upvotes &&
        upvoted == other.upvoted &&
        nsfw == other.nsfw &&
        redditUrl == other.redditUrl;
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
                                    $jc($jc(0, id.hashCode),
                                        authorName.hashCode),
                                    subredditName.hashCode),
                                source.hashCode),
                            fullImage.hashCode),
                        thumbnail.hashCode),
                    upvotes.hashCode),
                upvoted.hashCode),
            nsfw.hashCode),
        redditUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Photo')
          ..add('id', id)
          ..add('authorName', authorName)
          ..add('subredditName', subredditName)
          ..add('source', source)
          ..add('fullImage', fullImage)
          ..add('thumbnail', thumbnail)
          ..add('upvotes', upvotes)
          ..add('upvoted', upvoted)
          ..add('nsfw', nsfw)
          ..add('redditUrl', redditUrl))
        .toString();
  }
}

class PhotoBuilder implements Builder<Photo, PhotoBuilder> {
  _$Photo _$v;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _authorName;
  String get authorName => _$this._authorName;
  set authorName(String authorName) => _$this._authorName = authorName;

  String _subredditName;
  String get subredditName => _$this._subredditName;
  set subredditName(String subredditName) =>
      _$this._subredditName = subredditName;

  PhotoMediaBuilder _source;
  PhotoMediaBuilder get source => _$this._source ??= new PhotoMediaBuilder();
  set source(PhotoMediaBuilder source) => _$this._source = source;

  PhotoMediaBuilder _fullImage;
  PhotoMediaBuilder get fullImage =>
      _$this._fullImage ??= new PhotoMediaBuilder();
  set fullImage(PhotoMediaBuilder fullImage) => _$this._fullImage = fullImage;

  PhotoMediaBuilder _thumbnail;
  PhotoMediaBuilder get thumbnail =>
      _$this._thumbnail ??= new PhotoMediaBuilder();
  set thumbnail(PhotoMediaBuilder thumbnail) => _$this._thumbnail = thumbnail;

  int _upvotes;
  int get upvotes => _$this._upvotes;
  set upvotes(int upvotes) => _$this._upvotes = upvotes;

  bool _upvoted;
  bool get upvoted => _$this._upvoted;
  set upvoted(bool upvoted) => _$this._upvoted = upvoted;

  bool _nsfw;
  bool get nsfw => _$this._nsfw;
  set nsfw(bool nsfw) => _$this._nsfw = nsfw;

  String _redditUrl;
  String get redditUrl => _$this._redditUrl;
  set redditUrl(String redditUrl) => _$this._redditUrl = redditUrl;

  PhotoBuilder();

  PhotoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _authorName = _$v.authorName;
      _subredditName = _$v.subredditName;
      _source = _$v.source?.toBuilder();
      _fullImage = _$v.fullImage?.toBuilder();
      _thumbnail = _$v.thumbnail?.toBuilder();
      _upvotes = _$v.upvotes;
      _upvoted = _$v.upvoted;
      _nsfw = _$v.nsfw;
      _redditUrl = _$v.redditUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Photo other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Photo;
  }

  @override
  void update(void Function(PhotoBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Photo build() {
    _$Photo _$result;
    try {
      _$result = _$v ??
          new _$Photo._(
              id: id,
              authorName: authorName,
              subredditName: subredditName,
              source: source.build(),
              fullImage: fullImage.build(),
              thumbnail: thumbnail.build(),
              upvotes: upvotes,
              upvoted: upvoted,
              nsfw: nsfw,
              redditUrl: redditUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'source';
        source.build();
        _$failedField = 'fullImage';
        fullImage.build();
        _$failedField = 'thumbnail';
        thumbnail.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Photo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$PhotoMedia extends PhotoMedia {
  @override
  final String url;
  @override
  final int width;
  @override
  final int height;

  factory _$PhotoMedia([void Function(PhotoMediaBuilder) updates]) =>
      (new PhotoMediaBuilder()..update(updates)).build();

  _$PhotoMedia._({this.url, this.width, this.height}) : super._() {
    if (url == null) {
      throw new BuiltValueNullFieldError('PhotoMedia', 'url');
    }
    if (width == null) {
      throw new BuiltValueNullFieldError('PhotoMedia', 'width');
    }
    if (height == null) {
      throw new BuiltValueNullFieldError('PhotoMedia', 'height');
    }
  }

  @override
  PhotoMedia rebuild(void Function(PhotoMediaBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PhotoMediaBuilder toBuilder() => new PhotoMediaBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PhotoMedia &&
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
    return (newBuiltValueToStringHelper('PhotoMedia')
          ..add('url', url)
          ..add('width', width)
          ..add('height', height))
        .toString();
  }
}

class PhotoMediaBuilder implements Builder<PhotoMedia, PhotoMediaBuilder> {
  _$PhotoMedia _$v;

  String _url;
  String get url => _$this._url;
  set url(String url) => _$this._url = url;

  int _width;
  int get width => _$this._width;
  set width(int width) => _$this._width = width;

  int _height;
  int get height => _$this._height;
  set height(int height) => _$this._height = height;

  PhotoMediaBuilder();

  PhotoMediaBuilder get _$this {
    if (_$v != null) {
      _url = _$v.url;
      _width = _$v.width;
      _height = _$v.height;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PhotoMedia other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PhotoMedia;
  }

  @override
  void update(void Function(PhotoMediaBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PhotoMedia build() {
    final _$result =
        _$v ?? new _$PhotoMedia._(url: url, width: width, height: height);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
