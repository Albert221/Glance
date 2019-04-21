import 'package:flutter/material.dart';
import 'package:reddigram/widgets/widgets.dart';

class MainScreen extends StatelessWidget {
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
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemBuilder: (context, i) => i % 2 == 0
            ? const PhotoListItem(
                authorName: 'u/crimsonpickles',
                subredditName: 'r/EarthPorn',
                photoUrl:
                    'https://external-preview.redd.it/At0HVigBKdesRSkjL-WMiSYPh9BL4O0X2uGMZXkzGd0.jpg?auto=webp&s=93ec02357b7d4f0bf15d730bb4a650b495d393be',
                upvoted: true,
                upvotes: 489,
              )
            : const PhotoListItem(
                authorName: 'u/DanielGreenwood',
                subredditName: 'r/EarthPorn',
                photoUrl: 'https://i.redd.it/0xcb7qimhlt21.jpg',
                upvotes: 855,
              ),
      ),
    );
  }
}
