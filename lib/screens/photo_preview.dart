import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reddigram/models/models.dart';

class PhotoPreviewScreen extends StatelessWidget {
  static PageRoute route(BuildContext context, Photo photo) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: 'PhotoPreviewScreen'),
      builder: (context) => PhotoPreviewScreen(photo: photo),
    );
  }

  final Photo photo;

  const PhotoPreviewScreen({Key key, @required this.photo})
      : assert(photo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final minScale = MediaQuery.of(context).size.width / photo.source.width;

    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(
        transitionOnUserGestures: true,
        imageProvider: CachedNetworkImageProvider(photo.source.url),
        minScale: minScale,
        maxScale: 2.0,
      ),
    );
  }
}
