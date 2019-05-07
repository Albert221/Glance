import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class SubredditScreen extends StatefulWidget {
  final String subredditName;

  const SubredditScreen({Key key, this.subredditName}) : super(key: key);

  @override
  _SubredditScreenState createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<ReddigramState, _SubredditViewModel>(
      onInit: (store) {
        if (!store.state.subredditFeeds
            .any((subreddit) => subreddit.name == widget.subredditName)) {
          store.dispatch(fetchFreshSubreddit(widget.subredditName));
        }
      },
      converter: (store) =>
          _SubredditViewModel.fromStore(store, widget.subredditName),
      builder: (context, vm) => Scaffold(
            appBar: AppBar(
              title: Text('r/${widget.subredditName}'),
            ),
            body: vm.subreddit == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : InfiniteList(
                    fetchMore: vm.fetchMore,
                    itemCount: 3,
                    itemBuilder: (context, i) => [
                          _buildHeader(context, vm.subreddit),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: vm.subreddit.photos.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, i) => Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: PhotoGridItem(
                                      photo: vm.subreddit.photos[i],
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PhotoPreviewScreen(
                                                      photo: vm
                                                          .subreddit.photos[i]),
                                            ));
                                      },
                                    ),
                                  ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 32.0),
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(),
                          ),
                        ][i],
                  ),
          ),
    );
  }

  Widget _buildHeader(BuildContext context, Subreddit subreddit) {
    final primaryColor = Theme.of(context).buttonTheme.colorScheme.primary;
    final onPrimaryColor = Theme.of(context).buttonTheme.colorScheme.onPrimary;
    final backgroundColor =
        Theme.of(context).buttonTheme.colorScheme.background;
    final onBackgroundColor =
        Theme.of(context).buttonTheme.colorScheme.onBackground;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 24.0,
            backgroundImage: CachedNetworkImageProvider(subreddit.iconImageUrl),
          ),
          StoreConnector<ReddigramState, _SubscribeViewModel>(
            converter: (store) =>
                _SubscribeViewModel.fromStore(store, subreddit),
            builder: (context, vm) => vm.subscribed
                ? FlatButton(
                    onPressed: vm.unsubscribe,
                    child: Text(
                      'Unsubscribe'.toUpperCase(),
                      style: TextStyle(color: onBackgroundColor),
                    ),
                    color: backgroundColor,
                  )
                : FlatButton.icon(
                    onPressed: vm.subscribe,
                    icon: Icon(Icons.add, color: onPrimaryColor),
                    label: Text(
                      'Subscribe'.toUpperCase(),
                      style: TextStyle(color: onPrimaryColor),
                    ),
                    color: primaryColor,
                  ),
          ),
        ],
      ),
    );
  }
}

class _SubredditViewModel {
  final Subreddit subreddit;
  final void Function(Completer) fetchMore;

  _SubredditViewModel({@required this.subreddit, @required this.fetchMore})
      : assert(fetchMore != null);

  factory _SubredditViewModel.fromStore(
      Store<ReddigramState> store, String subredditName) {
    return _SubredditViewModel(
      subreddit: store.state.subredditFeeds.firstWhere(
        (subreddit) => subreddit.name == subredditName,
        orElse: () => null,
      ),
      fetchMore: (completer) =>
          store.dispatch(fetchMoreSubreddit(subredditName, completer)),
    );
  }
}

class _SubscribeViewModel {
  final bool subscribed;
  final VoidCallback subscribe;
  final VoidCallback unsubscribe;

  _SubscribeViewModel(
      {@required this.subscribed,
      @required this.subscribe,
      @required this.unsubscribe})
      : assert(subscribed != null),
        assert(subscribe != null),
        assert(unsubscribe != null);

  factory _SubscribeViewModel.fromStore(
      Store<ReddigramState> store, Subreddit subreddit) {
    return _SubscribeViewModel(
      subscribed: store.state.subscriptions.contains(subreddit.name),
      subscribe: () => store.dispatch(subscribeSubreddit(subreddit.name)),
      unsubscribe: () => store.dispatch(unsubscribeSubreddit(subreddit.name)),
    );
  }
}
