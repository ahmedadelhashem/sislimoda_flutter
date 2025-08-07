import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class AppFonts {
  static String mainfont = isArabic ? "Tajawal" : "Poppins";
  static TextStyle apptextStyle = GoogleFonts.almarai(
      fontSize: 16.spMin, fontWeight: FontWeight.w500, color: Colors.black);
}
