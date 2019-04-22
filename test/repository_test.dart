import 'package:flutter_test/flutter_test.dart';
import 'package:reddigram/api/api.dart';

void main() {
  test('Repository fetches and maps stuff', () async {
    final listing = await RedditRepository().subreddit('EarthPorn')
        .then((response) => ListingPhotosMapper.map(response));

    print(listing);
  });
}
