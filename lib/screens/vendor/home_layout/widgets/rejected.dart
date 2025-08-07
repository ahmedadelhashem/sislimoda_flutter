import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class Rejected extends StatelessWidget {
  const Rejected({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'asset/images/remove.svg',
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            isArabic
                ? ' تم حظر حسابك من قبل المسؤول Sislimoda'
                : "your account blocked by admin",
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
