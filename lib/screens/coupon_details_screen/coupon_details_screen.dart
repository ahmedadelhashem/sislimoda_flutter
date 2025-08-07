/*import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/coupon_details_screen/coupon_details_data.dart';
import 'package:sislimoda_admin_dashboard/screens/products/widgets/product_item.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class CouponDetailsScreen extends StatefulWidget {
  const CouponDetailsScreen({super.key, @pathParam required this.couponId});
  final String couponId;
  @override
  State<CouponDetailsScreen> createState() => _CouponDetailsScreenState();
}

class _CouponDetailsScreenState extends State<CouponDetailsScreen>
    with CouponDetailsData {
  @override
  void initState() {
    // TODO: implement initState
    getCoupon(couponId: widget.couponId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        ctx: context,
      ),
      body: GenericBuilder(
          genericCubit: couponCubit,
          builder: (coupon) {
            return Container(
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
                      if (coupon.isActive == false)
                        SizedBox(
                            height: 40,
                            width: 150,
                            child: AppButton(
                              onPress: () =>
                                  activateCoupon(couponId: coupon.id ?? ''),
                              title: isArabic ? "تفعيل" : "Activate",
                              titleFontSize: 18.sp,
                            )),
                      if (coupon.isActive == true)
                        SizedBox(
                            height: 40,
                            width: 150,
                            child: AppButton(
                              onPress: () =>
                                  deActivateCoupon(couponId: coupon.id ?? ''),
                              title: isArabic ? "تعطيل" : "DeActivate",
                              titleFontSize: 18.sp,
                            ))
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Expanded(
                    child: Screen(
                      loadingCubit: loading,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 30.h),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Expanded(
                                child: ListView(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RowData(
                                  title: LocaleKeys.code.tr(),
                                  desc: coupon.code ?? '',
                                ),
                                RowData(
                                  title: isArabic ? "مفعل" : "Active ",
                                  desc: coupon.isActive.toString() ?? '',
                                ),
                                RowData(
                                  title: LocaleKeys.orders.tr(),
                                  desc: coupon.amount.toString() ?? '',
                                ),
                                RowData(
                                  title: LocaleKeys.discountPercent.tr(),
                                  desc: '${coupon.percent ?? ''} %',
                                ),
                                RowData(
                                  title: isArabic
                                      ? "نسبة المشهور"
                                      : "Influencer Percentage",
                                  desc:
                                      '${coupon.influencerPercentage ?? ''} %',
                                ),
                                RowData(
                                  title: isArabic
                                      ? "نسبة المنصة"
                                      : "System Percentage",
                                  desc:
                                      '${(100 - double.parse(coupon.influencerPercentage ?? '0')) ?? ''} %',
                                ),
                                RowData(
                                  title:
                                      isArabic ? 'تاريخ البداية' : "Start Date",
                                  desc: DateFormat('dd / MM / yyyy').format(
                                      DateFormat('dd-MM-yyyy')
                                          .parse(coupon.startDate ?? '')),
                                ),
                                RowData(
                                  title:
                                      isArabic ? 'تاريخ النهاية' : "End Date",
                                  desc: DateFormat('dd / MM / yyyy').format(
                                      DateFormat('dd-MM-yyyy')
                                          .parse(coupon.endDate ?? '')),
                                ),
                                RowData(
                                  title: LocaleKeys.duration.tr(),
                                  desc:
                                      '${DateFormat('dd-MM-yyyy').parse(coupon.endDate ?? '').difference(DateFormat('dd-MM-yyyy').parse(coupon.startDate ?? '')).inDays} ${LocaleKeys.day.tr()}',
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GenericBuilder(
                                  builder: (influencer) {
                                    return Column(
                                      children: [
                                        RowData(
                                          title: isArabic
                                              ? 'المشهور'
                                              : "Influencer",
                                          desc: influencer.name ?? '',
                                        ),
                                        RowData(
                                          title: LocaleKeys.mobileNumber.tr(),
                                          desc:
                                              influencer.user?.phoneNumer ?? '',
                                        ),
                                        RowData(
                                          title: LocaleKeys.email.tr(),
                                          desc: influencer.user?.email ?? '',
                                        ),
                                        RowData(
                                          title: LocaleKeys.adress.tr(),
                                          desc: influencer.user?.address ?? '',
                                        ),
                                        RowData(
                                          title: LocaleKeys.id.tr(),
                                          desc: influencer.idNumber ?? '',
                                        ),
                                        RowData(
                                          title: isArabic
                                              ? 'رقم البنك'
                                              : "Bank number",
                                          desc: influencer.bankAccountNumber ??
                                              '',
                                        ),
                                        RowData(
                                          title: isArabic
                                              ? 'رقم الواتساب'
                                              : "Whatsapp number",
                                          desc:
                                              influencer.whatsappNumber1 ?? '',
                                        ),
                                        RowData(
                                          title: isArabic
                                              ? 'رقم الواتساب'
                                              : "Max Available Products",
                                          desc:
                                              influencer.numberOfProduct ?? '',
                                        ),
                                      ],
                                    );
                                  },
                                  genericCubit: influencerCubit,
                                )
                              ],
                            )),
                            VerticalDivider(
                              thickness: 2,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: GridView.builder(
                                    itemCount: coupon.couponProducts?.length,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            mainAxisExtent: 400,
                                            crossAxisSpacing: 20,
                                            maxCrossAxisExtent: .2.sw),
                                    itemBuilder: (context, index) {
                                      return ProductItem(
                                          product: coupon.couponProducts?[index]
                                                  ?.product ??
                                              ProductModel(),
                                          delete: () {});
                                    }))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class RowData extends StatelessWidget {
  const RowData({super.key, required this.title, required this.desc});
  final String title, desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '$title :',
                style: AppFonts.apptextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Text(
                '$desc ',
                style: AppFonts.apptextStyle.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}*/

import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/app_bar.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/coupon_details_screen/coupon_details_data.dart';
import 'package:sislimoda_admin_dashboard/screens/products/widgets/product_item.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

@RoutePage()
class CouponDetailsScreen extends StatefulWidget {
  const CouponDetailsScreen({super.key, @pathParam required this.couponId});
  final String couponId;
  @override
  State<CouponDetailsScreen> createState() => _CouponDetailsScreenState();
}

class _CouponDetailsScreenState extends State<CouponDetailsScreen>
    with CouponDetailsData {
  @override
  void initState() {
    getCoupon(couponId: widget.couponId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(ctx: context),
      body: GenericBuilder(
        genericCubit: couponCubit,
        builder: (coupon) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            width: double.infinity,
            height: 1.sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
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
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: .4.sw,
                          child: Text(
                            isArabic
                                ? 'يمكنك إدارة جميع القسائم'
                                : "You can manage all coupons",
                            style: AppFonts.apptextStyle.copyWith(
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    if (coupon.isActive == false)
                      _actionButton(
                        title: isArabic ? "تفعيل" : "Activate",
                        color: Colors.green,
                        onTap: () => activateCoupon(couponId: coupon.id ?? ''),
                      ),
                    if (coupon.isActive == true)
                      _actionButton(
                        title: isArabic ? "تعطيل" : "DeActivate",
                        color: Colors.red,
                        onTap: () => deActivateCoupon(couponId: coupon.id ?? ''),
                      ),
                  ],
                ),
                SizedBox(height: 25.h),
                Expanded(
                  child: Screen(
                    loadingCubit: loading,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Coupon Info
                        Expanded(
                          flex: 2,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.w, vertical: 24.h),
                              child: ListView(
                                children: [
                                  _infoRow(
                                    Icon(Icons.confirmation_number, color: AppColors.mainColor, size: 22),
                                    LocaleKeys.code.tr(),
                                    coupon.code ?? '',
                                  ),
                                  _infoRow(
                                    Icon(Icons.check_circle, color: AppColors.mainColor, size: 22),
                                    isArabic ? "مفعل" : "Active",
                                    coupon.isActive == true ? (isArabic ? "نعم" : "Yes") : (isArabic ? "لا" : "No"),
                                  ),
                                  _infoRow(
                                    Icon(Icons.shopping_cart, color: AppColors.mainColor, size: 22),
                                    LocaleKeys.orders.tr(),
                                    coupon.amount.toString(),
                                  ),
                                  _infoRow(
                                    Icon(Icons.percent, color: AppColors.mainColor, size: 22),
                                    LocaleKeys.discountPercent.tr(),
                                    '${coupon.percent ?? ''} %',
                                  ),
                                  _infoRow(
                                    Icon(Icons.person, color: AppColors.mainColor, size: 22),
                                    isArabic ? "نسبة المشهور" : "Influencer Percentage",
                                    '${coupon.influencerPercentage ?? ''} %',
                                  ),
                                  _infoRow(
                                    Icon(Icons.account_balance, color: AppColors.mainColor, size: 22),
                                    isArabic ? "نسبة المنصة" : "System Percentage",
                                    '${(100 - double.parse(coupon.influencerPercentage ?? '0'))} %',
                                  ),
                                  _infoRow(
                                    Icon(Icons.date_range, color: AppColors.mainColor, size: 22),
                                    isArabic ? 'تاريخ البداية' : "Start Date",
                                    DateFormat('dd / MM / yyyy').format(DateFormat('dd-MM-yyyy').parse(coupon.startDate ?? '')),
                                  ),
                                  _infoRow(
                                    Icon(Icons.date_range, color: AppColors.mainColor, size: 22),
                                    isArabic ? 'تاريخ النهاية' : "End Date",
                                    DateFormat('dd / MM / yyyy').format(DateFormat('dd-MM-yyyy').parse(coupon.endDate ?? '')),
                                  ),
                                  _infoRow(
                                    Icon(Icons.timer, color: AppColors.mainColor, size: 22),
                                    LocaleKeys.duration.tr(),
                                    '${DateFormat('dd-MM-yyyy').parse(coupon.endDate ?? '').difference(DateFormat('dd-MM-yyyy').parse(coupon.startDate ?? '')).inDays} ${LocaleKeys.day.tr()}',
                                  ),
                                  Divider(thickness: 2),
                                  SizedBox(height: 12),
                                  GenericBuilder(
                                    builder: (influencer) {
                                      return Column(
                                        children: [
                                          _infoRow(
                                            Icon(Icons.person, color: AppColors.mainColor, size: 22),
                                            isArabic ? 'المشهور' : "Influencer",
                                            influencer.name ?? '',
                                          ),
                                          _infoRow(
                                            Icon(Icons.phone, color: AppColors.mainColor, size: 22),
                                            LocaleKeys.mobileNumber.tr(),
                                            influencer.user?.phoneNumer ?? '',
                                          ),
                                          _infoRow(
                                            Icon(Icons.email, color: AppColors.mainColor, size: 22),
                                            LocaleKeys.email.tr(),
                                            influencer.user?.email ?? '',
                                          ),
                                          _infoRow(
                                            Icon(Icons.location_on, color: AppColors.mainColor, size: 22),
                                            LocaleKeys.adress.tr(),
                                            influencer.user?.address ?? '',
                                          ),
                                          _infoRow(
                                            Icon(Icons.badge, color: AppColors.mainColor, size: 22),
                                            LocaleKeys.id.tr(),
                                            influencer.idNumber ?? '',
                                          ),
                                          _infoRow(
                                            Icon(Icons.account_balance, color: AppColors.mainColor, size: 22),
                                            isArabic ? 'رقم البنك' : "Bank number",
                                            influencer.bankAccountNumber ?? '',
                                          ),
                                          _infoRow(
                                            ImageIcon(
                                              NetworkImage('https://img.icons8.com/m_outlined/512/whatsapp.png'),
                                              size: 22,
                                              color: AppColors.mainColor,
                                            ),
                                            isArabic ? 'رقم الواتساب' : "Whatsapp number",
                                            influencer.whatsappNumber1 ?? '',
                                          ),
                                          _infoRow(
                                            Icon(Icons.production_quantity_limits, color: AppColors.mainColor, size: 22),
                                            isArabic ? 'الحد الأقصى للمنتجات' : "Max Available Products",
                                            influencer.numberOfProduct ?? '',
                                          ),
                                        ],
                                      );
                                    },
                                    genericCubit: influencerCubit,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(thickness: 2),
                        SizedBox(width: 10),
                        // Products Grid
                        Expanded(
                          flex: 3,
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: GridView.builder(
                                itemCount: coupon.couponProducts?.length ?? 0,
                                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 400,
                                  crossAxisSpacing: 20,
                                  maxCrossAxisExtent: .25.sw,
                                ),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.15),
                                          blurRadius: 8,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    margin: EdgeInsets.all(8),
                                    child: ProductItem(
                                      product: coupon.couponProducts?[index]?.product ?? ProductModel(),
                                      delete: () {},
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _infoRow(Widget icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          icon,
          SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Text(
              '$title:',
              style: AppFonts.apptextStyle.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              desc,
              style: AppFonts.apptextStyle.copyWith(
                color: Colors.black87,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({required String title, required Color color, required VoidCallback onTap}) {
    return SizedBox(
      height: 40,
      width: 150,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(
          title,
          style: AppFonts.apptextStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
 