import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class WaitingActivation extends StatefulWidget {
  const WaitingActivation({super.key});

  @override
  State<WaitingActivation> createState() => _WaitingActivationState();
}

class _WaitingActivationState extends State<WaitingActivation> {
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
                ? 'في انتظار التنشيط من المشرف Sislimoda'
                : "Waiting Activation from admin Sislimoda ",
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
