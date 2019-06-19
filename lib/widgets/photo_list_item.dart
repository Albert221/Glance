import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/widgets/widgets.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;
  final Subreddit subreddit;
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
      this.subreddit,
      this.upvotingEnabled = true,
      this.onUpvote,
      this.onUpvoteCanceled,
      this.onPhotoTap,
      this.onSubredditTap,
      this.showNsfw = false,
      this.onShowNsfw})
      : assert(photo != null),
        super(key: key);

  static Widget placeholder({Key key}) => _Placeholder(key: key);

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

    final chipAvatar = subreddit?.primaryColor?.isNotEmpty == true ||
            subreddit?.iconUrl?.isNotEmpty == true
        ? CircleAvatar(
            backgroundColor: subreddit.primaryColorMapped,
            backgroundImage: subreddit.iconUrl != null
                ? CachedNetworkImageProvider(subreddit.iconUrl)
                : null,
          )
        : null;

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
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: onSubredditTap != null
              ? ActionChip(
                  pressElevation: 0,
                  avatar: chipAvatar,
                  label: Text(
                    'r/${photo.subredditName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: onSubredditTap,
                )
              : Chip(
                  avatar: chipAvatar,
                  label: Text(
                    'r/${photo.subredditName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mutedStyle.color,
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  static const double _maxPictureHeight = 600.0;

  static double calculateImageHeight(BuildContext context, Photo photo) {
    final pictureWidth = MediaQuery.of(context).size.width - 16;
    final pictureHeight = pictureWidth / photo.source.aspectRatio;

    return min(pictureHeight, _maxPictureHeight);
  }

  Widget _buildImage(BuildContext context) {
    final photoHeight = calculateImageHeight(context, photo);

    final image = CachedNetworkImage(
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
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
                  height: photoHeight, width: double.infinity),
              child: GestureDetector(
                onTap: onPhotoTap,
                child: upvotingEnabled
                    ? Upvoteable(
                        height: photoHeight,
                        onUpvote: photo.upvoted ? null : onUpvote,
                        child: image,
                      )
                    : image,
              ),
            ),
            if (photoHeight >= _maxPictureHeight)
              _buildTapToRevealOverlay(context),
            if (photo.nsfw)
              NsfwOverlay(
                height: photoHeight,
                show: showNsfw,
                onShow: onShowNsfw,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      height: double.infinity,
      imageUrl: photo.thumbnail.url,
      fit: BoxFit.cover,
    );
  }

  Widget _buildTapToRevealOverlay(BuildContext context) {
    final photoHeight = calculateImageHeight(context, photo);
    final overlayColor = Colors.white;
    final textColor = Colors.black;

    return IgnorePointer(
      ignoring: true,
      child: Container(
        height: photoHeight,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 50.0,
          padding: const EdgeInsets.only(top: 10.0),
          alignment: Alignment.center,
          child: Text(
            'Post is longer. Tap to reveal.',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                overlayColor.withOpacity(0),
                overlayColor.withOpacity(0.8),
                overlayColor
              ],
              stops: [0.0, 0.2, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
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

class _Placeholder extends StatefulWidget {
  const _Placeholder({Key key}) : super(key: key);

  @override
  _PlaceholderState createState() => _PlaceholderState();
}

class _PlaceholderState extends State<_Placeholder>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  double usernameWidth;
  double subredditWidth;

  @override
  void initState() {
    super.initState();

    final random = Random();
    usernameWidth = 60.0 + random.nextInt(60);
    subredditWidth = 60.0 + random.nextInt(60);

    _controller = AnimationController(vsync: this)
      ..addListener(() => setState(() {}));
    _animation = Tween<double>(begin: 1, end: 0.5).animate(CurvedAnimation(
      parent: _controller,
      curve: const Cubic(1, 0, .8, 1),
    ));

    _controller.repeat(
        period: const Duration(milliseconds: 1500), reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context)
        .textTheme
        .caption
        .color
        .withOpacity(0.4 * _animation.value);
    final mutedColor = color.withOpacity(0.2 * _animation.value);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                height: 14.0,
                width: usernameWidth,
                color: mutedColor,
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                height: 14.0,
                width: subredditWidth,
                color: color,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: mutedColor,
            ),
            height: 300.0,
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                width: 24.0,
                height: 24.0,
                color: color,
              ),
              const SizedBox(width: 12.0),
              Container(
                width: 200.0,
                height: 14.0,
                color: mutedColor,
              ),
              const Expanded(child: SizedBox()),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 16.0),
                width: 24.0,
                height: 24.0,
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
