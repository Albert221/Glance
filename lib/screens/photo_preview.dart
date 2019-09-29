import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reddigram/models/models.dart';

class PhotoPreviewScreen extends StatelessWidget {
  static const _methodChannel = const MethodChannel('me.wolszon.reddigram');

  static PageRoute route(Photo photo) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: 'PhotoPreviewScreen'),
      builder: (context) => PhotoPreviewScreen(photo: photo),
    );
  }

  final Photo photo;

  const PhotoPreviewScreen({Key key, @required this.photo})
      : assert(photo != null),
        super(key: key);

  void _downloadPhoto() {
    _methodChannel.invokeMethod('downloadPhoto', {'url': photo.source.url});
  }

  @override
  Widget build(BuildContext context) {
    final minScale = MediaQuery.of(context).size.width / photo.source.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color.withOpacity(0.37),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            tooltip: 'Download',
            onPressed: _downloadPhoto,
          ),
        ],
      ),
      body: PhotoView(
        transitionOnUserGestures: true,
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        imageProvider: CachedNetworkImageProvider(photo.source.url),
        minScale: minScale,
        maxScale: 2.0,
      ),
    );
  }
}
