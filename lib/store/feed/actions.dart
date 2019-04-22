import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchMoreFeed() {
  return (Store<ReddigramState> store) {
    store.dispatch(SetFeedFetching(true));

    var after = '';
    if (store.state.feedState.photos.isNotEmpty) {
      after = store.state.feedState.photos.last.id;
    }

    RedditRepository.subreddit(
        'EarthPorn+CitiesSkylines+InfrastructurePorn', after: after)
        .then(ListingPhotosMapper.map)
        .then((photos) {
      store.dispatch(AddMoreFeed(photos));
      store.dispatch(SetFeedFetching(false));
    });
  };
}

class SetFeedFetching {
  final bool fetching;

  SetFeedFetching(this.fetching);
}

class AddMoreFeed {
  final List<Photo> photos;

  AddMoreFeed(this.photos);
}
