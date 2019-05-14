import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/models/models.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/widgets.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatefulWidget {
  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainScreen.scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: MainDrawer(),
      body: StoreConnector<ReddigramState, void>(
        onInit: (store) => store.dispatch(fetchFreshFeed(BEST)),
        converter: (store) => null,
        builder: (context, _) => PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                FeedTab(feedName: BEST),
                FeedTab(feedName: NEW_SUBSCRIBED),
                FeedTab(feedName: BEST_SUBSCRIBED),
                SubbedTab(),
              ],
            ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentTab,
        onTap: (index) {
          setState(() {
            _currentTab = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            title: Text('Best'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('Your new'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Your best'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('Subbed'),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Reddigram',
        style: Theme.of(context).appBarTheme.textTheme.display1,
      ),
      centerTitle: true,
    );
  }
}
