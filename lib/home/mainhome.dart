import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/home/tab_navigator.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  Size size;
  String _currentPage = "Page1";
  List<String> pageKeys = ["Home", "Reward", "Profile"];
  int _selectedIndex = 0;
  Domain domain = new Domain();

  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "Home": GlobalKey<NavigatorState>(),
    "Reward": GlobalKey<NavigatorState>(),
    "Profile": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectTab('Home', 0);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return new WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage == "Home") {
            _selectTab("Home", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },

      child: new Scaffold(
          body: Stack(
              children:<Widget>[
                _buildOffstageNavigator("Home"),
                _buildOffstageNavigator("Reward"),
                _buildOffstageNavigator("Profile"),
              ]
          ),

          bottomNavigationBar: new BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            currentIndex: _selectedIndex,
            onTap: (int index) { _selectTab(pageKeys[index], index); },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                title: Text('Home', style: TextStyle(fontSize: 10),),
                icon: Icon(CupertinoIcons.home),
              ),
              BottomNavigationBarItem(
                title: Text('Reward', style: TextStyle(fontSize: 10),),
                icon: Icon(CupertinoIcons.layers_alt),
              ),
              BottomNavigationBarItem(
                title: Text('Profile', style: TextStyle(fontSize: 10),),
                icon: Icon(CupertinoIcons.person),
              ),
            ],
          )
      ),
    );
  }
}
