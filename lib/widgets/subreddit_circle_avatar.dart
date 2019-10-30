import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reddigram/models/models.dart';

class SubredditCircleAvatar extends StatelessWidget {
  final Subreddit subreddit;

  const SubredditCircleAvatar({Key key, @required this.subreddit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: subreddit.primaryColorMapped ?? Colors.transparent,
      backgroundImage: subreddit.iconUrl.isNotEmpty
          ? CachedNetworkImageProvider(subreddit.iconUrl)
          : null,
    );
  }
}
