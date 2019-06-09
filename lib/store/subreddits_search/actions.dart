import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> searchSubreddits(String query) {
  return (Store<ReddigramState> store) {
    redditRepository.searchSubreddits(query).then((feeds) {
      store.dispatch(FetchedSubreddits(feeds));

      store.dispatch(FetchedSearchSubreddits(
          query, feeds.map((feed) => feed.name).toList()));
    });
  };
}

class ClearSearch {}

class FetchedSearchSubreddits {
  final String query;
  final List<String> resultsFeedsNames;

  FetchedSearchSubreddits(this.query, this.resultsFeedsNames);
}
