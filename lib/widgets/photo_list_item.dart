import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reddigram/widgets/widgets.dart';

class PhotoListItem extends StatelessWidget {
  final String authorName;
  final String subredditName;
  final String photoUrl;
  final String description;
  final bool upvoted;
  final int upvotes;

  const PhotoListItem(
      {Key key,
      this.authorName = '',
      this.subredditName = '',
      this.photoUrl = '',
      this.description = '',
      this.upvoted = false,
      this.upvotes = 0})
      : super(key: key);

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
                    authorName,
                    style: Theme.of(context).textTheme.title,
                  ),
                  Text(
                    subredditName,
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
            ),
            Upvoteable(
              child: CachedNetworkImage(
                alignment: Alignment.center,
                fit: BoxFit.cover,
                imageUrl: photoUrl,
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
                          color: upvoted ? Colors.red : Colors.black,
                        ),
                        const SizedBox(width: 12.0),
                        Text(upvoted
                            ? 'You and ${upvotes - 1} others upvoted this.'
                            : '$upvotes others upvoted this.'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(Icons.exit_to_app),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
