import 'package:flutter_test/flutter_test.dart';
import 'package:reddigram/api/api.dart';

void main() {
  test('Repository fetches and maps stuff', () async {
    final listing = await RedditRepository().feed('r/EarthPorn')
        .then((response) => LinkListingPhotosMapper.map(response));

    print(listing);
  });
}
