import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/components/side_bar.dart';
import 'package:sislimoda_admin_dashboard/main.dart';

ValueNotifier<String> globalCurrentRoute = ValueNotifier<String>('0');

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    currentContext = route.navigator?.context ?? currentContext;
    VendorSideBarState.setItems(context: currentContext);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    // TODO: implement didPop
    super.didPop(route, previousRoute);
    print("didPop: ${route.settings.name.toString()}}");
    currentContext = previousRoute?.navigator?.context ?? currentContext;
    globalCurrentRoute.value = '';
    globalCurrentRoute.value =
        '${previousRoute?.settings.name.toString()}+${route.settings.name}';
    VendorSideBarState.setItems(context: currentContext);
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    //print('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    //print('Tab route re-visited: ${route.name}');
  }
}
