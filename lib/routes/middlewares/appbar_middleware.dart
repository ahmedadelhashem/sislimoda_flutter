import 'package:auto_route/auto_route.dart';

class AppbarMiddleware extends AutoRouteGuard {
  AppbarMiddleware();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    resolver.next(true);
  }
}
