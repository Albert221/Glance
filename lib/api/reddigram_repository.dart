import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:reddigram/utils/jwt.dart';

class ReddigramRepository {
  final String Function() fetchRedditAccessToken;

  Dio _client;
  String _token;

  DateTime get _tokenExpiration => jwtExp(_token);

  ReddigramRepository({@required this.fetchRedditAccessToken})
      : assert(fetchRedditAccessToken != null) {
    _client = Dio(BaseOptions(
      baseUrl: 'https://reddigram-api.herokuapp.com',
    ));

    _client.interceptors.add(InterceptorsWrapper(onRequest: (options) {
      if (_token != null) {
        options.headers['Authorization'] = 'Bearer $_token';
      }

      return options;
    }));

    // Refreshment of token
    _client.interceptors.add(InterceptorsWrapper(onRequest: (options) async {
      if (_token == null || options.path.contains('refresh_token')) {
        return options;
      }

      final minuteAgo = DateTime.now().subtract(Duration(minutes: 1));
      if (_tokenExpiration.isBefore(minuteAgo)) {
        await refreshToken();
      }

      return options;
    }));
  }

  Future<void> authenticate(String redditAccessToken) async {
    return _client
        .post('/authenticate',
            data: 'access_token=$redditAccessToken',
            options: Options(
                contentType:
                    ContentType.parse('application/x-www-form-urlencoded')))
        .then((response) => _token = response.data);
  }

  Future<void> refreshToken() async {
    return authenticate(fetchRedditAccessToken());
  }

  void clearToken() {
    _token = null;
  }

  Future<List<String>> fetchSubscribedSubreddits() async {
    return _client
        .get('/subscriptions')
        .then((response) => List<String>.from(response.data));
  }

  Future<void> subscribeSubreddit(String name) async {
    return _client.put('/subscriptions/$name');
  }

  Future<void> unsubscribeSubreddit(String name) async {
    return _client.delete('/subscriptions/$name');
  }
}
