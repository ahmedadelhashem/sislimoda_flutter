import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      this.title = '',
      this.onPress,
      this.titleFontSize = 12,
      this.titleFontColor = Colors.white,
      this.borderRadius = 7,
      this.backgroundColor = AppColors.mainColor,
      this.borderColor = Colors.transparent,
      this.fontFamily,
      this.fontWeight = FontWeight.w500,
      this.icon})
      : super(key: key);
  final String title;
  final double titleFontSize;
  final Color titleFontColor;
  final double borderRadius;
  final Function? onPress;
  final Color backgroundColor, borderColor;
  final String? fontFamily;
  final FontWeight fontWeight;
  final String? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.all(0),
          side: MaterialStateProperty.all(BorderSide(color: borderColor)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r)))),
      onPressed: onPress != null
          ? () {
              onPress!();
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            SvgPicture.asset(
              icon.toString(),
              width: 20.w,
            ),
          if (icon != null)
            SizedBox(
              width: 10.w,
            ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              title,
              style: AppFonts.apptextStyle.copyWith(
                fontSize: titleFontSize,
                color: titleFontColor,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon(
      {Key? key,
      this.title = '',
      this.onPress,
      this.titleFontSize = 12,
      this.titleFontColor = Colors.white,
      this.borderRadius = 15,
      this.backgroundColor = AppColors.mainColor,
      this.borderColor = Colors.transparent,
      this.fontFamily,
      this.fontWeight = FontWeight.w500})
      : super(key: key);
  final String title;
  final double titleFontSize;
  final Color titleFontColor;
  final double borderRadius;
  final Function? onPress;
  final Color backgroundColor, borderColor;
  final String? fontFamily;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          surfaceTintColor: MaterialStateProperty.all(Colors.transparent),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.all(5),
          side: MaterialStateProperty.all(BorderSide(color: borderColor)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius.r)))),
      onPressed: onPress != null
          ? () {
              onPress!();
            }
          : null,
      child: Text(
        title,
        style: TextStyle(
            fontSize: titleFontSize,
            color: titleFontColor,
            fontWeight: fontWeight,
            fontFamily: fontFamily ?? AppFonts.mainfont),
      ),
    );
  }
}
