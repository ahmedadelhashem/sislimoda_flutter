import 'package:auto_route/annotations.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/offers/get_offers_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/screens/offers/offers_data.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> with OffersData {
  @override
  void initState() {
    // TODO: implement initState
    getAllOffers();
    super.initState();
  }

  String _searchTerm = '';

  void search(String value) {
    setState(() {
      _searchTerm = value.trim().toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
          ctx: context,
          search: search,
        ),
        body: context.isMobile ? mobileDesing() : webDesing());
  }
  /*
  Widget webDesing() {
  return Screen(
    loadingCubit: loading,
    child: Container(
      padding: const EdgeInsets.only(left: 34, right: 34),
      width: double.infinity,
      height: 1.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.offersManagement.tr(),
                    style: AppFonts.apptextStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 22),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    LocaleKeys.offersManagementHint.tr(),
                    style: AppFonts.apptextStyle.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 150,
                height: 40,
                child: AppButton(
                  onPress: addOffer,
                  title: LocaleKeys.addOffer.tr(),
                  titleFontColor: Colors.white,
                  titleFontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          SizedBox(height: 25.h),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 24),
                      Text(
                        LocaleKeys.offers.tr(),
                        style: AppFonts.apptextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GenericBuilder<List<OfferModel>>(
                        genericCubit: offersCubit,
                        builder: (offers) {
                          final filteredOffers = offers
                              .where((element) => (element.title ?? '')
                                  .toLowerCase()
                                  .contains(_searchTerm))
                              .toList();

                          return DataTable2(
                            dividerThickness: 0,
                            columns: [
                              DataColumn2(
                                label: Text(
                                  LocaleKeys.offerName.tr(),
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
                                label: Text(''),
                                size: ColumnSize.S,
                              ),
                            ],
                            rows: filteredOffers.map((element) {
                              final isExpired = DateTime.now().isAfter(
                                DateFormat('yyyy-MM-dd')
                                    .parse(element.endDate ?? ''),
                              );

                              return DataRow2(cells: [
                                DataCell(Text(
                                  element.title ?? '',
                                  maxLines: 2,
                                  style: AppFonts.apptextStyle.copyWith(
                                      fontSize: 14,
                                      height: 1.6,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryFontColor),
                                )),
                                DataCell(Text(
                                  '${element.endDate?.getDateFormated ?? ''} ${LocaleKeys.day.tr()}',
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
                                DataCell(Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: isExpired
                                        ? AppColors.error.withOpacity(.5)
                                        : Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  child: Center(
                                    child: Text(
                                      !(element.isActive ?? false)
                                          ? (isArabic ? 'معطل' : 'Freezed')
                                          : (isArabic ? 'فعال' : 'Active'),
                                      style: AppFonts.apptextStyle.copyWith(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                  ),
                                )),
                                DataCell(
                                  PopupMenuButton(
                                    position: PopupMenuPosition.under,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    constraints:
                                        BoxConstraints(minWidth: 220.w),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          height: 35,
                                          onTap: () {
                                            updateOffer(offer: element);
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppImages.update,
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                LocaleKeys.updateOffer.tr(),
                                                style: AppFonts.apptextStyle
                                                    .copyWith(
                                                        color: AppColors.black,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                        PopupMenuItem(
                                          height: 35,
                                          onTap: () {
                                            CustomAlert.showConfirmDialogue(
                                              confirmDone: () async {
                                                loading.show;
                                                await AppService.callService(
                                                  actionType: ActionType.post,
                                                  apiName:
                                                      'api/Offers/Delete?Id=${element.id}',
                                                  body: null,
                                                );
                                                getAllOffers();
                                              },
                                              message: LocaleKeys.deleteOffer.tr(),
                                              context: context,
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                AppImages.delete,
                                                width: 20,
                                                height: 20,
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                !(element.isActive ?? false)
                                                    ? LocaleKeys.unFreeze.tr()
                                                    : LocaleKeys.freeze.tr(),
                                                style: AppFonts.apptextStyle
                                                    .copyWith(
                                                        color: AppColors.error,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ];
                                    },
                                    child: Icon(Icons.more_horiz),
                                  ),
                                ),
                              ]);
                            }).toList(),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
*/

  Widget webDesing() {
    return Screen(
      loadingCubit: loading,
      child: Container(
        padding: const EdgeInsets.only(left: 34, right: 34),
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
                      LocaleKeys.offersManagement.tr(),
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      LocaleKeys.offersManagementHint.tr(),
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
                const Spacer(),
                // SizedBox(
                //   width: 150,
                //   height: 40,
                //   child: AppButton(
                //     backgroundColor: Colors.white,
                //     borderColor: AppColors.mainColor,
                //     onPress: () {},
                //     title: LocaleKeys.productsDetails.tr(),
                //     titleFontColor: AppColors.black,
                //     titleFontSize: 15,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
                // SizedBox(
                //   width: 10.w,
                // ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: AppButton(
                    onPress: addOffer,
                    title: LocaleKeys.addOffer.tr(),
                    titleFontColor: Colors.white,
                    titleFontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        LocaleKeys.offers.tr(),
                        style: AppFonts.apptextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ],
                  ),
                  GenericBuilder<List<OfferModel>>(
                      genericCubit: offersCubit,
                      builder: (offers) {
                        return Expanded(
                          child: DataTable2(
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
                                  LocaleKeys.offerName.tr(),
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
                            rows: offers.isNotEmpty
                                ? offers.where((element) {
                                    final title =
                                        element.title?.toLowerCase() ?? '';
                                    return title.contains(_searchTerm);
                                  }).map((element) {
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
                                          element.title ?? '',
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
                                        '${element.endDate?.getDateFormated} ${LocaleKeys.day.tr()}',
                                        style: AppFonts.apptextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.secondaryFontColor),
                                      )),
                                      DataCell(Text(
                                        '${element?.amount}%',
                                        style: AppFonts.apptextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.secondaryFontColor),
                                      )),
                                      DataCell(Text(
                                        (element.amount ?? '0').toString(),
                                        style: AppFonts.apptextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.secondaryFontColor),
                                      )),
                                      DataCell(Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: DateTime.now().isBefore(
                                                        DateFormat('yyyy-MM-dd')
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
                                                !(element.isActive ?? false)
                                                    ? isArabic
                                                        ? 'معطل'
                                                        : 'Freezed'
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
                                                    BorderRadius.circular(
                                                        15.r)),
                                            constraints:
                                                BoxConstraints(minWidth: 220.w),
                                            itemBuilder: (context) {
                                              return [
                                                PopupMenuItem(
                                                    height: 35,
                                                    onTap: () {
                                                      updateOffer(
                                                          offer: element!);
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
                                                                  color:
                                                                      AppColors
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
                                                                getAllOffers();
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
                                                              : LocaleKeys
                                                                  .freeze
                                                                  .tr(),
                                                          style: AppFonts
                                                              .apptextStyle
                                                              .copyWith(
                                                                  color:
                                                                      AppColors
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
                                  }).toList()
                                : [],
                          ),
                        );
                      }),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

/*
  Widget mobileDesing() {
    return Screen(
      loadingCubit: loading,
      child: Container(
        padding: const EdgeInsets.only(left: 34, right: 34),
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
                      LocaleKeys.offersManagement.tr(),
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.spMin),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    SizedBox(
                      width: .4.sw,
                      child: Text(
                        LocaleKeys.offersManagementHint.tr(),
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.spMin),
                      ),
                    )
                  ],
                ),
                const Spacer(),
                // SizedBox(
                //   width: 150,
                //   height: 40,
                //   child: AppButton(
                //     backgroundColor: Colors.white,
                //     borderColor: AppColors.mainColor,
                //     onPress: () {},
                //     title: LocaleKeys.productsDetails.tr(),
                //     titleFontColor: AppColors.black,
                //     titleFontSize: 15,
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
                // SizedBox(
                //   width: 10.w,
                // ),
                SizedBox(
                  width: 80.w,
                  height: 35.h,
                  child: AppButton(
                    onPress: addOffer,
                    title: LocaleKeys.addOffer.tr(),
                    titleFontColor: AppColors.black,
                    titleFontSize: 11.spMin,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 24,
                      ),
                      Text(
                        LocaleKeys.offers.tr(),
                        style: AppFonts.apptextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ],
                  ),
                  // GenericBuilder<GetOffersPaginationModel>(
                  //     genericCubit: offersCubit,
                  //     builder: (offers) {
                  //       return Expanded(
                  //         child: ListView.separated(
                  //             padding: EdgeInsets.all(15),
                  //             itemBuilder: (context, index) {
                  //               return OfferItem(offer: offers.Offer?[index]);
                  //             },
                  //             separatorBuilder: (cotnext, index) {
                  //               return SizedBox(
                  //                 height: 10,
                  //               );
                  //             },
                  //             itemCount: offers.Offer?.length ?? 0),
                  //       );
                  //     }),
                  // GenericBuilder<GetOffersPaginationModel>(
                  //     genericCubit: offersCubit,
                  //     builder: (offers) {
                  //       return Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         children: [
                  //           Pagination(
                  //             currentPage: page,
                  //             totalPage: totalPages,
                  //             show: totalPages > 10 ? 10 : totalPages - 1,
                  //             useSkipAndPrevButtons: true,
                  //             nextButtonStyles: PaginateSkipButton(
                  //                 buttonBackgroundColor: Colors.transparent,
                  //                 icon: Icon(
                  //                   Icons.arrow_forward_ios,
                  //                   size: 15,
                  //                 )),
                  //             prevButtonStyles: PaginateSkipButton(
                  //                 buttonBackgroundColor: Colors.transparent,
                  //                 icon: Icon(
                  //                   Icons.arrow_back_ios,
                  //                   size: 15,
                  //                 )),
                  //             paginateButtonStyles: PaginateButtonStyles(
                  //                 paginateButtonBorderRadius:
                  //                     BorderRadius.circular(8),
                  //                 activeBackgroundColor:
                  //                     Colors.blue.withOpacity(.1),
                  //                 activeTextStyle: AppFonts.apptextStyle
                  //                     .copyWith(
                  //                         color: Colors.black, fontSize: 12),
                  //                 backgroundColor: Colors.transparent,
                  //                 textStyle: AppFonts.apptextStyle.copyWith(
                  //                     color: Colors.black, fontSize: 12)),
                  //             onPageChange: (int number) async {
                  //               page = number;
                  //               await getAllOffers();
                  //               setState(() {});
                  //             },
                  //           ),
                  //         ],
                  //       );
                  //     }),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }*/
  Widget mobileDesing() {
    return Screen(
      loadingCubit: loading,
      child: GenericBuilder<List<OfferModel>>(
        genericCubit: offersCubit,
        builder: (offers) {
          final filteredOffers = offers.where((element) {
            final title = element.title?.toLowerCase() ?? '';
            return title.contains(_searchTerm);
          }).toList();

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Text(
                      LocaleKeys.offersManagement.tr(),
                      style: AppFonts.apptextStyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.spMin,
                        color: AppColors.black,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: addOffer,
                      icon: Icon(Icons.add_box,
                          color: AppColors.secondaryFontColor),
                      tooltip: LocaleKeys.addOffer.tr(),
                    )
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  LocaleKeys.offersManagementHint.tr(),
                  style: AppFonts.apptextStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.spMin,
                    color: AppColors.secondaryFontColor,
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  decoration: InputDecoration(
                    hintText: LocaleKeys.search.tr(),
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  onChanged: (value) => search(value),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: filteredOffers.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final offer = filteredOffers[index];
                      final isExpired = DateTime.now().isAfter(
                        DateFormat('yyyy-MM-dd').parse(offer.endDate ?? ''),
                      );
                      final statusText = !(offer.isActive ?? false)
                          ? (isArabic ? 'معطل' : 'Freezed')
                          : (isArabic ? 'فعال' : 'Active');

                      return Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offer.title ?? '',
                              style: AppFonts.apptextStyle.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${offer.endDate?.getDateFormated ?? ''} ${LocaleKeys.day.tr()}',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12.sp),
                                ),
                                Text(
                                  '${offer.amount}%',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                color: isExpired
                                    ? Colors.green
                                    : AppColors.error.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: Text(
                                  statusText,
                                  style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit,
                                      color: AppColors.secondaryFontColor),
                                  onPressed: () => updateOffer(offer: offer),
                                  tooltip: LocaleKeys.updateOffer.tr(),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: AppColors.error),
                                  onPressed: () {
                                    CustomAlert.showConfirmDialogue(
                                      confirmDone: () async {
                                        loading.show;
                                        await AppService.callService(
                                          actionType: ActionType.post,
                                          apiName:
                                              'api/Offers/Delete?Id=${offer.id}',
                                          body: null,
                                        );
                                        getAllOffers();
                                      },
                                      message: LocaleKeys.deleteOffer.tr(),
                                      context: context,
                                    );
                                  },
                                  tooltip: !(offer.isActive ?? false)
                                      ? LocaleKeys.unFreeze.tr()
                                      : LocaleKeys.freeze.tr(),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
