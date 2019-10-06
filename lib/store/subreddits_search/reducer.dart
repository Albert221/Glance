import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<SubredditsSearchState> subredditsSearchReducer = combineReducers([
  TypedReducer<SubredditsSearchState, FetchedSearchSubreddits>(
      _setSubredditsSearchResult),
  TypedReducer<SubredditsSearchState, ClearSearch>(_clearSearch),
]);

SubredditsSearchState _setSubredditsSearchResult(
    SubredditsSearchState state, FetchedSearchSubreddits action) {
  return state.rebuild((b) => b
    ..lastQuery = action.query
    ..resultFeedsIds.replace(action.resultSubredditsIds));
}

SubredditsSearchState _clearSearch(
    SubredditsSearchState state, ClearSearch action) {
  return SubredditsSearchState();
}
