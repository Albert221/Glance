import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';

class ShowNsfwTile extends StatelessWidget {
  const ShowNsfwTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReddigramState, PreferenceViewModel>(
      converter: (store) => PreferenceViewModel<bool>(
            value: store.state.preferences.showNsfw,
            onSwitch: (showNsfw) => store.dispatch(setShowNsfw(showNsfw)),
          ),
      builder: (context, vm) => SwitchListTile(
            title: const Text('Show adult content'),
            secondary: const Icon(Icons.block),
            value: vm.value,
            onChanged: vm.onSwitch,
          ),
    );
  }
}
