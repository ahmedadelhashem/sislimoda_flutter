import 'package:auto_route/annotations.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/no_result_found.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/screens/banners/banners_data.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class BannersScreen extends StatefulWidget {
  const BannersScreen({super.key});

  @override
  State<BannersScreen> createState() => _BannersScreenState();
}

class _BannersScreenState extends State<BannersScreen> with BannersData {
  @override
  void initState() {
    // TODO: implement initState
    getBannersByType();
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
          appBar: AppBarCustom(
            ctx: context,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 18, right: 18),
            width: double.infinity,
            height: 1.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.banners.tr(),
                          style: AppFonts.apptextStyle.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: context.isMobile ? 14.spMin : 22),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                        height: 40,
                        width: 100,
                        child: AppButton(
                          title: LocaleKeys.add.tr(),
                          titleFontSize: 16,
                          onPress: () {
                            addBanner(context: context);
                          },
                        ))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: GenericBuilder(
                          builder: (banners) {
                            return banners.isNotEmpty
                                ? DataTable2(
                                    dividerThickness: 0,
                                    columns: [
                                      // DataColumn2(
                                      //   label: AppCheckbox(label: Text('')),
                                      //   fixedWidth: 60,
                                      // ),
                                      // DataColumn2(
                                      //   label: Text(
                                      //     LocaleKeys.offerImage.tr(),
                                      //     style: AppFonts.apptextStyle.copyWith(
                                      //         fontSize: 16,
                                      //         fontWeight: FontWeight.w400,
                                      //         color: AppColors.secondaryFontColor),
                                      //   ),
                                      //   size: ColumnSize.L,
                                      // ),
                                      DataColumn2(
                                          label: Text(
                                            isArabic ? " الصورة" : "image",
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .secondaryFontColor),
                                          ),
                                          fixedWidth: 300.w
                                          // size: ColumnSize.L,
                                          ),
                                      DataColumn2(
                                          label: Text(
                                            LocaleKeys.product.tr(),
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .secondaryFontColor),
                                          ),
                                          // size: ColumnSize.L,
                                          fixedWidth: 700.w),

                                      DataColumn2(
                                        label: Text(
                                          '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        ),
                                        size: ColumnSize.L,
                                      ),
                                    ],
                                    rows: banners.map((element) {
                                      return DataRow2(cells: [
                                        DataCell(
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(9)),
                                            child: CustomNetworkImage(
                                              link:
                                                  element.image?.fullLink ?? '',
                                              height: 100,
                                              fit: BoxFit.fitHeight,
                                              width: 300,
                                            ),
                                          ),
                                        ),
                                        DataCell(Text(
                                          isArabic
                                              ? element.product?.name ?? ''
                                              : element.product?.nameEn ?? '',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        )),
                                        DataCell(
                                          PopupMenuButton(
                                              position: PopupMenuPosition.under,
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.r)),
                                              constraints: BoxConstraints(
                                                  minWidth: 220.w),
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                      height: 35,
                                                      onTap: () {
                                                        delete(
                                                            bannerId:
                                                                element.id ??
                                                                    "");
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
                                                            isArabic
                                                                ? 'مسح'
                                                                : "Delete",
                                                            style: AppFonts
                                                                .apptextStyle
                                                                .copyWith(
                                                                    color: AppColors
                                                                        .error,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                          ),
                                                        ],
                                                      )),
                                                ];
                                              },
                                              child: Icon(
                                                Icons.more_horiz,
                                              )),
                                        ),
                                      ]);
                                    }).toList(),
                                  )
                                : SizedBox(
                                    width: 1.sw,
                                    child: Center(
                                        child: NoResultFound(
                                      title: isArabic
                                          ? "لم يتم العثور على كوبونات"
                                          : "No Coupons found",
                                    )));
                          },
                          genericCubit: bannersCubit)),
                )
              ],
            ),
          )),
    );
  }
}
