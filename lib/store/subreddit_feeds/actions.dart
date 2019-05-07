import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchFreshSubreddit(String name) {
  return (Store<ReddigramState> store) {
    redditRepository
        .subreddit(name, limit: 99)
        .then(ListingPhotosMapper.map)
        .then((photos) => store.dispatch(FetchedSubreddit(name, photos)));
  };
}

ThunkAction<ReddigramState> fetchMoreSubreddit(String name,
    [Completer completer]) {
  return (Store<ReddigramState> store) {
    final subreddit = store.state.subredditFeeds[name];

    var after = '';
    if (subreddit.isNotEmpty) {
      after = subreddit.last.id;
    }

    redditRepository
        .subreddit(name, after: after, limit: 27)
        .then(ListingPhotosMapper.map)
        .then((photos) => store.dispatch(FetchedMoreSubreddit(name, photos)))
        .whenComplete(() => completer?.complete());
  };
}

class FetchedSubreddit {
  final String name;
  final List<Photo> photos;

  FetchedSubreddit(this.name, this.photos);
}

class FetchedMoreSubreddit {
  final String name;
  final List<Photo> photos;

  FetchedMoreSubreddit(this.name, this.photos);
}
