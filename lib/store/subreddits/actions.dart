import 'dart:async';

import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<ReddigramState> fetchSubredditInfo(List<String> subreddits,
    {Completer completer}) {
  return (Store<ReddigramState> store) {
    apiRepository
        .fetchSubredditInfos(subreddits)
        .then((infos) => infos.forEach((info) {
              // FIXME: Create new action for bulk stuff
              store.dispatch(FetchedSubredditInfo(info));
            }))
        .whenComplete(() => completer?.complete());
  };
}

class FetchedSubredditInfo {
  final SubredditInfo info;

  FetchedSubredditInfo(this.info);
}
