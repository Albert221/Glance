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
  final Subreddit subreddit;
  @override
  final String photoUrl;
  @override
  final double aspectRatio;
  @override
  final String thumbnailUrl;
  @override
  final int upvotes;
  @override
  final bool upvoted;
  @override
  final String redditUrl;

  factory _$Photo([void Function(PhotoBuilder) updates]) =>
      (new PhotoBuilder()..update(updates)).build();

  _$Photo._(
      {this.id,
      this.authorName,
      this.subreddit,
      this.photoUrl,
      this.aspectRatio,
      this.thumbnailUrl,
      this.upvotes,
      this.upvoted,
      this.redditUrl})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Photo', 'id');
    }
    if (authorName == null) {
      throw new BuiltValueNullFieldError('Photo', 'authorName');
    }
    if (subreddit == null) {
      throw new BuiltValueNullFieldError('Photo', 'subreddit');
    }
    if (photoUrl == null) {
      throw new BuiltValueNullFieldError('Photo', 'photoUrl');
    }
    if (aspectRatio == null) {
      throw new BuiltValueNullFieldError('Photo', 'aspectRatio');
    }
    if (thumbnailUrl == null) {
      throw new BuiltValueNullFieldError('Photo', 'thumbnailUrl');
    }
    if (upvotes == null) {
      throw new BuiltValueNullFieldError('Photo', 'upvotes');
    }
    if (upvoted == null) {
      throw new BuiltValueNullFieldError('Photo', 'upvoted');
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
        subreddit == other.subreddit &&
        photoUrl == other.photoUrl &&
        aspectRatio == other.aspectRatio &&
        thumbnailUrl == other.thumbnailUrl &&
        upvotes == other.upvotes &&
        upvoted == other.upvoted &&
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
                            $jc($jc($jc(0, id.hashCode), authorName.hashCode),
                                subreddit.hashCode),
                            photoUrl.hashCode),
                        aspectRatio.hashCode),
                    thumbnailUrl.hashCode),
                upvotes.hashCode),
            upvoted.hashCode),
        redditUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Photo')
          ..add('id', id)
          ..add('authorName', authorName)
          ..add('subreddit', subreddit)
          ..add('photoUrl', photoUrl)
          ..add('aspectRatio', aspectRatio)
          ..add('thumbnailUrl', thumbnailUrl)
          ..add('upvotes', upvotes)
          ..add('upvoted', upvoted)
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

  SubredditBuilder _subreddit;
  SubredditBuilder get subreddit =>
      _$this._subreddit ??= new SubredditBuilder();
  set subreddit(SubredditBuilder subreddit) => _$this._subreddit = subreddit;

  String _photoUrl;
  String get photoUrl => _$this._photoUrl;
  set photoUrl(String photoUrl) => _$this._photoUrl = photoUrl;

  double _aspectRatio;
  double get aspectRatio => _$this._aspectRatio;
  set aspectRatio(double aspectRatio) => _$this._aspectRatio = aspectRatio;

  String _thumbnailUrl;
  String get thumbnailUrl => _$this._thumbnailUrl;
  set thumbnailUrl(String thumbnailUrl) => _$this._thumbnailUrl = thumbnailUrl;

  int _upvotes;
  int get upvotes => _$this._upvotes;
  set upvotes(int upvotes) => _$this._upvotes = upvotes;

  bool _upvoted;
  bool get upvoted => _$this._upvoted;
  set upvoted(bool upvoted) => _$this._upvoted = upvoted;

  String _redditUrl;
  String get redditUrl => _$this._redditUrl;
  set redditUrl(String redditUrl) => _$this._redditUrl = redditUrl;

  PhotoBuilder();

  PhotoBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _authorName = _$v.authorName;
      _subreddit = _$v.subreddit?.toBuilder();
      _photoUrl = _$v.photoUrl;
      _aspectRatio = _$v.aspectRatio;
      _thumbnailUrl = _$v.thumbnailUrl;
      _upvotes = _$v.upvotes;
      _upvoted = _$v.upvoted;
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
              subreddit: subreddit.build(),
              photoUrl: photoUrl,
              aspectRatio: aspectRatio,
              thumbnailUrl: thumbnailUrl,
              upvotes: upvotes,
              upvoted: upvoted,
              redditUrl: redditUrl);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'subreddit';
        subreddit.build();
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

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
