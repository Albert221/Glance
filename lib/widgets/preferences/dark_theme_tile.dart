import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';

class DarkThemeTile extends StatelessWidget {
  const DarkThemeTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReddigramState, PreferenceViewModel>(
      converter: (store) => PreferenceViewModel<AppTheme>(
            value: store.state.preferences.theme,
            onSwitch: (dark) =>
                store.dispatch(setTheme(dark ? AppTheme.dark : AppTheme.light)),
          ),
      builder: (context, vm) => SwitchListTile(
            title: const Text('Dark theme'),
            secondary: const Icon(Icons.invert_colors),
            value: vm.value == AppTheme.dark,
            onChanged: vm.onSwitch,
          ),
    );
  }
}
