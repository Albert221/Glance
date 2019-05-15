import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/widgets/widgets.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;
  final VoidCallback onUpvote;
  final VoidCallback onUpvoteCanceled;

  final VoidCallback onPhotoTap;
  final VoidCallback onSubredditTap;

  final bool showNsfw;
  final VoidCallback onShowNsfw;

  const PhotoListItem(
      {Key key,
      @required this.photo,
      this.onUpvote,
      this.onUpvoteCanceled,
      this.onPhotoTap,
      this.onSubredditTap,
      this.showNsfw = false,
      this.onShowNsfw})
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'u/${photo.authorName}',
              softWrap: false,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
        InkWell(
          onTap: onSubredditTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'r/${photo.subredditName}',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final pictureHeight = width / photo.fullImage.aspectRatio;
    final height = pictureHeight > width ? width : pictureHeight;

    return Stack(
      children: [
        GestureDetector(
          onTap: onPhotoTap,
          child: Upvoteable(
            height: height,
            onUpvote: photo.upvoted ? null : onUpvote,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: photo.fullImage.url,
              fadeInDuration: Duration.zero,
              placeholder: (context, url) => _buildPlaceholder(context),
            ),
          ),
        ),
        if (photo.nsfw)
          NsfwOverlay(
            height: height,
            show: showNsfw,
            onShow: onShowNsfw,
          ),
      ],
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          width: double.infinity,
          height: double.infinity,
          imageUrl: photo.thumbnail.url,
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
        Tooltip(
          child: InkWell(
            child: const Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Icon(Icons.launch),
            ),
            onTap: () async => await launch(photo.redditUrl),
          ),
          message: 'Open in Reddit',
        ),
      ],
    );
  }
}
