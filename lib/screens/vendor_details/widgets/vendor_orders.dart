import 'package:auto_route/auto_route.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
/*
class VendorOrders extends StatelessWidget {
  const VendorOrders({super.key, required this.orders});
  final List<OrderModel?> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          LocaleKeys.noOrders.tr(), 
          style: AppFonts.apptextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryFontColor,
          ),
        ),
      );
    }

    return DataTable2(
      dividerThickness: 0,
      columns: [
        DataColumn2(
          label: Text(
            LocaleKeys.id.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.S,
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
            fixedWidth: 250),
        DataColumn2(
            label: Text(
              LocaleKeys.clientName.tr(),
              style: AppFonts.apptextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryFontColor),
            ),
            size: ColumnSize.L,
            fixedWidth: 300),
        DataColumn2(
          label: Text(
            LocaleKeys.price.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.S,
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
            LocaleKeys.status.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
          size: ColumnSize.L,
        ),
      ],
      rows: orders.map((element) {
        return DataRow2(cells: [
          DataCell(
            Text(
              element?.id?.substring(0, 6) ?? '',
              maxLines: 2,
              style: AppFonts.apptextStyle.copyWith(
                  fontSize: 14,
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryFontColor),
            ),
          ),
          DataCell(Text(
            isArabic
                ? (element?.orderProducts?.first?.product?.name ?? '')
                : (element?.orderProducts?.first?.product?.nameEn ?? ''),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          )),
          DataCell(Text(
            '${element?.user?.firstName ?? ''} ${element?.user?.lastName ?? ''}',
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          )),
          DataCell(Text(
            (element?.finalPrice ?? '0').toString(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          )),
          DataCell(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Color(int.parse(
                        '0xff${element?.orderStatus?.color?.substring(1)}'))),
                child: Center(
                  child: Text(
                    isArabic
                        ? (element?.orderStatus?.nameAr ?? '')
                        : (element?.orderStatus?.nameEn ?? ''),
                    style: AppFonts.apptextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.spMin),
                  ),
                ),
              )
            ],
          )),
          DataCell(AppButton(
            title: LocaleKeys.details.tr(),
            borderRadius: 8.r,
            onPress: () {
              context.router
                  .push(OrderDetailsRoute(orderId: element?.id ?? ''));
            },
          )),
        ]);
      }).toList(),
    );
  }
}
*/
class VendorOrders extends StatelessWidget {
  const VendorOrders({super.key, required this.orders});
  final List<OrderModel?> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          LocaleKeys.noOrders.tr(),
          style: AppFonts.apptextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryFontColor,
          ),
        ),
      );
    }

    // ✅ موبايل: Card list
    if (context.isMobile) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        separatorBuilder: (_, __) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.id.tr()}: ${order?.id?.substring(0, 6) ?? ''}'),
                  SizedBox(height: 6),
                  Text('${LocaleKeys.productName.tr()}: ${isArabic ? order?.orderProducts?.first?.product?.name ?? '' : order?.orderProducts?.first?.product?.nameEn ?? ''}'),
                  SizedBox(height: 6),
                  Text('${LocaleKeys.clientName.tr()}: ${order?.user?.firstName ?? ''} ${order?.user?.lastName ?? ''}'),
                  SizedBox(height: 6),
                  Text('${LocaleKeys.price.tr()}: ${order?.finalPrice ?? '0'}'),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(int.parse('0xff${order?.orderStatus?.color?.substring(1)}')),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      isArabic ? order?.orderStatus?.nameAr ?? '' : order?.orderStatus?.nameEn ?? '',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppButton(
                      title: LocaleKeys.details.tr(),
                      borderRadius: 8.r,
                      onPress: () {
                        context.router.push(OrderDetailsRoute(orderId: order?.id ?? ''));
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    // ✅ تابلت + ويب: جدول DataTable2
    return DataTable2(
      dividerThickness: 0,
      columnSpacing: 16,
      minWidth: 900,
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
            fixedWidth: 250),
        DataColumn2(
            label: Text(LocaleKeys.clientName.tr(),
                style: AppFonts.apptextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryFontColor)),
            size: ColumnSize.L,
            fixedWidth: 300),
        DataColumn2(
          label: Text(LocaleKeys.price.tr(),
              style: AppFonts.apptextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryFontColor)),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(LocaleKeys.status.tr(),
              style: AppFonts.apptextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryFontColor)),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(''),
          size: ColumnSize.S,
        ),
      ],
      rows: orders.map((element) {
        return DataRow2(cells: [
          DataCell(Text(element?.id?.substring(0, 6) ?? '')),
          DataCell(Text(isArabic
              ? (element?.orderProducts?.first?.product?.name ?? '')
              : (element?.orderProducts?.first?.product?.nameEn ?? ''))),
          DataCell(Text('${element?.user?.firstName ?? ''} ${element?.user?.lastName ?? ''}')),
          DataCell(Text((element?.finalPrice ?? '0').toString())),
          DataCell(Container(
            margin: EdgeInsets.only(bottom: 6 ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical:6),
            decoration: BoxDecoration(
              color: Color(int.parse('0xff${element?.orderStatus?.color?.substring(1)}')),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                isArabic ? (element?.orderStatus?.nameAr ?? '') : (element?.orderStatus?.nameEn ?? ''),
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )),
          DataCell(AppButton(
            title: LocaleKeys.details.tr(),
            borderRadius: 8.r,
            onPress: () {
              context.router.push(OrderDetailsRoute(orderId: element?.id ?? ''));
            },
          )),
        ]);
      }).toList(),
    );
  }
}
