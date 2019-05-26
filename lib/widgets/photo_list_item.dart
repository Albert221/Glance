import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/widgets/widgets.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;
  final bool upvotingEnabled;
  final VoidCallback onUpvote;
  final VoidCallback onUpvoteCanceled;

  final VoidCallback onPhotoTap;
  final VoidCallback onSubredditTap;

  final bool showNsfw;
  final VoidCallback onShowNsfw;

  const PhotoListItem(
      {Key key,
      @required this.photo,
      this.upvotingEnabled = true,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopBar(context),
          _buildImage(context),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    final mutedStyle = Theme.of(context).textTheme.caption.copyWith(
          color: Theme.of(context).textTheme.caption.color.withOpacity(0.67),
        );

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
              style: mutedStyle,
            ),
          ),
        ),
        InkWell(
          onTap: onSubredditTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'r/${photo.subredditName}',
              style: onSubredditTap != null
                  ? Theme.of(context).textTheme.caption
                  : mutedStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 16;
    final pictureHeight = width / photo.fullImage.aspectRatio;
    final height = pictureHeight > width ? width : pictureHeight;

    final image = CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: photo.fullImage.url,
      fadeInDuration: Duration.zero,
      placeholder: (context, url) => _buildPlaceholder(context),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  height: height, width: double.infinity),
              child: GestureDetector(
                onTap: onPhotoTap,
                child: upvotingEnabled
                    ? Upvoteable(
                        height: height,
                        onUpvote: photo.upvoted ? null : onUpvote,
                        child: image,
                      )
                    : image,
              ),
            ),
            if (photo.nsfw)
              NsfwOverlay(
                height: height,
                show: showNsfw,
                onShow: onShowNsfw,
              ),
          ],
        ),
      ),
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
            child: Row(
              children: [
                upvotingEnabled
                    ? InkWell(
                        onTap: photo.upvoted ? onUpvoteCanceled : onUpvote,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          child: Icon(
                            Icons.arrow_upward,
                            color: photo.upvoted
                                ? Colors.red
                                : Theme.of(context).textTheme.body1.color,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16.0),
                        child: Icon(
                          Icons.arrow_upward,
                          color: Theme.of(context)
                              .textTheme
                              .body1
                              .color
                              .withOpacity(0.67),
                        ),
                      ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Text(photo.upvoted
                      ? 'You and ${photo.upvotes - 1} others upvoted this.'
                      : '${photo.upvotes} others upvoted this.'),
                ),
                Tooltip(
                  message: 'Open in Reddit',
                  child: InkWell(
                    onTap: () async => await launch(photo.redditUrl),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 16.0),
                      child: Icon(Icons.launch),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
