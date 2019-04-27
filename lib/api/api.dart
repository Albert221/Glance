export 'reddit_repository.dart';
export 'reddigram_repository.dart';

export 'response_models/listing_response.dart';
export 'response_models/serializers.dart';

export 'mappers/listing_photos_mapper.dart';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/api/reddigram_repository.dart';

final redditRepository = RedditRepository();
final reddigramRepository = ReddigramRepository();