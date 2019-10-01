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
  static const _TAB_POPULAR = 0;
  static const _TAB_BEST = 1; // ignore: unused_field
  static const _TAB_NEWEST = 2; // ignore: unused_field
  static const _TAB_SUBBED = 3;

  final feedKeys = List.generate(3, (i) => GlobalKey<InfiniteListState>());

  final _pageController = PageController();
  int _currentTab = _TAB_POPULAR;

  @override
  Widget build(BuildContext context) {
    final subheadTheme = Theme.of(context).textTheme.subhead;

    final subscribeCTA = GestureDetector(
      onTap: () => _changeTab(_TAB_SUBBED),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No', style: subheadTheme),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.short_text,
                  size: 28.0,
                ),
              ),
              Text('yet.', style: subheadTheme)
            ],
          ),
          const SizedBox(height: 12.0),
          const Text('Subscribe to something!'),
        ],
      ),
    );

    final itemsPlaceholder = ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, i) => PhotoListItem.placeholder(),
    );

    return Scaffold(
      key: MainScreen.scaffoldKey,
      appBar: _buildAppBar(context),
      body: StoreConnector<ReddigramState, bool>(
        onInit: (store) => store.dispatch(fetchFreshFeed(POPULAR)),
        converter: (store) => store.state.subscriptions.isNotEmpty,
        builder: (context, anySubs) => PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            FeedTab(
              feedName: POPULAR,
              infiniteListKey: feedKeys[0],
              placeholder: itemsPlaceholder,
            ),
            FeedTab(
              feedName: BEST_SUBSCRIBED,
              infiniteListKey: feedKeys[1],
              placeholder: anySubs ? itemsPlaceholder : subscribeCTA,
            ),
            FeedTab(
              feedName: NEW_SUBSCRIBED,
              infiniteListKey: feedKeys[2],
              placeholder: anySubs ? itemsPlaceholder : subscribeCTA,
            ),
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
            icon: Icon(Icons.whatshot),
            tooltip: 'Your best',
          ),
          const IconNavigationBarItem(
            icon: Icon(Icons.star),
            tooltip: 'Your newest',
          ),
          const IconNavigationBarItem(
            icon: Icon(Icons.short_text),
            tooltip: 'Subscriptions',
          ),
        ],
        onTap: (index) {
          if (_currentTab != index) {
            // Change the current tab
            _changeTab(index);
          } else {
            // Scroll to the top
            setState(() => feedKeys[index].currentState.scrollToOffset(0));
          }
        },
      ),
    );
  }

  void _changeTab(int tab) {
    setState(() {
      _currentTab = tab;
      _pageController.animateToPage(
        tab,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
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
