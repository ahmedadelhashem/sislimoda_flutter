import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/models/categories/category_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key,
      required this.categoryItem,
      required this.delete,
      required this.update});
  final CategoryModel categoryItem;
  final Function delete, update;
  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return InkWell(
      onTap: () {
        context.router
            .push(CategoryDetailsRoute(categoryId: categoryItem.id ?? 'ß'));
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            SizedBox(
                width: 350,
                height: 135,
                child: CustomNetworkImage(
                  height: 135,
                  onTap: () {
                    context.router.push(CategoryDetailsRoute(
                        categoryId: categoryItem.id ?? 'ß'));
                  },
                  link: categoryItem.categoryPhoto?.fullLink ?? '',
                  width: 350,
                  fit: BoxFit.fitWidth,
                )),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    isArabic
                        ? (categoryItem.name ?? '')
                        : (categoryItem.nameEn ?? ''),
                    maxLines: 1,
                    style: AppFonts.apptextStyle.copyWith(
                        color: AppColors.black,
                        fontSize: 16.spMin,
                        fontWeight: FontWeight.w700),
                  ),
                ),
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
                                  LocaleKeys.updateCategory.tr(),
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
                                  LocaleKeys.deleteCategory.tr(),
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
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                SvgPicture.asset(
                  AppImages.market,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: 14.w,
                ),
                Text(
                  '14 ${LocaleKeys.product.tr()}',
                  style: AppFonts.apptextStyle.copyWith(
                      color: AppColors.secondaryFontColor,
                      fontSize: 16.spMin,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
