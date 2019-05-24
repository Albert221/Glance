import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reddigram/models/models.dart';

class PhotoPreviewScreen extends StatelessWidget {
  static const _methodChannel = const MethodChannel('me.wolszon.reddigram');

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

  void downloadPhoto(BuildContext context) async {
    // TODO: Use native code here and get rid of path_provider and permissions
    try {
      final result = await _methodChannel
          .invokeMethod('downloadPhoto', {'url': photo.source.url});

      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(result),
      ));
    } on PlatformException catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final minScale = MediaQuery.of(context).size.width / photo.source.width;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
                  icon: Icon(Icons.file_download),
                  tooltip: 'Download',
                  onPressed: () => downloadPhoto(context),
                ),
          ),
        ],
      ),
      body: PhotoView(
        transitionOnUserGestures: true,
        imageProvider: CachedNetworkImageProvider(photo.source.url),
        minScale: minScale,
        maxScale: 2.0,
      ),
    );
  }
}
