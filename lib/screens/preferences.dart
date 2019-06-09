import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';

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
          const DarkThemePreferenceTile(),
          const ShowNsfwPreferenceTile(),
          StoreConnector<ReddigramState, PreferenceViewModel>(
            converter: (store) => PreferenceViewModel<bool>(
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
