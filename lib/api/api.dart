export 'reddit_repository.dart';

export 'subscriptions/subscription_repository.dart';
export 'subscriptions/api.dart';
export 'subscriptions/local.dart';
export 'subscriptions/facade.dart';

export 'response_models/link_listing_response.dart';
export 'response_models/subreddit_response.dart';
export 'response_models/serializers.dart';

export 'mappers/link_listing_photos_mapper.dart';
export 'mappers/subreddit_feed_mapper.dart';

import 'package:reddigram/api/api.dart';

final redditRepository = RedditRepository();
final subscriptionRepository = SubscriptionRepositoriesFacade(
  localRepository: SubscriptionsLocalRepository(),
  apiRepository: SubscriptionApiRepository(
      fetchRedditAccessToken: redditRepository.getAccessToken),
);
