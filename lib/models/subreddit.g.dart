// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subreddit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Subreddit extends Subreddit {
  @override
  final String name;
  @override
  final String redditUrl;
  @override
  final bool subscribed;

  factory _$Subreddit([void Function(SubredditBuilder) updates]) =>
      (new SubredditBuilder()..update(updates)).build();

  _$Subreddit._({this.name, this.redditUrl, this.subscribed}) : super._() {
    if (name == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'name');
    }
    if (redditUrl == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'redditUrl');
    }
    if (subscribed == null) {
      throw new BuiltValueNullFieldError('Subreddit', 'subscribed');
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
        redditUrl == other.redditUrl &&
        subscribed == other.subscribed;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, name.hashCode), redditUrl.hashCode), subscribed.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Subreddit')
          ..add('name', name)
          ..add('redditUrl', redditUrl)
          ..add('subscribed', subscribed))
        .toString();
  }
}

class SubredditBuilder implements Builder<Subreddit, SubredditBuilder> {
  _$Subreddit _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _redditUrl;
  String get redditUrl => _$this._redditUrl;
  set redditUrl(String redditUrl) => _$this._redditUrl = redditUrl;

  bool _subscribed;
  bool get subscribed => _$this._subscribed;
  set subscribed(bool subscribed) => _$this._subscribed = subscribed;

  SubredditBuilder();

  SubredditBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _redditUrl = _$v.redditUrl;
      _subscribed = _$v.subscribed;
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
            name: name, redditUrl: redditUrl, subscribed: subscribed);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
