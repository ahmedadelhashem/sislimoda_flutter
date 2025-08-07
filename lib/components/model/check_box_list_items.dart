import 'package:flutter/material.dart';

class CheckItems{
  String? name;
  bool? state;
  String? value;
  String icon;
  Color color;
  Color ActiveColor;

  CheckItems({
    this.state,
    this.name,
    this.value,
    required this.icon,
    required this.color,
    required this.ActiveColor
  });
}