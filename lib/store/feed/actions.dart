import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

String _concatenateSubreddits(Iterable<String> subreddits) =>
    subreddits.join('+');

Future<List<Photo>> _fetchProperFeed(Store<ReddigramState> store,
    {String after = ''}) {
  if (store.state.authState.authenticated) {
    final concatenatedSubreddits =
        _concatenateSubreddits(store.state.subscriptions);
    if (concatenatedSubreddits.isEmpty) {
      return Future.value([]);
    }

    return redditRepository
        .subreddit(concatenatedSubreddits, after: after)
        .then(ListingPhotosMapper.map);
  }

  return redditRepository.best(after: after).then(ListingPhotosMapper.map);
}

ThunkAction<ReddigramState> fetchFreshFeed([Completer completer]) {
  return (Store<ReddigramState> store) {
    store.dispatch(SetFeedFetching(true));

    _fetchProperFeed(store)
        .then((photos) => store.dispatch(FetchedFeed(photos)))
        .whenComplete(() {
      store.dispatch(SetFeedFetching(false));
      completer?.complete();
    });
  };
}

ThunkAction<ReddigramState> fetchMoreFeed([Completer completer]) {
  return (Store<ReddigramState> store) {
    store.dispatch(SetFeedFetching(true));

    var after = '';
    if (store.state.feedState.photos.isNotEmpty) {
      after = store.state.feedState.photos.last.id;
    }

    _fetchProperFeed(store, after: after)
        .then((photos) => store.dispatch(FetchedMoreFeed(photos)))
        .whenComplete(() {
          store.dispatch(SetFeedFetching(false));
          completer?.complete();
        });
  };
}

ThunkAction<ReddigramState> upvote(Photo photo) {
  return (Store<ReddigramState> store) {
    redditRepository
        .upvote(photo.id)
        .then((_) => store.dispatch(PhotoUpvoted(photo.id)));
  };
}

ThunkAction<ReddigramState> cancelUpvote(Photo photo) {
  return (Store<ReddigramState> store) {
    redditRepository
        .cancelUpvote(photo.id)
        .then((_) => store.dispatch(PhotoUpvoteCanceled(photo.id)));
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
