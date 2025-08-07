import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/models/offers/get_offers_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class OfferDatatable extends StatefulWidget {
  const OfferDatatable({super.key, required this.offers});
  final List<OfferModel> offers;
  @override
  State<OfferDatatable> createState() => _OfferDatatableState();
}

class _OfferDatatableState extends State<OfferDatatable> {
  @override
  Widget build(BuildContext context) {
    return DataTable2(
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
        // DataColumn2(
        //   label: Text(
        //     '',
        //     style: AppFonts.apptextStyle.copyWith(
        //         fontSize: 16,
        //         fontWeight: FontWeight.w400,
        //         color: AppColors.secondaryFontColor),
        //   ),
        //   size: ColumnSize.L,
        // ),
      ],
      rows: widget.offers.isNotEmpty
          ? widget.offers.map((element) {
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
            '${element.endDate} ${LocaleKeys.day.tr()}',
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
          // DataCell(
          //   PopupMenuButton(
          //       position: PopupMenuPosition.under,
          //       color: Colors.white,
          //       shape: RoundedRectangleBorder(
          //           borderRadius:
          //           BorderRadius.circular(
          //               15.r)),
          //       constraints:
          //       BoxConstraints(minWidth: 220.w),
          //       itemBuilder: (context) {
          //         return [
          //           PopupMenuItem(
          //               height: 35,
          //               onTap: () {
          //                 updateOffer(
          //                     offer: element!);
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
          //                         color:
          //                         AppColors
          //                             .black,
          //                         fontSize: 16,
          //                         fontWeight:
          //                         FontWeight
          //                             .w400),
          //                   ),
          //                 ],
          //               )),
          //           PopupMenuItem(
          //               height: 35,
          //               onTap: () {
          //                 CustomAlert
          //                     .showConfirmDialogue(
          //                     confirmDone:
          //                         () async {
          //                       loading.show;
          //                       await AppService.callService(
          //                           actionType:
          //                           ActionType
          //                               .post,
          //                           apiName:
          //                           'api/Offers/Delete?Id=${element.id}',
          //                           body: null);
          //                       getAllOffers();
          //                     },
          //                     message: LocaleKeys
          //                         .deleteOffer
          //                         .tr(),
          //                     context: context);
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
          //                         false)
          //                         ? LocaleKeys
          //                         .unFreeze
          //                         .tr()
          //                         : LocaleKeys
          //                         .freeze
          //                         .tr(),
          //                     style: AppFonts
          //                         .apptextStyle
          //                         .copyWith(
          //                         color:
          //                         AppColors
          //                             .error,
          //                         fontSize: 16,
          //                         fontWeight:
          //                         FontWeight
          //                             .w400),
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
      }).toList()
          : [],
    );
  }
}
