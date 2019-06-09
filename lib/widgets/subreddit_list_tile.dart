import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reddigram/models/models.dart';

class SubredditListTile extends StatelessWidget {
  final Subreddit subreddit;
  final VoidCallback onTap;
  final Widget trailingIcon;
  final VoidCallback onTrailingTap;

  const SubredditListTile(
      {Key key,
      @required this.subreddit,
      this.onTap,
      this.trailingIcon,
      this.onTrailingTap})
      : assert(subreddit != null),
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
      contentPadding: const EdgeInsets.only(left: 16.0),
      trailing: trailingIcon != null
          ? InkWell(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: trailingIcon,
              ),
              onTap: onTrailingTap,
            )
          : null,
      onTap: onTap,
    );
  }
}
