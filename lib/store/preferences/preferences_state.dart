import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'preferences_state.g.dart';

abstract class PreferencesState
    implements Built<PreferencesState, PreferencesStateBuilder> {
  AppTheme get theme;

  bool get showNsfw;

  bool get cutLongPhotos;

  PreferencesState._();

  factory PreferencesState([updates(PreferencesStateBuilder b)]) {
    return _$PreferencesState._(
      theme: AppTheme.light,
      showNsfw: false,
      cutLongPhotos: false,
    ).rebuild(updates);
  }
}

class AppTheme extends EnumClass {
  static const AppTheme light = _$light;
  static const AppTheme dark = _$dark;

  const AppTheme._(String name) : super(name);

  static BuiltSet<AppTheme> get values => _$values;

  static AppTheme valueOf(String name) => _$valueOf(name);
}
