import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SubbedTab extends StatefulWidget {
  const SubbedTab({Key key}) : super(key: key);

  @override
  _SubbedTabState createState() => _SubbedTabState();
}

class _SubbedTabState extends State<SubbedTab>
    with AutomaticKeepAliveClientMixin {
  bool _searchFocused = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView(
      children: [
        _searchFocused
            ? _SearchView(
                onSearchDismiss: () => setState(() => _searchFocused = false),
              )
            : _SubscriptionsView(
                onSearchTap: () => setState(() => _searchFocused = true),
              ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SubscriptionsView extends StatelessWidget {
  final VoidCallback onSearchTap;

  const _SubscriptionsView({Key key, this.onSearchTap}) : super(key: key);

  void _unsubscribe(
      BuildContext context, String subreddit, VoidCallback callback) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Unsubscribing'),
          content: Text('Do you really want to unsubscribe from r/$subreddit?'),
          actions: [
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: const Text('UNSUBSCRIBE'),
              onPressed: () {
                Navigator.of(context).pop();
                callback();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final divider = const SizedBox(height: 32.0);

    return StoreConnector<ReddigramState, _SubredditsViewModel>(
      converter: (store) => _SubredditsViewModel.fromStore(store),
      builder: (context, vm) => Column(
        children: [
          ListTile(
            onTap: onSearchTap,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.body1.color,
              ),
            ),
            title: Text(
              'Search subreddits',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          divider,
          ListTile(
            title: const Text(
              'Subscriptions',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          if (vm.subreddits.isEmpty)
            const ListTile(
              leading: SizedBox(),
              title: Text(
                'No subreddits. Subscribe to some!',
              ),
            ),
          ...vm.subreddits
              .map((subredditId) => StoreConnector<ReddigramState, Subreddit>(
                    key: Key(subredditId),
                    converter: (store) => store.state.subreddits[subredditId],
                    builder: (context, subreddit) => subreddit != null
                        ? SubredditListTile(
                            subreddit: subreddit,
                            subscribed: true,
                            onTap: () => Navigator.push(
                                context, SubredditScreen.route(subreddit.id)),
                            onUnsubscribe: () => _unsubscribe(
                              context,
                              subreddit.name,
                              () => vm.unsubscribe(subreddit.id),
                            ),
                          )
                        : SizedBox(),
                  ))
              .toList(),
          divider,
          _buildSuggestions(context),
        ],
      ),
    );
  }

  Widget _buildSuggestions(BuildContext context) {
    return StoreConnector<ReddigramState, _SubredditsViewModel>(
      converter: (store) => _SubredditsViewModel.fromStoreSuggested(store),
      builder: (context, vm) {
        return Column(
          children: [
            const ListTile(
              title: Text(
                'You may also like',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (vm.subreddits.isEmpty)
              const ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.sentiment_dissatisfied),
                ),
                title: Text('No suggestions available'),
              ),
            ...vm.subreddits
                .map((subredditId) => StoreConnector<ReddigramState, Subreddit>(
                      key: Key('suggestion_$subredditId'),
                      converter: (store) => store.state.subreddits[subredditId],
                      builder: (context, subreddit) => subreddit != null
                          ? SubredditListTile(
                              subreddit: subreddit,
                              subscribed: false,
                              onTap: () => Navigator.push(
                                context,
                                SubredditScreen.route(subreddit.id),
                              ),
                              onSubscribe: () => vm.subscribe(subredditId),
                            )
                          : const SizedBox(),
                    ))
                .toList(),
          ],
        );
      },
    );
  }
}

class _SubredditsViewModel {
  final List<String> subreddits;
  final void Function(String) subscribe;
  final void Function(String) unsubscribe;

  _SubredditsViewModel(
      {@required this.subreddits,
      @required this.subscribe,
      @required this.unsubscribe})
      : assert(subreddits != null),
        assert(subscribe != null),
        assert(unsubscribe != null);

  factory _SubredditsViewModel.fromStore(Store<ReddigramState> store) {
    return _SubredditsViewModel(
      subreddits: store.state.subscriptions.toList(),
      subscribe: (subredditId) =>
          store.dispatch(subscribeSubreddit(subredditId)),
      unsubscribe: (subredditId) =>
          store.dispatch(unsubscribeSubreddit(subredditId)),
    );
  }

  factory _SubredditsViewModel.fromStoreSuggested(Store<ReddigramState> store) {
    return _SubredditsViewModel(
      subreddits: store.state.suggestedSubscriptions
          .where(
              (suggestion) => !store.state.subscriptions.contains(suggestion))
          .toList(),
      subscribe: (subredditId) =>
          store.dispatch(subscribeSubreddit(subredditId)),
      unsubscribe: (subredditId) =>
          store.dispatch(unsubscribeSubreddit(subredditId)),
    );
  }
}

class _SearchView extends StatefulWidget {
  final VoidCallback onSearchDismiss;

  const _SearchView({Key key, this.onSearchDismiss}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  final _searchFocusNode = FocusNode();
  final _searchController = TextEditingController();

  static const _debounceDuration = const Duration(milliseconds: 500);

  Timer _debounce;
  bool _loading = false;
  String _lastQuery = '';

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _searchQueryChanged(String query, Store<ReddigramState> store) {
    if (_debounce?.isActive ?? false) {
      _debounce.cancel();
    }

    _debounce = Timer(_debounceDuration, () {
      if (_lastQuery != query) {
        setState(() => _loading = true);

        final completer = Completer()
          ..future.then((_) => setState(() => _loading = false));
        store.dispatch(searchSubreddits(query, completer: completer));
        _lastQuery = query;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          focusNode: _searchFocusNode,
          controller: _searchController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search subreddits',
            hintStyle: TextStyle(fontWeight: FontWeight.bold),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 1),
              child: Icon(
                Icons.search,
                color: Theme.of(context).textTheme.body1.color,
              ),
            ),
            suffixIcon: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onSearchDismiss,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.close),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
        if (_loading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: CircularProgressIndicator(),
          ),
        StoreConnector<ReddigramState, _SearchViewModel>(
          onInit: (store) {
            store.dispatch(ClearSearch());

            _searchController.addListener(
                () => _searchQueryChanged(_searchController.text, store));
          },
          converter: (store) => _SearchViewModel.fromStore(store),
          builder: (context, vm) => _loading
              ? SizedBox()
              : Column(
                  children: vm.subreddits
                      .map((subreddit) => StoreConnector<ReddigramState, bool>(
                            converter: (store) => store.state.subscriptions.any(
                                (subscription) => subscription == subreddit.id),
                            builder: (context, subscribed) => SubredditListTile(
                              subreddit: subreddit,
                              subscribed: subscribed,
                              onTap: () => Navigator.push(
                                context,
                                SubredditScreen.route(subreddit.id),
                              ),
                              onSubscribe: () => vm.subscribe(subreddit.id),
                              onUnsubscribe: () => vm.unsubscribe(subreddit.id),
                            ),
                          ))
                      .toList(),
                ),
        ),
      ],
    );
  }
}

class _SearchViewModel {
  final SubredditsSearchState state;
  final List<Subreddit> subreddits;
  final Function(String) subscribe;
  final Function(String) unsubscribe;

  _SearchViewModel(
      {@required this.state,
      @required this.subreddits,
      @required this.subscribe,
      @required this.unsubscribe})
      : assert(state != null),
        assert(subreddits != null),
        assert(subscribe != null),
        assert(unsubscribe != null);

  factory _SearchViewModel.fromStore(Store<ReddigramState> store) {
    return _SearchViewModel(
      state: store.state.subredditsSearch,
      subreddits: store.state.subredditsSearch.resultFeedsIds
          .map((subredditId) => store.state.subreddits[subredditId])
          .toList(),
      subscribe: (id) => store.dispatch(subscribeSubreddit(id)),
      unsubscribe: (id) => store.dispatch(unsubscribeSubreddit(id)),
    );
  }
}
