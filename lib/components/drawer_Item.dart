import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {Key? key,
      required this.title,
      required this.image,
      required this.action})
      : super(key: key);
  final String title, image;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 22.h,
              color: Colors.white,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10.w),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: AppFonts.mainfont,
                  fontSize: 16.sp,
                  height: 2),
            )
          ],
        ),
      ),
    );
  }
}
