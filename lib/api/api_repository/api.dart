import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:reddigram/utils/jwt.dart';

class ApiApiRepository {
  final String Function() fetchRedditAccessToken;

  Dio _client;
  String _token;

  DateTime get _tokenExpiration => jwtExp(_token);

  ApiApiRepository({@required this.fetchRedditAccessToken})
      : assert(fetchRedditAccessToken != null) {
    _client = Dio(BaseOptions(
      baseUrl: 'https://reddigram-api.herokuapp.com',
    ));

    _client.interceptors.addAll([
      InterceptorsWrapper(onRequest: (options) async {
        if (_token == null || options.path.contains('authenticate')) {
          return options;
        }

        final minuteAgo = DateTime.now().subtract(Duration(minutes: 1));
        if (_tokenExpiration.isBefore(minuteAgo)) {
          await _refreshToken();
        }

        return options;
      }),
      InterceptorsWrapper(onRequest: (options) {
        // Refreshment of token
        if (_token != null) {
          options.headers['Authorization'] = 'Bearer $_token';
        }

        return options;
      }),
    ]);
  }

  Future<List<String>> suggestedSubreddits(
      List<String> subscribedSubreddits) async {
    return _client
        .post('/suggested-subreddits', data: subscribedSubreddits)
        .then((response) => List<String>.from(response.data));
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

  Future<void> _refreshToken() async {
    return authenticate(fetchRedditAccessToken());
  }

  void clearToken() {
    _token = null;
  }

  Future<List<String>> fetchSubscriptions() async {
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
