import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class SearchTextForm extends StatelessWidget {
  const SearchTextForm(
      {Key? key,
      required this.textColor,
      required this.fillColor,
      required this.hintText,
      required this.search})
      : super(key: key);
  final Color textColor, fillColor;
  final String hintText;
  final Function search;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (text) {
        search(text);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: textColor,
          size: 30.sp,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
            color: textColor, fontFamily: AppFonts.mainfont, fontSize: 13.sp),
        fillColor: fillColor,
        filled: true,
        contentPadding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none),
      ),
    );
  }
}
