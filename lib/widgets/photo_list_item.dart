import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/widgets/widgets.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;
  final VoidCallback onUpvote;
  final VoidCallback onUpvoteCanceled;

  const PhotoListItem(
      {Key key, @required this.photo, this.onUpvote, this.onUpvoteCanceled})
      : assert(photo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 2.0,
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(context),
            _buildImage(context),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'u/${photo.authorName}',
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            'r/${photo.subreddit.name}',
            style: Theme.of(context).textTheme.title,
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pictureHeight = width / photo.aspectRatio;

    return Upvoteable(
      height: pictureHeight > width ? width : pictureHeight,
      onUpvote: photo.upvoted ? null : onUpvote,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: photo.photoUrl,
        fadeInDuration: Duration.zero,
        placeholder: (context, url) => _buildPlaceholder(context),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          imageUrl: photo.thumbnailUrl,
          fit: BoxFit.cover,
        ),
        const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: 56.0,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: photo.upvoted ? onUpvoteCanceled : onUpvote,
                  child: Icon(
                    Icons.arrow_upward,
                    color: photo.upvoted
                        ? Colors.red
                        : Theme.of(context).textTheme.body1.color,
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(photo.upvoted
                    ? 'You and ${photo.upvotes - 1} others upvoted this.'
                    : '${photo.upvotes} others upvoted this.'),
              ],
            ),
          ),
        ),
        InkWell(
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.exit_to_app),
          ),
          onTap: () async => await launch(photo.redditUrl),
        ),
      ],
    );
  }
}
