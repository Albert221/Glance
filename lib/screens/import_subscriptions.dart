import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/subreddit_circle_avatar.dart';

class ImportSubscriptionsScreen extends StatefulWidget {
  static PageRoute route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => ImportSubscriptionsScreen(),
    );
  }

  @override
  _ImportSubscriptionsScreenState createState() =>
      _ImportSubscriptionsScreenState();
}

class _ImportSubscriptionsScreenState extends State<ImportSubscriptionsScreen> {
  Map<String, bool> _subscriptions = {};
  bool _loading = true;
  bool _importing = false;

  @override
  void initState() {
    super.initState();

    redditRepository.subscribedSubreddits().then((subreddits) {
      final store = StoreProvider.of<ReddigramState>(context);

      store.dispatch(FetchedSubreddits(subreddits));
      setState(() {
        subreddits
            // Discard text subreddits
            .where((subreddit) => subreddit.submissionType != 'self')
            // Discard already subscribed subreddits
            .where((subreddit) =>
                !store.state.subscriptions.contains(subreddit.id))
            .forEach((subreddit) {
          _subscriptions[subreddit.id] = false;
        });
      });
    }).whenComplete(() => setState(() => _loading = false));
  }

  void _import() {
    setState(() => _importing = true);

    final store = StoreProvider.of<ReddigramState>(context);
    _subscriptions.forEach((subredditId, import) async {
      if (!import) return;

      store.dispatch(subscribeSubreddit(subredditId));
    });

    setState(() => _importing = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Import subscriptions'),
            Text(
              'Already subscribed are not shown.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Theme.of(context).textTheme.title.color.withOpacity(.7),
              ),
            ),
          ],
        ),
        actions: [
          if (_subscriptions.isNotEmpty)
            IconButton(
              icon: Icon(Icons.select_all),
              onPressed: () {
                setState(() {
                  // If everything is selected, deselect everything...
                  if (_subscriptions.entries.every((entry) => entry.value)) {
                    _subscriptions.updateAll((_, __) => false);
                  } else {
                    // ...select all otherwise.
                    _subscriptions.updateAll((_, __) => true);
                  }
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: !_loading
                ? _subscriptions.isNotEmpty
                    ? _buildList(context)
                    : const ListTile(title: Text('No items to show'))
                : const Center(child: CircularProgressIndicator()),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: _subscriptions.length,
      itemBuilder: (context, i) {
        final subredditId = _subscriptions.keys.toList()[i];

        return StoreConnector<ReddigramState, Subreddit>(
          converter: (store) => store.state.subreddits[subredditId],
          builder: (context, subreddit) => subreddit != null
              ? CheckboxListTile(
                  value: _subscriptions[subreddit.id] ?? false,
                  onChanged: (selected) {
                    setState(() => _subscriptions[subreddit.id] = selected);
                  },
                  secondary: SubredditCircleAvatar(subreddit: subreddit),
                  title: Text('r/${subreddit.name}'),
                )
              : const SizedBox(),
        );
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    final subredditsSelected =
        _subscriptions.entries.where((entry) => entry.value).length;
    final buttonColor = subredditsSelected > 0
        ? Theme.of(context).buttonTheme.colorScheme.onPrimary
        : Theme.of(context).buttonTheme.colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$subredditsSelected selected'),
          FlatButton(
            color: Theme.of(context).buttonTheme.colorScheme.primary,
            disabledColor: Theme.of(context).buttonTheme.colorScheme.surface,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: _importing ? 0 : 1,
                  child: Text(
                    'IMPORT SELECTED',
                    style: TextStyle(color: buttonColor),
                  ),
                ),
                if (_importing)
                  Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).buttonTheme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: subredditsSelected > 0 ? _import : null,
          ),
        ],
      ),
    );
  }
}
