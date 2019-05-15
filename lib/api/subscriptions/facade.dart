import 'package:meta/meta.dart';
import 'package:reddigram/api/api.dart';

enum SubscriptionsBackendType { Api, Local }

class SubscriptionRepositoriesFacade implements SubscriptionRepository {
  final SubscriptionApiRepository apiRepository;
  final SubscriptionsLocalRepository localRepository;

  SubscriptionsBackendType _backendType = SubscriptionsBackendType.Local;

  SubscriptionRepositoriesFacade(
      {@required this.apiRepository, @required this.localRepository})
      : assert(apiRepository != null),
        assert(localRepository != null);

  Future<void> useApi(String redditAccessToken) {
    return apiRepository
        .authenticate(redditAccessToken)
        .then((_) => _backendType = SubscriptionsBackendType.Api);
  }

  void useLocal() => _backendType = SubscriptionsBackendType.Local;

  @override
  Future<List<String>> fetchSubscribedSubreddits() =>
      _backendType == SubscriptionsBackendType.Api
          ? apiRepository.fetchSubscribedSubreddits()
          : localRepository.fetchSubscribedSubreddits();

  @override
  Future<void> subscribeSubreddit(String name) =>
      _backendType == SubscriptionsBackendType.Api
          ? apiRepository.subscribeSubreddit(name)
          : localRepository.subscribeSubreddit(name);

  @override
  Future<void> unsubscribeSubreddit(String name) =>
      _backendType == SubscriptionsBackendType.Api
          ? apiRepository.unsubscribeSubreddit(name)
          : localRepository.unsubscribeSubreddit(name);
}
