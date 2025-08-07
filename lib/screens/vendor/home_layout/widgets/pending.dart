import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class Pending extends StatelessWidget {
  const Pending({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'asset/images/clock.svg',
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            isArabic
                ? 'حسابك معلق من قبل المسؤول Sislimoda'
                : "Your Account pending by Admin",
            style: AppFonts.apptextStyle.copyWith(
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
