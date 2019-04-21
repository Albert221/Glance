import 'package:flutter/material.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  final photos = [
    Photo((b) => b
      ..authorName = 'u/crimsonpickles'
      ..subreddit = Subreddit((b) => b
        ..name = 'r/EarthPorn'
        ..redditUrl = ''
        ..subscribed = true).toBuilder()
      ..photoUrl =
          'https://external-preview.redd.it/At0HVigBKdesRSkjL-WMiSYPh9BL4O0X2uGMZXkzGd0.jpg?auto=webp&s=93ec02357b7d4f0bf15d730bb4a650b495d393be'
      ..upvoted = true
      ..upvotes = 489
      ..redditUrl =
          'https://www.reddit.com/r/EarthPorn/comments/bfn3qg/almost_100_million_years_old_and_still_standing/'),
    Photo((b) => b
      ..authorName = 'u/DanielGreenwood'
      ..subreddit = Subreddit((b) => b
        ..name = 'r/EarthPorn'
        ..redditUrl = ''
        ..subscribed = true).toBuilder()
      ..photoUrl = 'https://i.redd.it/0xcb7qimhlt21.jpg'
      ..upvoted = false
      ..upvotes = 855
      ..redditUrl =
          'https://www.reddit.com/r/EarthPorn/comments/bfnj52/utah_united_states_1360x2048_oc/'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reddigram',
          style: Theme.of(context).appBarTheme.textTheme.display1,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SubscribedScreen())),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: photos.length,
        itemBuilder: (context, i) => PhotoListItem(photo: photos[i]),
      ),
    );
  }
}
