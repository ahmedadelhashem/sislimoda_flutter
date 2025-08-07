import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/overview/componets/products_data_table.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
/*
class VendorProducts extends StatelessWidget {
  const VendorProducts({super.key, required this.products});
  final List<ProductModel> products;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DataTable2(
      empty: Center(
        child: Text(
          isArabic ? 'لا يوجد منتجات' : 'No products found',
          style: AppFonts.apptextStyle.copyWith(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      dividerThickness: 0,
      columns: [
        DataColumn2(
          label: Text(
            LocaleKeys.id.tr(),
            maxLines: 1,
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys.productName.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
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
            LocaleKeys.price.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(
            LocaleKeys.soldNumber.tr(),
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
      rows: products
          .map(
            (e) => DataRow2(
              cells: [
                DataCell(Text(
                  e.id?.substring(0, 8) ?? '',
                  maxLines: 2,
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                )),
                DataCell(Text(
                  isArabic ? (e.name ?? '') : (e.nameEn ?? ''),
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                )),
                DataCell(Text(
                  e.finalDisplayPrice ?? '',
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                )),
                DataCell(Text(
                  e.amount ?? '',
                  style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryFontColor),
                )),
                DataCell(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showProductDetails(
                              product: ProductModel.fromJson(e.toJson()),
                              context: context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 21, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.mainColor),
                          ),
                          child: Center(
                            child: Text(
                              LocaleKeys.productsDetails.tr(),
                              style: AppFonts.apptextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainColor),
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
    ));
  }
}
*/
class VendorProducts extends StatelessWidget {
  const VendorProducts({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final e = products[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic ? (e.name ?? '') : (e.nameEn ?? ''),
                    style: AppFonts.apptextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('${LocaleKeys.price.tr()}: ${e.finalDisplayPrice ?? ''}'),
                  SizedBox(height: 4),
                  Text('${LocaleKeys.soldNumber.tr()}: ${e.amount ?? ''}'),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {
                        showProductDetails(
                          product: ProductModel.fromJson(e.toJson()),
                          context: context,
                        );
                      },
                      child: Text(LocaleKeys.productsDetails.tr()),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    // Web / Tablet view
    return DataTable2(
      empty: Center(
        child: Text(
          isArabic ? 'لا يوجد منتجات' : 'No products found',
          style: AppFonts.apptextStyle.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16),
        ),
      ),
      dividerThickness: 0,
      columnSpacing: 16,
      minWidth: 700,
      columns: [
        DataColumn2(
          label: Text(LocaleKeys.id.tr(),
              style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor)),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(LocaleKeys.productName.tr(),
              style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor)),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(LocaleKeys.price.tr(),
              style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor)),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text(LocaleKeys.soldNumber.tr(),
              style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor)),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text(''),
          size: ColumnSize.S,
        ),
      ],
      rows: products.map((e) => DataRow2(
        cells: [
          DataCell(Text(e.id?.substring(0, 8) ?? '')),
          DataCell(Text(isArabic ? (e.name ?? '') : (e.nameEn ?? ''))),
          DataCell(Text(e.finalDisplayPrice ?? '')),
          DataCell(Text(e.amount ?? '')),
          DataCell(
            InkWell(
              onTap: () {
                showProductDetails(
                  product: ProductModel.fromJson(e.toJson()),
                  context: context,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.mainColor),
                ),
                child: Text(
                  LocaleKeys.productsDetails.tr(),
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      )).toList(),
    );
  }
}
