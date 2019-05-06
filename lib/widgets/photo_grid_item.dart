import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reddigram/models/models.dart';

class PhotoGridItem extends StatelessWidget {
  final Photo photo;
  final VoidCallback onTap;

  const PhotoGridItem({Key key, @required this.photo, this.onTap})
      : assert(photo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'image-${photo.id}',
      child: Ink.image(
        image: CachedNetworkImageProvider(photo.thumbnail.url),
        fit: BoxFit.cover,
        child: InkWell(
          onTap: onTap,
        ),
      ),
    );
  }
}
