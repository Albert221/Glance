import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reddigram/models/models.dart';

class PhotoPreviewScreen extends StatelessWidget {
  final Photo photo;

  const PhotoPreviewScreen({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minScale = MediaQuery.of(context).size.width / photo.fullImage.width;

    return Scaffold(
      body: PhotoView(
        heroTag: 'photo-${photo.id}',
        transitionOnUserGestures: true,
        imageProvider: CachedNetworkImageProvider(photo.fullImage.url),
        minScale: minScale,
        maxScale: 2.0,
      ),
    );
  }
}
