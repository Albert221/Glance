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

  static double calculateImageHeight(BuildContext context, Photo photo) {
    final pictureWidth = MediaQuery.of(context).size.width - 16;
    final pictureHeight = pictureWidth / photo.source.aspectRatio;

    final maxPictureHeight = PreferencesProvider.of(context).cutLongPhotos
        ? pictureWidth * 1.4
        : pictureHeight;

    return pictureHeight > maxPictureHeight ? maxPictureHeight : pictureHeight;
  }

  Widget _buildImage(BuildContext context) {
    final height = calculateImageHeight(context, photo);

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

class _Placeholder extends StatefulWidget {
  const _Placeholder({Key key}) : super(key: key);

  @override
  _PlaceholderState createState() => _PlaceholderState();
}

class _PlaceholderState extends State<_Placeholder>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this)
      ..addListener(() => setState(() {}));
    _animation = Tween<double>(begin: 1, end: 0.4).animate(CurvedAnimation(
      parent: _controller,
      curve: const Cubic(1, 0, .8, 1),
    ));

    _controller.repeat(
        period: const Duration(milliseconds: 2000), reverse: true);
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
        .withOpacity(0.5 * _animation.value);
    final mutedColor = color.withOpacity(0.3 * _animation.value);

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
                width: 100.0,
                color: mutedColor,
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                height: 14.0,
                width: 70.0,
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
