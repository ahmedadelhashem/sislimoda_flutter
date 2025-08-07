import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/add_notification.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';

class ArchPlane extends StatelessWidget {
  const ArchPlane({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'asset/images/arch.svg',
          width: 1.sw > 834 ? 1000 : 600,
          // height: 190,
        ),
        Positioned(
          right: 1.sw > 834 ? 220 : 80,
          top: 1.sw > 834 ? 24 : 20,
          child: SvgPicture.asset(
            'asset/images/plane.svg',
            width: 66,
            height: 51,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            backgroundColor: Color(0xff000000).withOpacity(.4),
            radius: 3,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: CircleAvatar(
            backgroundColor: Color(0xff000000).withOpacity(.4),
            radius: 3,
          ),
        ),
      ],
    );
  }
}
