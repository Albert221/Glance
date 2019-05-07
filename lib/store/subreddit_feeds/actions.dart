import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchFreshSubreddit(String name) {
  return (Store<ReddigramState> store) {
    // FIXME(Albert221): Use API to fetch subreddit data: /r/{name}/about
    final subreddit = Future.delayed(
        Duration(seconds: 2),
        () => Future.value(Subreddit((b) => b
          ..name = name
          ..redditUrl = 'r/$name'
          ..iconImageUrl =
              'https://a.thumbs.redditmedia.com/4Au-rWJ7rUqSTMN09zEXEdpicCS4lnNynf-NXrTxm88.png')));
    final photos = redditRepository
        .subreddit(name, limit: 99)
        .then(ListingPhotosMapper.map);

    Future.wait([subreddit, photos]).then((results) {
      Subreddit subreddit = results[0] as Subreddit;
      final photos = results[1] as List<Photo>;

      subreddit = subreddit.rebuild((b) => b..photos.replace(photos));
      store.dispatch(FetchedSubreddit(subreddit));
    });
  };
}

ThunkAction<ReddigramState> fetchMoreSubreddit(String name,
    [Completer completer]) {
  return (Store<ReddigramState> store) {
    final subreddit = store.state.subredditFeeds
        .firstWhere((subreddit) => subreddit.name == name);

    var after = '';
    if (subreddit.photos.isNotEmpty) {
      after = subreddit.photos.last.id;
    }

    redditRepository
        .subreddit(name, after: after, limit: 27)
        .then(ListingPhotosMapper.map)
        .then((photos) => store.dispatch(FetchedMoreSubreddit(name, photos)))
        .whenComplete(() => completer?.complete());
  };
}

class FetchedSubreddit {
  final Subreddit subreddit;

  FetchedSubreddit(this.subreddit);
}

class FetchedMoreSubreddit {
  final String subredditName;
  final List<Photo> photos;

  FetchedMoreSubreddit(this.subredditName, this.photos);
}
