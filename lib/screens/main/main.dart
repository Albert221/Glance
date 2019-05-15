import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';

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
      drawer: const MainDrawer(),
      body: StoreConnector<ReddigramState, void>(
        onInit: (store) => store.dispatch(fetchFreshFeed(BEST)),
        converter: (store) => null,
        builder: (context, _) => PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                const FeedTab(feedName: BEST),
                const FeedTab(feedName: NEW_SUBSCRIBED),
                const FeedTab(feedName: BEST_SUBSCRIBED),
                const SubbedTab(),
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
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.stars),
            title: Text('Best'),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('Your new'),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Your best'),
          ),
          const BottomNavigationBarItem(
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
