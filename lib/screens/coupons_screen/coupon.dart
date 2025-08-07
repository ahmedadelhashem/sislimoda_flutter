import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/no_result_found.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/tab_bar_custom.dart';
import 'package:sislimoda_admin_dashboard/models/coupons/coupon_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/coupons_screen/coupon_data.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class Coupons extends StatefulWidget {
  const Coupons({super.key});

  @override
  State<Coupons> createState() => _CouponsState();
}
class _CouponsState extends State<Coupons> with CouponData {
  @override
  
  void initState() {
    // TODO: implement initState
    
    getCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        ctx: context,
        search: search,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 34, right: 34),
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
                      isArabic ? 'إدارة الكوبونات' : "Coupons management",
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: .4.sw,
                      child: Text(
                        isArabic
                            ? 'يمكنك إدارة جميع القسائم'
                            : "You can manage all coupons",
                        style: AppFonts.apptextStyle.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                Spacer(),
                // SizedBox(
                //   width: 247,
                //   height: 40,
                //   child: AppButton(
                //     title: isArabic ? "أضف كوبونات" : "Add Coupons",
                //     titleFontColor: Colors.white,
                //     onPress: () {},
                //     titleFontSize: 16,
                //     fontWeight: FontWeight.w700,
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            SizedBox(
              height: .75.sh,
              child: TabBarCustom(tabNames: [
                isArabic ? 'كوبونات المشاهير' : "Influencer Coupons",
                isArabic ? 'كوبونات النظام' : "System Coupons",
              ], children: [
                Screen(
                  loadingCubit: loading,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: GenericBuilder<List<CouponModel>>(
                      genericCubit: influencerCouponsCubit,
                      builder: (coupons) {
                        return coupons.isNotEmpty
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
                                      isArabic ? " الكود" : "Code",
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      isArabic
                                          ? "اسم المؤثر"
                                          : "Influencer Name",
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      isArabic
                                          ? "رقم المؤثر"
                                          : "Influencer Number",
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      LocaleKeys.duration.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      LocaleKeys.discountAmount.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.M,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      LocaleKeys.salesAmount.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      isArabic
                                          ? " حالة الصلاحية"
                                          : "Expiration status",
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.M,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      LocaleKeys.status.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.S,
                                  ),
                                ],
                                rows: coupons.map((element) {
                                  return DataRow2(
                                      onTap: () {
                                        context.router.push(CouponDetailsRoute(
                                            couponId: element.id ?? ''));
                                      },
                                      cells: [
                                        // DataCell(Container(
                                        //   clipBehavior: Clip.antiAlias,
                                        //   decoration: BoxDecoration(
                                        //       borderRadius:
                                        //           BorderRadius.circular(10)),
                                        //   child: Image.asset(
                                        //     'asset/images/hair.png',
                                        //     fit: BoxFit.cover,
                                        //     width: double.infinity,
                                        //   ),
                                        // )),
                                        DataCell(
                                          Text(
                                            element.code ?? '',
                                            maxLines: 2,
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 14,
                                                    height: 1.6,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .secondaryFontColor),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            element.influencer?.name ?? '',
                                            maxLines: 2,
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 14,
                                                    height: 1.6,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .secondaryFontColor),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            element.influencer
                                                    ?.whatsappNumber1 ??
                                                '',
                                            maxLines: 2,
                                            style: AppFonts.apptextStyle
                                                .copyWith(
                                                    fontSize: 14,
                                                    height: 1.6,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .secondaryFontColor),
                                          ),
                                        ),
                                        DataCell(Text(
                                          '${DateFormat('dd-MM-yyyy').parse(element.endDate ?? '').difference(DateFormat('dd-MM-yyyy').parse(element.startDate ?? '')).inDays} ${LocaleKeys.day.tr()}',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        )),
                                        DataCell(Text(
                                          '${element.percent}%',
                                          style: AppFonts.apptextStyle.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryFontColor),
                                        )),
                                      DataCell(Text(
  element.couponProducts!
      .map((e) => e?.totalSales ?? 0)
      .fold<int>(0, (prev, e) => prev + e)
      .toString(),
  style: AppFonts.apptextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryFontColor),
)),


                                        DataCell(Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: DateTime.now().isAfter(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(element
                                                                      .endDate ??
                                                                  ''))
                                                      ? AppColors.error
                                                          .withOpacity(.5)
                                                      : Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Center(
                                                child: Text(
                                                  DateTime.now().isAfter(
                                                          DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .parse(element
                                                                      .endDate ??
                                                                  ''))
                                                      ? isArabic
                                                          ? 'منتهي'
                                                          : 'Expired'
                                                      : isArabic
                                                          ? 'صالح'
                                                          : 'Valid',
                                                  style: AppFonts.apptextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                        DataCell(Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: (element.isActive ==
                                                          false)
                                                      ? AppColors.error
                                                          .withOpacity(.5)
                                                      : Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              child: Center(
                                                child: Text(
                                                  (element.isActive == false)
                                                      ? isArabic
                                                          ? 'غير فعال'
                                                          : 'DeActive'
                                                      : isArabic
                                                          ? 'فعال'
                                                          : 'Active',
                                                  style: AppFonts.apptextStyle
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors.black),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                        // DataCell(
                                        //   PopupMenuButton(
                                        //       position: PopupMenuPosition.under,
                                        //       color: Colors.white,
                                        //       shape: RoundedRectangleBorder(
                                        //           borderRadius:
                                        //               BorderRadius.circular(15.r)),
                                        //       constraints:
                                        //           BoxConstraints(minWidth: 220.w),
                                        //       itemBuilder: (context) {
                                        //         return [
                                        //           PopupMenuItem(
                                        //               height: 35,
                                        //               onTap: () {
                                        //                 // updateOffer(
                                        //                 //     offer: element!);
                                        //               },
                                        //               child: Row(
                                        //                 children: [
                                        //                   SvgPicture.asset(
                                        //                     AppImages.update,
                                        //                     width: 20,
                                        //                     height: 20,
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 10,
                                        //                   ),
                                        //                   Text(
                                        //                     LocaleKeys.updateOffer
                                        //                         .tr(),
                                        //                     style: AppFonts
                                        //                         .apptextStyle
                                        //                         .copyWith(
                                        //                             color: AppColors
                                        //                                 .black,
                                        //                             fontSize: 16,
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w400),
                                        //                   ),
                                        //                 ],
                                        //               )),
                                        //           PopupMenuItem(
                                        //               height: 35,
                                        //               onTap: () {
                                        //                 CustomAlert
                                        //                     .showConfirmDialogue(
                                        //                         confirmDone:
                                        //                             () async {
                                        //                           loading.show;
                                        //                           await AppService.callService(
                                        //                               actionType:
                                        //                                   ActionType
                                        //                                       .post,
                                        //                               apiName:
                                        //                                   'api/Offers/Delete?Id=${element.id}',
                                        //                               body: null);
                                        //                           getCoupons();
                                        //                         },
                                        //                         message: LocaleKeys
                                        //                             .deleteOffer
                                        //                             .tr(),
                                        //                         context: context);
                                        //               },
                                        //               child: Row(
                                        //                 children: [
                                        //                   SvgPicture.asset(
                                        //                     AppImages.delete,
                                        //                     width: 20,
                                        //                     height: 20,
                                        //                   ),
                                        //                   SizedBox(
                                        //                     width: 10,
                                        //                   ),
                                        //                   Text(
                                        //                     !(element.isActive ??
                                        //                             false)
                                        //                         ? LocaleKeys
                                        //                             .unFreeze
                                        //                             .tr()
                                        //                         : LocaleKeys.freeze
                                        //                             .tr(),
                                        //                     style: AppFonts
                                        //                         .apptextStyle
                                        //                         .copyWith(
                                        //                             color: AppColors
                                        //                                 .error,
                                        //                             fontSize: 16,
                                        //                             fontWeight:
                                        //                                 FontWeight
                                        //                                     .w400),
                                        //                   ),
                                        //                 ],
                                        //               )),
                                        //         ];
                                        //       },
                                        //       child: Icon(
                                        //         Icons.more_horiz,
                                        //       )),
                                        // ),
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
                    ),
                  ),
                ),
                Screen(
                  loadingCubit: loading,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    child: GenericBuilder<List<CouponModel>>(
                      genericCubit: couponsCubit,
                      builder: (coupons) {
                        return coupons.isNotEmpty
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
                                      isArabic ? " الكود" : "Code",
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      LocaleKeys.duration.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      LocaleKeys.discountAmount.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      LocaleKeys.salesAmount.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      LocaleKeys.status.tr(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                  DataColumn2(
                                    label: Text(
                                      '',
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    ),
                                    size: ColumnSize.L,
                                  ),
                                ],
                                rows: coupons.map((element) {
                                  return DataRow2(cells: [
                                    // DataCell(Container(
                                    //   clipBehavior: Clip.antiAlias,
                                    //   decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(10)),
                                    //   child: Image.asset(
                                    //     'asset/images/hair.png',
                                    //     fit: BoxFit.cover,
                                    //     width: double.infinity,
                                    //   ),
                                    // )),
                                    DataCell(
                                      Text(
                                        element.code ?? '',
                                        maxLines: 2,
                                        style: AppFonts.apptextStyle.copyWith(
                                            fontSize: 14,
                                            height: 1.6,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.secondaryFontColor),
                                      ),
                                    ),
                                    DataCell(Text(
                                      '${DateFormat('dd-MM-yyyy').parse(element.endDate ?? '').difference(DateFormat('dd-MM-yyyy').parse(element.startDate ?? '')).inDays} ${LocaleKeys.day.tr()}',
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    )),
                                    DataCell(Text(
                                      '${element.amount}%',
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    )),
                                    DataCell(Text(
                                      (element.amount ?? '0').toString(),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryFontColor),
                                    )),
                                    DataCell(Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: DateTime.now().isAfter(
                                                      DateFormat('dd-MM-yyyy')
                                                          .parse(
                                                              element.endDate ??
                                                                  ''))
                                                  ? AppColors.error
                                                      .withOpacity(.5)
                                                  : Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Center(
                                            child: Text(
                                              DateTime.now().isAfter(
                                                      DateFormat('dd-MM-yyyy')
                                                          .parse(
                                                              element.endDate ??
                                                                  ''))
                                                  ? isArabic
                                                      ? 'منتهي'
                                                      : 'Expired'
                                                  : isArabic
                                                      ? 'فعال'
                                                      : 'Active',
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                    DataCell(
                                      PopupMenuButton(
                                          position: PopupMenuPosition.under,
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.r)),
                                          constraints:
                                              BoxConstraints(minWidth: 220.w),
                                          itemBuilder: (context) {
                                            return [
                                              PopupMenuItem(
                                                  height: 35,
                                                  onTap: () {
                                                    // updateOffer(
                                                    //     offer: element!);
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
                                                        LocaleKeys.updateOffer
                                                            .tr(),
                                                        style: AppFonts
                                                            .apptextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ],
                                                  )),
                                              PopupMenuItem(
                                                  height: 35,
                                                  onTap: () {
                                                    CustomAlert
                                                        .showConfirmDialogue(
                                                            confirmDone:
                                                                () async {
                                                              loading.show;
                                                              await AppService.callService(
                                                                  actionType:
                                                                      ActionType
                                                                          .post,
                                                                  apiName:
                                                                      'api/Offers/Delete?Id=${element.id}',
                                                                  body: null);
                                                              getCoupons();
                                                            },
                                                            message: LocaleKeys
                                                                .deleteOffer
                                                                .tr(),
                                                            context: context);
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
                                                        !(element.isActive ??
                                                                false)
                                                            ? LocaleKeys
                                                                .unFreeze
                                                                .tr()
                                                            : LocaleKeys.freeze
                                                                .tr(),
                                                        style: AppFonts
                                                            .apptextStyle
                                                            .copyWith(
                                                                color: AppColors
                                                                    .error,
                                                                fontSize: 16,
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
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
