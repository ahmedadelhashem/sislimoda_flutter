import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});
  final OrderModel? order;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.router.push(OrderDetailsRoute(orderId: order?.Id ?? ''));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'طلب : ${order?.orderNumber ?? '0'}',
                    style: AppFonts.apptextStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.spMin),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: Color(int.parse(
                          '0xff${order?.orderStatus?.color?.substring(1)}'))),
                  child: Text(
                    isArabic
                        ? (order?.orderStatus?.nameAr ?? '')
                        : (order?.orderStatus?.nameEn ?? ''),
                    style: AppFonts.apptextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.spMin),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order!.orderProducts!
                  .map(
                    (e) => Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      child: Text(
                        isArabic
                            ? (e?.product?.name ?? '')
                            : (e?.product?.nameEn ?? ''),
                        style: AppFonts.apptextStyle.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.spMin),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 16.h,
            ),
            Divider(),
            SizedBox(
              height: 16.h,
            ),
            // Row(
            //   children: [
            //     Text(
            //       'تاريخ إنشاء الطلب :',
            //       style: AppFonts.apptextStyle.copyWith(
            //           color: AppColors.secondaryFontColor,
            //           fontWeight: FontWeight.w400,
            //           fontSize: 14.spMin),
            //     ),
            //     SizedBox(
            //       width: 5.w,
            //     ),
            //     Text(
            //       (order?.create ?? '').getDateFormated,
            //       style: AppFonts.apptextStyle.copyWith(
            //           color: Colors.black,
            //           fontWeight: FontWeight.w700,
            //           fontSize: 14.spMin),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                Text(
                  'عدد المنتجات :',
                  style: AppFonts.apptextStyle.copyWith(
                      color: AppColors.secondaryFontColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.spMin),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  order!.orderProducts!.length.toString(),
                  style: AppFonts.apptextStyle.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.spMin),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
