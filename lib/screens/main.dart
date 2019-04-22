import 'package:flutter/material.dart';
import 'package:reddigram/api/api.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();

    RedditRepository.subreddit('EarthPorn+CitiesSkylines+InfrastructurePorn')
        .then((response) => ListingPhotosMapper.map(response))
        .then((photos) => setState(() => this.photos = photos));
  }

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
            onPressed: () => Navigator.pushNamed(context, '/subscribed'),
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
