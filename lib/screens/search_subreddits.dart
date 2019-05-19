import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';

class SearchSubredditsDelegate extends SearchDelegate<String> {
  Timer _debounce;
  String _lastQuery = '';

  List<Feed> _results = [];
  String _resultsQuery = '';

  @override
  List<Widget> buildActions(BuildContext context) => null;

  @override
  Widget buildLeading(BuildContext context) => const BackButton();

  void stuff(BuildContext context) {
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _resultsQuery = query;
      redditRepository.searchSubreddits(query).then((feeds) {
        _results = feeds;

        // Invoking showResults just to rebuild the suggestion view afterwards.
        showResults(context);
        showSuggestions(context);
      });
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (_lastQuery != query) {
      stuff(context);
      _lastQuery = query;
    }

    final containsExact = _results
        .any((feed) => feed.name.toLowerCase() == _resultsQuery.toLowerCase());

    if (_results.isEmpty) {
      return ListView();
    }

    return ListView.builder(
      itemCount: containsExact ? _results.length : _results.length + 1,
      itemBuilder: (context, i) {
        if (!containsExact && i == 0) {
          return ListTile(
            leading: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(Icons.forward),
            ),
            title: Text('r/$_resultsQuery'),
            onTap: () => Navigator.push(
                  context,
                  SubredditScreen.route(
                    context,
                    _resultsQuery,
                  ),
                ),
          );
        }

        final result = containsExact ? _results[i] : _results[i - 1];

        return StoreConnector<ReddigramState, bool>(
          converter: (store) => store.state.subscriptions
              .any((sub) => sub.toLowerCase() == result.name.toLowerCase()),
          builder: (context, subscribed) => SubredditListTile(
                subreddit: result,
                onTap: () => Navigator.push(
                      context,
                      SubredditScreen.route(context, result.name),
                    ),
                trailingIcon: subscribed ? null : Icon(Icons.add),
                onTrailingTap: () => close(context, result.name),
              ),
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
