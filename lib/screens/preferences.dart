import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/store/store.dart';

class PreferencesScreen extends StatelessWidget {
  static PageRoute route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: 'PreferencesScreen'),
      builder: (context) => PreferencesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Column(
        children: [
          StoreConnector<ReddigramState, _PreferenceViewModel>(
            converter: (store) => _PreferenceViewModel<AppTheme>(
                  value: store.state.preferences.theme,
                  onSwitch: (dark) => store.dispatch(
                      setTheme(dark ? AppTheme.dark : AppTheme.light)),
                ),
            builder: (context, vm) => SwitchListTile(
                  title: const Text('Dark theme'),
                  secondary: const Icon(Icons.invert_colors),
                  value: vm.value == AppTheme.dark,
                  onChanged: vm.onSwitch,
                ),
          ),
          StoreConnector<ReddigramState, _PreferenceViewModel>(
            converter: (store) => _PreferenceViewModel<bool>(
                  value: store.state.preferences.showNsfw,
                  onSwitch: (showNsfw) => store.dispatch(setShowNsfw(showNsfw)),
                ),
            builder: (context, vm) => SwitchListTile(
                  title: const Text('Show adult content'),
                  secondary: const Icon(Icons.block),
                  value: vm.value,
                  onChanged: vm.onSwitch,
                ),
          ),
          StoreConnector<ReddigramState, _PreferenceViewModel>(
            converter: (store) => _PreferenceViewModel<bool>(
                  value: store.state.preferences.cutLongPhotos,
                  onSwitch: (cutLongPhotos) =>
                      store.dispatch(setCutLongPhotos(cutLongPhotos)),
                ),
            builder: (context, vm) => SwitchListTile(
                  title: const Text('Cut long photos'),
                  secondary: const Icon(Icons.content_cut),
                  value: vm.value,
                  onChanged: vm.onSwitch,
                ),
          ),
        ],
      ),
    );
  }
}

class _PreferenceViewModel<T> {
  final T value;
  final void Function(bool) onSwitch;

  _PreferenceViewModel({@required this.value, @required this.onSwitch})
      : assert(value != null),
        assert(onSwitch != null);
}
