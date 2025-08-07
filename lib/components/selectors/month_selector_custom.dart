import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class MonthSelectorCustom extends StatefulWidget {
  const MonthSelectorCustom({Key? key, required this.onChangeDate})
      : super(key: key);

  final Function onChangeDate;
  @override
  State<MonthSelectorCustom> createState() => _MonthSelectorCustomState();
}

class _MonthSelectorCustomState extends State<MonthSelectorCustom> {
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  var formatter = DateFormat.yMd();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          DateFormat.LLLL().format(selectedDate).toString() +
              ' ' +
              DateFormat('yyyy').format(selectedDate).toString(),
          style: TextStyle(
            fontFamily: AppFonts.mainfont,
            color: AppColors.mainColor,
            fontSize: 15.sp,
          ),
        ),
        const Spacer(),
        Transform(
          transform: isArabic ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              selectedDate =
                  selectedDate.subtract(Duration(days: selectedDate.day));
              setState(() {});
            },
            child: Container(
              width: 25.h,
              height: 25.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.r),
                  color: Colors.grey.withOpacity(.1)),
              child: Center(
                child: SvgPicture.asset('assets/images/skip.svg',
                    color: AppColors.mainColor),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15.w,
        ),
        if (selectedDate.isBefore(DateTime.now()))
          Transform(
            transform: !isArabic ? Matrix4.rotationY(pi) : Matrix4.rotationY(0),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (selectedDate.isBefore(DateTime.now())) {
                  selectedDate =
                      selectedDate.add(Duration(days: selectedDate.day));
                  setState(() {});
                }
              },
              child: Container(
                width: 25.h,
                height: 25.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: Colors.grey.withOpacity(.1)),
                child: Center(
                  child: SvgPicture.asset('assets/images/skip.svg',
                      color: AppColors.mainColor),
                ),
              ),
            ),
          )
      ],
    );
  }
}
