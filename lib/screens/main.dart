import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reddigram',
          style: Theme.of(context).appBarTheme.textTheme.display1,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.pushNamed(context, '/subscribed'),
          ),
        ],
      ),
      body: StoreConnector<ReddigramState, _ViewModel>(
        onInit: (store) => store.dispatch(fetchMoreFeed()),
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) => ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: vm.feedState.photos.length + 1,
              itemBuilder: (context, i) {
                // Is last?
                if (i == vm.feedState.photos.length) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                }

                return PhotoListItem(photo: vm.feedState.photos[i]);
              },
            ),
      ),
    );
  }
}

class _ViewModel {
  final FeedState feedState;
  final VoidCallback fetchMore;

  _ViewModel({@required this.feedState, @required this.fetchMore})
      : assert(feedState != null),
        assert(fetchMore != null);

  factory _ViewModel.fromStore(Store<ReddigramState> store) {
    return _ViewModel(
      feedState: store.state.feedState,
      fetchMore: () => store.dispatch(fetchMoreFeed()),
    );
  }
}
