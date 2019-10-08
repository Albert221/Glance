import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/widgets/widgets.dart';

class PhotoGridItem extends StatelessWidget {
  final Photo photo;
  final VoidCallback onTap;

  final bool showNsfw;
  final VoidCallback onShowNsfw;

  const PhotoGridItem(
      {Key key,
      @required this.photo,
      this.onTap,
      this.showNsfw = false,
      this.onShowNsfw})
      : assert(photo != null),
        super(key: key);

  static Widget placeholder({Key key}) => _Placeholder(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            GestureDetector(
              onTap: onTap,
              child: CachedNetworkImage(
                imageUrl: photo.thumbnail.url,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                placeholder: (context, _) => _Placeholder(),
                fadeInDuration: Duration.zero,
              ),
            ),
            if (photo.nsfw) NsfwOverlay(show: showNsfw, onShow: onShowNsfw),
          ],
        ),
      ),
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
        .withOpacity(0.2 * _animation.value);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
    );
  }
}
