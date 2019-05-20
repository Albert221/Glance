import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> searchSubreddits(String query) {
  return (Store<ReddigramState> store) {
    redditRepository.searchSubreddits(query).then((feeds) {
      // Call fetched fresh feed on all subreddits that are not
      // already present in the app state.
      feeds
          .where((feed) => !store.state.feeds.containsKey('r/${feed.name}'))
          .forEach((feed) =>
              store.dispatch(FetchedFreshFeed('r/${feed.name}', feed)));

      store.dispatch(FetchedSearchSubreddits(
          query, feeds.map((feed) => 'r/${feed.name}').toList()));
    });
  };
}

class ClearSearch {}

class FetchedSearchSubreddits {
  final String query;
  final List<String> resultsFeedsNames;

  FetchedSearchSubreddits(this.query, this.resultsFeedsNames);
}
