import 'package:reddigram/store/store.dart';

ReddigramState rootReducer(ReddigramState state, action) {
  return state.rebuild(
      (b) => b..feedState.replace(feedStateReducer(state.feedState, action)));
}
