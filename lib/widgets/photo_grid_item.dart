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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ink.image(
          image: CachedNetworkImageProvider(photo.thumbnail.url),
          fit: BoxFit.cover,
          child: InkWell(
            onTap: onTap,
          ),
        ),
        if (photo.nsfw)
          NsfwOverlay(
            height: double.infinity,
            show: showNsfw,
            onShow: onShowNsfw,
          ),
      ],
    );
  }
}
