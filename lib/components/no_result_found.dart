import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class NoResultFound extends StatelessWidget {
  const NoResultFound(
      {Key? key, this.title, this.fontSize = 16, this.iconSize = 160})
      : super(key: key);
  final String? title;
  final double fontSize;
  final double iconSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.noResultFound,
            width: iconSize.w,
            color: AppColors.mainColor,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            title == null ? LocaleKeys.noResultFound.tr() : title.toString(),
            textAlign: TextAlign.center,
            style: AppFonts.apptextStyle
                .copyWith(fontSize: 18.spMin, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
