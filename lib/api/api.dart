export 'reddit_repository.dart';
export 'reddigram_repository.dart';

export 'response_models/link_listing_response.dart';
export 'response_models/subreddit_response.dart';
export 'response_models/serializers.dart';

export 'mappers/link_listing_photos_mapper.dart';
export 'mappers/subreddit_feed_mapper.dart';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/api/reddigram_repository.dart';

final redditRepository = RedditRepository();
final reddigramRepository = ReddigramRepository();