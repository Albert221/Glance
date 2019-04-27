import 'dart:convert';
import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:package_info/package_info.dart';
import 'package:reddigram/api/api.dart';
import 'package:reddigram/consts.dart';

class RedditTokens {
  final String accessToken;
  final String refreshToken;
  final DateTime expirationTime;

  RedditTokens(
      {@required this.accessToken,
      @required this.refreshToken,
      @required this.expirationTime})
      : assert(accessToken != null),
        assert(refreshToken != null),
        assert(expirationTime != null);

  RedditTokens copyWith(
      {String accessToken, String refreshToken, DateTime expirationTime}) {
    return RedditTokens(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expirationTime: expirationTime ?? this.expirationTime,
    );
  }
}

class RedditRepository {
  Dio _client;

  RedditTokens _tokens;

  RedditRepository() {
    _client = Dio(BaseOptions(
      baseUrl: 'https://www.reddit.com',
    ));

    _client.interceptors.add(InterceptorsWrapper(onRequest: (options) {
      if (_tokens != null) {
        options.headers['Authorization'] = 'Bearer ${_tokens.accessToken}';
        options.baseUrl = 'https://oauth.reddit.com';
      }

      return options;
    }));

    // Refreshment of access token
    _client.interceptors.add(InterceptorsWrapper(onRequest: (options) async {
      if (_tokens == null || options.path.contains('access_token')) {
        // skip if we aren't authorized
        return options;
      }

      final minuteAgo = DateTime.now().subtract(Duration(minutes: 1));
      if (_tokens.expirationTime.isBefore(minuteAgo)) {
        await refreshAccessToken();
      }

      return options;
    }));

    PackageInfo.fromPlatform().then((info) =>
        _client.options.headers['User-Agent'] =
            '${info.packageName}:${info.version} (by /u/Albert221)');
  }

  Future<Response> post(String path,
      {String data, Map<String, dynamic> headers}) async {
    return _client.post(
      path,
      data: data,
      options: Options(
        headers: headers,
        contentType: ContentType.parse('application/x-www-form-urlencoded'),
      ),
    );
  }

  Future<RedditTokens> refreshAccessToken([String refreshToken]) {
    final basicAuth = 'Basic ' +
        base64.encode(utf8.encode('${ReddigramConsts.oauthClientId}:'));

    return post(
      '/api/v1/access_token',
      data:
          'grant_type=refresh_token&refresh_token=${refreshToken ?? _tokens.refreshToken}',
      headers: {'Authorization': basicAuth},
    ).then((response) {
      if (_tokens == null && refreshToken != null) {
        // we will populate it with correct data in a second
        _tokens = RedditTokens(
          accessToken: '',
          refreshToken: refreshToken,
          expirationTime: DateTime.now(),
        );
      }

      return _tokens = _tokens.copyWith(
        accessToken: response.data['access_token'],
        expirationTime:
            DateTime.now().add(Duration(seconds: response.data['expires_in'])),
      );
    });
  }

  void clearTokens() {
    _tokens = null;
  }

  void _assertAuthorized() {
    assert(_tokens != null, 'User required.');
  }

  Future<RedditTokens> retrieveTokens(String code) async {
    final basicAuth = 'Basic ' +
        base64.encode(utf8.encode('${ReddigramConsts.oauthClientId}:'));

    return post(
      '/api/v1/access_token',
      data: 'grant_type=authorization_code&code=$code'
          '&redirect_uri=https://reddigram.wolszon.me/redirect',
      headers: {'Authorization': basicAuth},
    ).then((response) {
      return _tokens = RedditTokens(
        accessToken: response.data['access_token'],
        refreshToken: response.data['refresh_token'],
        expirationTime:
            DateTime.now().add(Duration(seconds: response.data['expires_in'])),
      );
    });
  }

  static ListingResponse _filterOnlyPhotos(ListingResponse response) {
    return response.rebuild((b) => b
      ..data = response.data
          .rebuild((b) => b
            ..children = ListBuilder(response.data.children
                .where((child) => child.data.preview != null)))
          .toBuilder());
  }

  Future<ListingResponse> best({String after = '', int limit = 25}) async {
    return _client
        .get('/best.json?after=$after&limit=$limit')
        .then((response) => serializers.deserializeWith(
            ListingResponse.serializer, response.data))
        .then(_filterOnlyPhotos);
  }

  Future<ListingResponse> subreddit(String name,
      {String after = '', int limit = 25}) async {
    assert(name.isNotEmpty);

    return _client
        .get('/r/$name.json?after=$after&limit=$limit')
        .then((response) {
          final x = serializers.deserializeWith(
            ListingResponse.serializer, response.data);

          return x;
        })
        .then(_filterOnlyPhotos);
  }

  Future<String> username() async {
    _assertAuthorized();

    return _client.get('/api/v1/me').then((response) => response.data['name']);
  }

  Future<void> upvote(String id) async {
    _assertAuthorized();

    return post('/api/vote', data: 'dir=1&id=$id');
  }

  Future<void> cancelUpvote(String id) async {
    _assertAuthorized();

    return post('/api/vote', data: 'dir=0&id=$id');
  }
}
