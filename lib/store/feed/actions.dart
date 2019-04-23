import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

String _concatenateSubreddits(Iterable<String> subreddits) =>
    subreddits.join('+');

ThunkAction<ReddigramState> fetchFreshFeed([Completer completer]) {
  return (Store<ReddigramState> store) {
    store.dispatch(SetFeedFetching(true));

    apiRepository
        .subreddit(_concatenateSubreddits(store.state.subscriptions))
        .then(ListingPhotosMapper.map)
        .then((photos) => store.dispatch(FetchedFeed(photos)))
        .whenComplete(() {
      store.dispatch(SetFeedFetching(false));
      completer?.complete();
    });
  };
}

ThunkAction<ReddigramState> fetchMoreFeed() {
  return (Store<ReddigramState> store) {
    store.dispatch(SetFeedFetching(true));

    var after = '';
    if (store.state.feedState.photos.isNotEmpty) {
      after = store.state.feedState.photos.last.id;
    }

    apiRepository
        .subreddit(_concatenateSubreddits(store.state.subscriptions),
            after: after)
        .then(ListingPhotosMapper.map)
        .then((photos) => store.dispatch(FetchedMoreFeed(photos)))
        .whenComplete(() => store.dispatch(SetFeedFetching(false)));
  };
}

ThunkAction<ReddigramState> upvote(Photo photo) {
  return (Store<ReddigramState> store) {
    store.dispatch(PhotoUpvoted(photo.id));
    apiRepository.upvote(photo.id);
  };
}

ThunkAction<ReddigramState> cancelUpvote(Photo photo) {
  return (Store<ReddigramState> store) {
    store.dispatch(PhotoUpvoteCanceled(photo.id));
    apiRepository.cancelUpvote(photo.id);
  };
}

class SetFeedFetching {
  final bool fetching;

  SetFeedFetching(this.fetching);
}

class FetchedFeed {
  final List<Photo> photos;

  FetchedFeed(this.photos);
}

class FetchedMoreFeed {
  final List<Photo> photos;

  FetchedMoreFeed(this.photos);
}

class PhotoUpvoted {
  final String id;

  PhotoUpvoted(this.id);
}

class PhotoUpvoteCanceled {
  final String id;

  PhotoUpvoteCanceled(this.id);
}
