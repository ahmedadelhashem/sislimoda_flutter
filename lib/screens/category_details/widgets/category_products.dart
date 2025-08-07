import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/overview/componets/products_data_table.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key, required this.products});
  final List<ProductModel> products;
  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    return DataTable2(
      empty: Center(
        child: Text(
          isArabic
              ? 'لا يوجد منتجات'
              : 'No products found',
          style: AppFonts
              .apptextStyle
              .copyWith(
              color: Colors
                  .black,
              fontWeight:
              FontWeight
                  .w600,
              fontSize:
              16),
        ),
      ),
      dividerThickness: 0,
      columns: [
        // DataColumn2(
        //   label: AppCheckbox(label: Text('')),
        //   fixedWidth: 60,
        // ),
        DataColumn2(
          label: Text(
            LocaleKeys.id
                .tr(),
            style: AppFonts
                .apptextStyle
                .copyWith(
                fontSize:
                16,
                fontWeight:
                FontWeight
                    .w400,
                color: AppColors
                    .secondaryFontColor),
          ),
          fixedWidth: 200,
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys
                .productName
                .tr(),
            style: AppFonts
                .apptextStyle
                .copyWith(
                fontSize:
                16,
                fontWeight:
                FontWeight
                    .w400,
                color: AppColors
                    .secondaryFontColor),
          ),
          fixedWidth: 300,
          size: ColumnSize.L,
        ),
        // DataColumn2(
        //   label: Text(
        //     LocaleKeys.stock.tr(),
        //     style: AppFonts
        //         .apptextStyle
        //         .copyWith(
        //             fontSize: 16,
        //             fontWeight:
        //                 FontWeight
        //                     .w400,
        //             color: AppColors
        //                 .secondaryFontColor),
        //   ),
        //   size: ColumnSize.L,
        // ),
        DataColumn2(
          label: Text(
            LocaleKeys.price
                .tr(),
            style: AppFonts
                .apptextStyle
                .copyWith(
                fontSize:
                16,
                fontWeight:
                FontWeight
                    .w400,
                color: AppColors
                    .secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys
                .soldNumber
                .tr(),
            style: AppFonts
                .apptextStyle
                .copyWith(
                fontSize:
                16,
                fontWeight:
                FontWeight
                    .w400,
                color: AppColors
                    .secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            '',
            style: AppFonts
                .apptextStyle
                .copyWith(
                fontSize:
                16,
                fontWeight:
                FontWeight
                    .w400,
                color: AppColors
                    .secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
      ],
      rows:widget.products
          .map(
            (e) => DataRow2(
          cells: [
            DataCell(Text(
              e.id?.substring(
                  0,5) ??
                  '',
              maxLines: 2,
              style: AppFonts.apptextStyle.copyWith(
                  fontSize:
                  16,
                  fontWeight:
                  FontWeight
                      .w400,
                  color: AppColors
                      .secondaryFontColor),
            )),
            DataCell(Text(
              isArabic
                  ? (e.name ??
                  '')
                  : (e.nameEn ??
                  ''),
              style: AppFonts.apptextStyle.copyWith(
                  fontSize:
                  16,
                  fontWeight:
                  FontWeight
                      .w400,
                  color: AppColors
                      .secondaryFontColor),
            )),
            // DataCell(Text(
            //   e.V ?? '',
            //   style: AppFonts
            //       .apptextStyle
            //       .copyWith(
            //           fontSize:
            //               16,
            //           fontWeight:
            //               FontWeight
            //                   .w400,
            //           color: AppColors
            //               .secondaryFontColor),
            // )),
            DataCell(Text(
              e.priceAfterProgramInfluencer ??
                  '',
              style: AppFonts.apptextStyle.copyWith(
                  fontSize:
                  16,
                  fontWeight:
                  FontWeight
                      .w400,
                  color: AppColors
                      .secondaryFontColor),
            )),
            DataCell(Text(
              e.orderNUmber ??
                  '',
              style: AppFonts.apptextStyle.copyWith(
                  fontSize:
                  16,
                  fontWeight:
                  FontWeight
                      .w400,
                  color: AppColors
                      .secondaryFontColor),
            )),
            DataCell(
              Column(
                mainAxisAlignment:
                MainAxisAlignment
                    .center,
                children: [
                  InkWell(
                    onTap:
                        () {
                      showProductDetails(
                          context: context,
                          product: e);
                    },
                    child:
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 8),
                      decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child:
                      Center(
                        child: Text(
                          LocaleKeys.productsDetails.tr(),
                          style: AppFonts.apptextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.mainColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          .toList(),
    );
  }
}
