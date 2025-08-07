import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/models/brands/brand_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class BrandItem extends StatelessWidget {
  const BrandItem(
      {super.key,
      required this.brand,
      required this.delete,
      required this.update});
  final BrandModel brand;
  final Function delete, update;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton(
                  position: PopupMenuPosition.under,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  constraints: BoxConstraints(minWidth: 220.w),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          height: 35,
                          onTap: () {
                            update();
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppImages.update,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                LocaleKeys.updateBrand.tr(),
                                style: AppFonts.apptextStyle.copyWith(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                      PopupMenuItem(
                          height: 35,
                          onTap: () {
                            delete();
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppImages.delete,
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                LocaleKeys.deleteBrand.tr(),
                                style: AppFonts.apptextStyle.copyWith(
                                    color: AppColors.error,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ];
                  },
                  child: Icon(
                    Icons.more_horiz,
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 243,
            height: 70,
            child: CustomNetworkImage(
              link: brand.brandPhoto?.fullLink ?? '',
              fit: BoxFit.fitHeight,
              width: 243,
              height: 70,
            ),
          )
        ],
      ),
    );
  }
}
