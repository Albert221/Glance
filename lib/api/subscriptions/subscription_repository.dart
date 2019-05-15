abstract class SubscriptionRepository {
  Future<List<String>> fetchSubscribedSubreddits();

  Future<void> subscribeSubreddit(String name);

  Future<void> unsubscribeSubreddit(String name);
}
