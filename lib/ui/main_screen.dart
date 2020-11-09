import 'package:flutter/material.dart' hide Action;
import 'package:iron_bank/ui/money_screen.dart';
import 'package:iron_bank/ui/scoring_screen.dart';

class MainScreenRoute extends MaterialPageRoute {
  MainScreenRoute() : super(builder: (context) => MainScreen());
}

///View
class MainScreen extends StatefulWidget {
  MainScreen({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final bottonBarItems = <BottomNavigationBarItem>[];
  final tabs = <Widget>[];
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _initBottomMenu();
    _initTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTab,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottonBarItems,
        elevation: 16.0,
        currentIndex: _currentTab,
        onTap: (index) => _changeTab(index),
        showUnselectedLabels: false,
      ),
    );
  }

  void _changeTab(int index) {
    if (index != _currentTab) {
      setState(() {
        _currentTab = index;
      });
    }
  }

  void _initBottomMenu() {
    bottonBarItems.addAll(
      [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.money,
            size: 24.0,
          ),
          activeIcon: Icon(
            Icons.money,
            size: 28.0,
          ),
          label: 'Money',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.download_sharp,
            size: 24.0,
          ),
          activeIcon: Icon(
            Icons.download_sharp,
            size: 28.0,
          ),
          label: 'Credit',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icon/ic_raven.png',
            height: 24.0,
            width: 24.0,
            color: Colors.grey[600],
          ),
          activeIcon: Image.asset(
            'assets/icon/ic_raven.png',
            height: 28.0,
            width: 28.0,
            color: Colors.blueAccent,
          ),
          label: 'Raven',
        ),
      ],
    );
  }

  void _initTabs() {
    tabs.addAll([
      MoneyScreen(),
      ScoringScreen(),
      Container(color: Colors.green),
    ]);
  }
}
