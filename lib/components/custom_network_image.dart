import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_network/image_network.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class CustomNetworkImage extends StatelessWidget {
  final BoxFit? fit;
  final double? width, height;
  final String id;
  const CustomNetworkImage(
      {super.key,
      required this.link,
      required this.height,
      this.fit = BoxFit.cover,
      required this.width,
      this.id = '',
      this.onTap});
  final String link;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return true
        ? Material(
            child: ImageNetwork(
              onTap: () {
                if (onTap != null) {
                  onTap!();
                }
              },
              key: UniqueKey(),
              duration: 1200,
              image: link,
              height: height ?? 100,
              width: width ?? 100,
              // fitWeb: BoxFitWeb.scaleDown,
              onError: Container(
                padding: EdgeInsets.all(15),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.unSelectedFontColor),
                  borderRadius: BorderRadius.circular(12.r),
                  // border: Border.all(color: Color(0xff6A1244))
                ),
                child: Center(
                    child: Image.asset(
                  AppImages.logo,
                  color: Colors.red,
                  width: double.infinity,
                )),
              ),
              onLoading: CupertinoActivityIndicator(
                color: AppColors.mainColor,
              ),
            ),
          )
        : CachedNetworkImage(
            imageUrl: AppSetting.serviceURL + link,
            fit: fit,
            width: width,
            errorWidget: (contex, string, d) => Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                // border: Border.all(color: AppColors.unSelectedFontColor),
                borderRadius: BorderRadius.circular(12.r),
                // border: Border.all(color: Color(0xff6A1244))
              ),
              child: Center(
                  child: Image.asset(
                AppImages.logo,
                width: double.infinity,
              )),
            ),
            placeholder: (context, _) => const Center(
              child: CupertinoActivityIndicator(
                color: AppColors.mainColor,
              ),
            ),
          );
  }
}
