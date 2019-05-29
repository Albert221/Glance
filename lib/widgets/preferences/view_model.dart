import 'package:meta/meta.dart';

class PreferenceViewModel<T> {
  final T value;
  final void Function(bool) onSwitch;

  PreferenceViewModel({@required this.value, @required this.onSwitch})
      : assert(value != null),
        assert(onSwitch != null);
}
