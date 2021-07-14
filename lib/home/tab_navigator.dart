import 'package:flutter/material.dart';
import 'package:surveyqu/domain.dart';
import 'package:surveyqu/home/home.dart';
import 'package:surveyqu/profile/profile.dart';
import 'package:surveyqu/reward/reward.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  Domain domain = new Domain();

  List dataJson;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "Beranda")
      child = Home();
    else if(tabItem == "Hadiah")
      child = Reward();
    else if(tabItem == "Profil")
      child = Profile();
    
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child
        );
      },
    );
  }
}
