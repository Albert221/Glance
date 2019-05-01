import 'package:built_value/built_value.dart';

part 'preferences_state.g.dart';

abstract class PreferencesState
    implements Built<PreferencesState, PreferencesStateBuilder> {
  bool get showNsfw;

  PreferencesState._();

  factory PreferencesState([updates(PreferencesStateBuilder b)]) {
    return _$PreferencesState._(
      showNsfw: false,
    );
  }
}
