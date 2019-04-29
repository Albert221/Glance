import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'theme.g.dart';

class AppTheme extends EnumClass {
  static const AppTheme light = _$light;
  static const AppTheme dark = _$dark;

  const AppTheme._(String name) : super(name);

  static BuiltSet<AppTheme> get values => _$values;

  static AppTheme valueOf(String name) => _$valueOf(name);
}
