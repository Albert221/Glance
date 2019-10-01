import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_widgets/flutter_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

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

  static const double _maxPictureHeight = 600.0;

  static double calculateImageHeight(BuildContext context, Photo photo) {
    final pictureWidth = MediaQuery.of(context).size.width - 16;
    final pictureHeight = pictureWidth / photo.source.aspectRatio;

    return min(pictureHeight, PhotoListItem._maxPictureHeight);
  }

  @override
  Widget build(BuildContext context) {
    final photoHeight = calculateImageHeight(context, photo);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TopBar(
            authorName: photo.authorName,
            subredditName: photo.subredditName,
            subreddit: subreddit,
            onSubredditTap: onSubredditTap,
          ),
          _PhotoContainer(
            photo: photo,
            child: photo.isVideo ? _Video(photo: photo) : _Photo(photo: photo),
            overlays: <Widget>[
              if (!photo.isVideo)
                SizedBox.expand(
                  child: GestureDetector(
                    onTap: onPhotoTap,
                  ),
                ),
              if (upvotingEnabled)
                Upvoteable(onUpvote: photo.upvoted ? null : onUpvote),
              if (photoHeight >= _maxPictureHeight && !photo.isVideo)
                _TapToRevealOverlay(),
              if (photo.nsfw) NsfwOverlay(show: showNsfw, onShow: onShowNsfw),
            ],
          ),
          _BottomBar(
            upvotingEnabled: upvotingEnabled,
            upvoted: photo.upvoted,
            upvotes: photo.upvotes,
            onUpvote: onUpvote,
            onUpvoteCancelled: onUpvoteCanceled,
            onOpenExternalTap: () async => await launch(photo.redditUrl),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String authorName;
  final String subredditName;
  final Subreddit subreddit;
  final VoidCallback onSubredditTap;

  const _TopBar(
      {Key key,
      @required this.authorName,
      @required this.subredditName,
      this.subreddit,
      this.onSubredditTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'u/$authorName',
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
                    'r/$subredditName',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: onSubredditTap,
                )
              : Chip(
                  avatar: chipAvatar,
                  label: Text(
                    'r/$subredditName',
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
}

class _PhotoContainer extends StatelessWidget {
  final Photo photo;
  final Widget child;
  final List<Widget> overlays;

  const _PhotoContainer(
      {Key key, @required this.photo, this.overlays = const [], this.child})
      : super(key: key);

  static double calculateImageHeight(BuildContext context, Photo photo) {
    final pictureWidth = MediaQuery.of(context).size.width - 16;
    final pictureHeight = pictureWidth / photo.source.aspectRatio;

    return min(pictureHeight, PhotoListItem._maxPictureHeight);
  }

  @override
  Widget build(BuildContext context) {
    final photoHeight = calculateImageHeight(context, photo);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: photoHeight,
            width: double.infinity,
          ),
          child: Stack(
            children: [child, ...overlays],
          ),
        ),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  final Photo photo;

  const _Photo({Key key, @required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.topCenter,
      imageUrl: photo.fullImage.url,
      fadeInDuration: Duration.zero,
      placeholder: (context, url) => Stack(
        children: [
          _ThumbnailPlaceholder(photoUrl: photo.thumbnail.url),
          const _LoadingCircle(),
        ],
      ),
    );
  }
}

class _Video extends StatefulWidget {
  final Photo photo;

  const _Video({Key key, @required this.photo}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<_Video> {
  VideoPlayerController _videoController;

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(widget.photo.video.url)
      ..setLooping(true)
      ..addListener(() {
        final oldValue = _loading;

        _loading = _videoController.value.isPlaying &&
                !_videoController.value.initialized ||
            _videoController.value.isBuffering;

        if (oldValue != _loading) {
          setState(() {});
        }
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _play() {
    if (_videoController.value?.initialized == false) {
      _videoController.initialize().then((_) => setState(() {}));
    }

    _videoController.play().then((_) => setState(() {}));
  }

  void _pause() {
    _videoController.pause().then((_) => setState(() {}));
  }

  static const _pauseVisibilityFraction = 0.5;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (!_videoController.value.initialized) {
      icon = Icons.play_arrow;
    } else if (!_videoController.value.isPlaying) {
      icon = Icons.pause;
    }

    return GestureDetector(
      onTap: _videoController.value.isPlaying ? _pause : _play,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _videoController.value.initialized
              ? VisibilityDetector(
                  key: Key(widget.photo.id),
                  onVisibilityChanged: (visibility) {
                    if (visibility.visibleFraction < _pauseVisibilityFraction &&
                        _videoController.value.isPlaying) {
                      // When it's playing and not on the screen
                      _pause();
                    }
                  },
                  child: FittedBox(
                    child: SizedBox.fromSize(
                      size: _videoController.value.size,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                )
              : _ThumbnailPlaceholder(photoUrl: widget.photo.thumbnail.url),
          if (_loading) const _LoadingCircle(),
          if (icon != null)
            Center(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(icon, color: Colors.white, size: 64.0),
              ),
            ),
        ],
      ),
    );
  }
}

class _ThumbnailPlaceholder extends StatelessWidget {
  final String photoUrl;

  const _ThumbnailPlaceholder({Key key, @required this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      height: double.infinity,
      imageUrl: photoUrl,
      fit: BoxFit.cover,
    );
  }
}

class _LoadingCircle extends StatelessWidget {
  const _LoadingCircle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Transform.scale(
          scale: 0.5,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _TapToRevealOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final overlayColor = Colors.white;
    final textColor = Colors.black;

    return IgnorePointer(
      ignoring: true,
      child: Align(
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
}

class _BottomBar extends StatelessWidget {
  final bool upvotingEnabled;
  final bool upvoted;
  final int upvotes;
  final VoidCallback onUpvote;
  final VoidCallback onUpvoteCancelled;
  final VoidCallback onOpenExternalTap;

  const _BottomBar(
      {Key key,
      @required this.upvotingEnabled,
      @required this.upvoted,
      @required this.upvotes,
      this.onUpvote,
      this.onUpvoteCancelled,
      this.onOpenExternalTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        onTap: upvoted ? onUpvoteCancelled : onUpvote,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 16.0),
                          child: Icon(
                            Icons.arrow_upward,
                            color: upvoted
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
                  child: Text(upvoted
                      ? 'You and ${upvotes - 1} others upvoted this.'
                      : '$upvotes others upvoted this.'),
                ),
                Tooltip(
                  message: 'Open in Reddit',
                  child: InkWell(
                    onTap: onOpenExternalTap,
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
