import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchSubscribedSubreddits() {
  return (Store<ReddigramState> store) {
    // todo(Albert221): fetch subreddits from database

    store.dispatch(FetchedSubscribedSubreddits(
        ['EarthPorn', 'InfrastructurePorn', 'photography', 'Minecraft']));
  };
}

ThunkAction<ReddigramState> subscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
    store.dispatch(SubscribedSubreddit(name));
    store.dispatch(fetchFreshFeed());

    // todo(Albert221): save to database
  };
}

ThunkAction<ReddigramState> unsubscribeSubreddit(String name) {
  return (Store<ReddigramState> store) {
    store.dispatch(UnsubscribedSubreddit(name));
    store.dispatch(fetchFreshFeed());

    // todo(Albert221): save to database
  };
}

class FetchedSubscribedSubreddits {
  final List<String> subreddits;

  FetchedSubscribedSubreddits(this.subreddits);
}

class SubscribedSubreddit {
  final String name;

  SubscribedSubreddit(this.name);
}

class UnsubscribedSubreddit {
  final String name;

  UnsubscribedSubreddit(this.name);
}
