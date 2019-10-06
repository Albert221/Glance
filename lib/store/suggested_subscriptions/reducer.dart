import 'package:built_collection/built_collection.dart';
import 'package:reddigram/store/store.dart';
import 'package:redux/redux.dart';

Reducer<BuiltSet<String>> suggestedSubscriptionsReducer = combineReducers([
  TypedReducer<BuiltSet<String>, FetchedSuggestedSubscriptions>(
      _fetchedSuggestedSubscriptions),
]);

BuiltSet<String> _fetchedSuggestedSubscriptions(
    BuiltSet<String> state, FetchedSuggestedSubscriptions action) {
  return BuiltSet<String>.from(action.suggestedSubscriptions);
}
