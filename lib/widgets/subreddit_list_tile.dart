import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reddigram/models/models.dart';

class SubredditListTile extends StatelessWidget {
  final Subreddit subreddit;
  final VoidCallback onTap;
  final bool subscribed;
  final VoidCallback onSubscribe;
  final VoidCallback onUnsubscribe;

  const SubredditListTile({
    Key key,
    @required this.subreddit,
    @required this.subscribed,
    this.onTap,
    this.onSubscribe,
    this.onUnsubscribe,
  })  : assert(subreddit != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: subreddit.primaryColorMapped ?? Colors.transparent,
        backgroundImage: subreddit.iconUrl.isNotEmpty
            ? CachedNetworkImageProvider(subreddit.iconUrl)
            : null,
      ),
      title: Text('r/${subreddit.name}'),
      contentPadding: const EdgeInsets.only(left: 16),
      onTap: onTap,
      trailing: subscribed
          ? InkWell(
              onTap: onUnsubscribe,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(Icons.remove),
              ),
            )
          : InkWell(
              onTap: onSubscribe,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(Icons.add),
              ),
            ),
    );
  }
}
