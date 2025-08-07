
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
part 'font_size.dart';
part 'text_style_custom.dart';

String? font = AppFonts.mainfont;

class TxtN extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final Color color;
  final double fontSize;
  final bool bold;
  final FontWeight? fontWeight;
  final int? maxLines;
  final double height;
  final TextAlign? textAlign;

  const TxtN(
      {Key? key,
      required this.text,
      this.color = AppColors.mainColor,
      this.bold = false,
      this.fontWeight = FontWeight.w500,
      this.fontFamily,
      required this.fontSize,
      this.textAlign,
      this.height = 1,
      this.maxLines = 99,
      fontfamily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          height: height,
          fontSize: fontSize,
          fontFamily: fontFamily ?? AppFonts.mainfont,
          color: color,
          fontWeight: bold ? FontWeight.bold : fontWeight),
      maxLines: maxLines,
    );
  }
}

// class CustomTextAutoSize extends StatelessWidget {
//   final String text;
//   final String fontFamily;
//   final Color color;
//   final double fontSize;
//   final bool bold;
//   final FontWeight? fontWeight;
//   final int? maxLines;
//   final double height;
//   final TextAlign? textAlign;
//
//   const CustomTextAutoSize(
//       {Key? key,
//       required this.text,
//       required this.color,
//       this.bold = false,
//       this.fontWeight = FontWeight.normal,
//       required this.fontSize,
//       required this.fontFamily,
//       this.textAlign,
//       this.height = 1,
//       this.maxLines = 99})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AutoSizeText(
//       text,
//       textAlign: textAlign,
//       minFontSize: 6,
//       style: TextStyle(
//           height: height,
//           fontSize: fontSize,
//           fontFamily: fontFamily,
//           color: color,
//           fontWeight: bold ? FontWeight.bold : fontWeight),
//       maxLines: maxLines,
//     );
//   }
// }
