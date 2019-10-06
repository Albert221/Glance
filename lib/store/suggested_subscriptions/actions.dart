import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchSuggestedSubscriptions([Completer completer]) {
  return (Store<ReddigramState> store) {
    apiRepository
        .suggestedSubreddits(store.state.subscriptions.toList())
        .then((suggestions) {
          store.dispatch(FetchedSuggestedSubscriptions(suggestions));
          store.dispatch(fetchSubreddits(suggestions));
        })
        .whenComplete(() => completer?.complete());
  };
}

class FetchedSuggestedSubscriptions {
  final List<String> suggestedSubscriptions;

  FetchedSuggestedSubscriptions(this.suggestedSubscriptions);
}
