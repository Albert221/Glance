import 'package:meta/meta.dart';
import 'package:reddigram/api/api.dart';

enum SubscriptionsBackendType { Api, Local }

class ApiRepositoriesFacade extends ApiApiRepository {
  final ApiLocalRepository localRepository = ApiLocalRepository();

  SubscriptionsBackendType _backendType = SubscriptionsBackendType.Local;

  ApiRepositoriesFacade({@required fetchRedditAccessToken})
      : assert(fetchRedditAccessToken != null),
        super(fetchRedditAccessToken: fetchRedditAccessToken);

  Future<void> useApi(String redditAccessToken) {
    return apiRepository
        .authenticate(redditAccessToken)
        .then((_) => _backendType = SubscriptionsBackendType.Api);
  }

  void useLocal() => _backendType = SubscriptionsBackendType.Local;

  @override
  Future<List<String>> fetchSubscriptions(
          {SubscriptionsBackendType forceBackend}) =>
      (forceBackend ?? _backendType) == SubscriptionsBackendType.Api
          ? super.fetchSubscriptions()
          : localRepository.fetchSubscriptions();

  @override
  Future<void> subscribeSubreddit(String name) =>
      _backendType == SubscriptionsBackendType.Api
          ? super.subscribeSubreddit(name)
          : localRepository.subscribeSubreddit(name);

  @override
  Future<void> unsubscribeSubreddit(String name) =>
      _backendType == SubscriptionsBackendType.Api
          ? super.unsubscribeSubreddit(name)
          : localRepository.unsubscribeSubreddit(name);
}
