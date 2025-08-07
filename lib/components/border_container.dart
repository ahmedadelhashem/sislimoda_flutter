import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:flutter/material.dart';

class GlobalBorder {
  static Border border(Color color) {
    return isArabic
        ? Border(
            right: BorderSide(
              color: color,
              width: 3,
            ),
          )
        : Border(
            left: BorderSide(
              color: color,
              width: 3,
            ),
          );
  }
}
