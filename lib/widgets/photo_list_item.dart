import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/widgets/widgets.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;

  const PhotoListItem({Key key, @required this.photo})
      : assert(photo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 2.0,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'u/${photo.authorName}',
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    'r/${photo.subreddit.name}',
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
            ),
            Upvoteable(
              child: CachedNetworkImage(
                alignment: Alignment.center,
                fit: BoxFit.cover,
                imageUrl: photo.photoUrl,
                placeholder: (context, _) => Container(
                      width: width,
                      height: width,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: photo.upvoted ? Colors.red : Colors.black,
                        ),
                        const SizedBox(width: 12.0),
                        Text(photo.upvoted
                            ? 'You and ${photo.upvotes - 1} others upvoted this.'
                            : '${photo.upvotes} others upvoted this.'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.exit_to_app),
                  ),
                  onTap: () async => await launch(photo.redditUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
