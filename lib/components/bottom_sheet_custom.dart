import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

bottomSheet(
    {required BuildContext context,
    required Widget child,
    int heightpre = 25}) {
  return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14), topRight: Radius.circular(14)),
      ),
      builder: (builder) {
        return Container(
          height: 1.sp * 0.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          child: Center(child: child),
        );
      });
}
