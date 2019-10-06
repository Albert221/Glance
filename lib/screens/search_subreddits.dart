import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SearchSubredditsDelegate extends SearchDelegate<String> {
  Timer _debounce;
  String _lastQuery = '';

  @override
  List<Widget> buildActions(BuildContext context) => null;

  @override
  Widget buildLeading(BuildContext context) => const BackButton();

  void search(BuildContext context) {
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      StoreProvider.of<ReddigramState>(context)
          .dispatch(searchSubreddits(query));
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (_lastQuery != query) {
      search(context);
      _lastQuery = query;
    }

    return StoreConnector<ReddigramState, _SearchViewModel>(
      converter: (store) => _SearchViewModel.fromStore(store),
      builder: (context, vm) {
        if (vm.subreddits.isEmpty) {
          return ListView();
        }

        return ListView.builder(
          itemCount: vm.subreddits.length,
          itemBuilder: (context, i) {
            final result = vm.subreddits[i];

            return StoreConnector<ReddigramState, bool>(
              converter: (store) => store.state.subscriptions
                  .any((subscription) => subscription == result.id),
              builder: (context, subscribed) => SubredditListTile(
                subreddit: result,
                onTap: () => Navigator.push(
                  context,
                  SubredditScreen.route(result.id),
                ),
                trailingIcon: subscribed ? null : Icon(Icons.add),
                onTrailingTap: () => close(context, result.id),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => buildSuggestions(context);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final superTheme = super.appBarTheme(context);

    return superTheme.copyWith(
      textTheme: superTheme.textTheme.copyWith(
        title: superTheme.textTheme.title.copyWith(
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _SearchViewModel {
  final SubredditsSearchState state;
  final List<Subreddit> subreddits;

  _SearchViewModel({@required this.state, @required this.subreddits})
      : assert(state != null),
        assert(subreddits != null);

  factory _SearchViewModel.fromStore(Store<ReddigramState> store) {
    return _SearchViewModel(
      state: store.state.subredditsSearch,
      subreddits: store.state.subredditsSearch.resultFeedsIds
          .map((subredditId) => store.state.subreddits[subredditId])
          .toList(),
    );
  }
}
