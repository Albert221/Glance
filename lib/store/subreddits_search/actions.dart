import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> searchSubreddits(String query) {
  return (Store<ReddigramState> store) {
    redditRepository.searchSubreddits(query).then((subreddits) {
      // If there was no subreddit with this particular name...
      if (!subreddits.any(
          (subreddit) => subreddit.name.toLowerCase() == query.toLowerCase())) {
        // ...but this subreddit exists...
        redditRepository.subreddit(query).then((subreddit) {
          store.dispatch(FetchedSubreddits([subreddit]));
          // ...then prepend it to fetched search subreddits.
          store.dispatch(FetchedSearchSubreddits(
            query,
            [subreddit.id, ...subreddits.map((subreddit) => subreddit.id)],
          ));
        });
      }

      store.dispatch(FetchedSubreddits(subreddits));
      store.dispatch(FetchedSearchSubreddits(
          query, subreddits.map((subreddit) => subreddit.id).toList()));
    });
  };
}

class ClearSearch {}

class FetchedSearchSubreddits {
  final String query;
  final List<String> resultSubredditsIds;

  FetchedSearchSubreddits(this.query, this.resultSubredditsIds);
}
