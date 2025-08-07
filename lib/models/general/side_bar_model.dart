import 'package:auto_route/auto_route.dart';

class SideBarModel {
  final String title;
  final String icon;
  final PageRouteInfo goto;

  SideBarModel({
    required this.title,
    required this.goto,
    required this.icon,
  });
}
