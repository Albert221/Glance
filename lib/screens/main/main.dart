import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:reddigram/screens/screens.dart';
import 'package:reddigram/store/store.dart';
import 'package:reddigram/widgets/reddigram_logo.dart';
import 'package:reddigram/widgets/widgets.dart';

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
      body: StoreConnector<ReddigramState, void>(
        onInit: (store) => store.dispatch(fetchFreshFeed(POPULAR)),
        converter: (store) => null,
        builder: (context, _) => PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                const FeedTab(feedName: POPULAR),
                const FeedTab(feedName: NEW_SUBSCRIBED),
                const FeedTab(feedName: BEST_SUBSCRIBED),
                const SubbedTab(),
              ],
            ),
      ),
      bottomNavigationBar: IconNavigationBar(
        currentIndex: _currentTab,
        icons: [
          const IconNavigationBarItem(
            icon: Icon(Icons.show_chart),
            tooltip: 'Popular',
          ),
          const IconNavigationBarItem(
            icon: Icon(Icons.star),
            tooltip: 'Your newest',
          ),
          const IconNavigationBarItem(
            icon: Icon(Icons.whatshot),
            tooltip: 'Your best',
          ),
          const IconNavigationBarItem(
            icon: Icon(Icons.short_text),
            tooltip: 'Subscriptions',
          ),
        ],
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
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const ReddigramLogo(),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.account_circle),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => PreferencesSheet(),
          );
        },
      ),
    );
  }
}
