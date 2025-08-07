import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.order, this.getVendorNameById});
  final OrderModel? order;
  final String? Function(String?)? getVendorNameById;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  double totalOrderValueForVendor = 0;
  @override
  void initState() {
    // TODO: implement initState
    widget.order?.orderProducts?.forEach((element) {
      totalOrderValueForVendor = totalOrderValueForVendor +
          double.parse(element?.product?.defaultPrice ?? '0');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.orderDetails.tr(),
          style: AppFonts.apptextStyle.copyWith(
              fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22)),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${LocaleKeys.id.tr()} ',
                                style: AppFonts.apptextStyle.copyWith(
                                    color: AppColors.secondaryFontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              TextSpan(
                                text: '#${widget.order?.orderNumber}',
                                style: AppFonts.apptextStyle.copyWith(
                                    color: AppColors.secondaryFontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text: '',
                        //         style: AppFonts.apptextStyle.copyWith(
                        //             color: AppColors.secondaryFontColor
                        //                 .withOpacity(.5),
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w400),
                        //       ),
                        //       TextSpan(text: ' - '),
                        //       TextSpan(
                        //         text: (order?.createdAt ?? '').getDateFormated,
                        //         style: AppFonts.apptextStyle.copyWith(
                        //             color: AppColors.secondaryFontColor
                        //                 .withOpacity(.5),
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w400),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Color(int.parse(
                            '0xff${widget.order?.orderStatus?.color?.substring(1)}'))),
                    child: Center(
                      child: Text(
                        isArabic
                            ? (widget.order?.orderStatus?.nameAr ?? '')
                            : (widget.order?.orderStatus?.nameEn ?? ''),
                        style: AppFonts.apptextStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.spMin),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LocaleKeys.products.tr()}  ',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: '(${widget.order?.orderProducts?.length})',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.secondaryFontColor.withOpacity(.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.order!.orderProducts!.map((e) {
                  return Container(
                    width: .7.sw,
                    height: 100,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 64.w,
                          height: 140.h,
                          child: CustomNetworkImage(
                              width: 64.w,
                              height: 140.h,
                              link: e?.product?.defaultPhoto?.fullLink != null
                                  ? (e?.product?.defaultPhoto?.fullLink ?? '')
                                  : ''),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 170.w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        isArabic
                                            ? (e?.product?.description ?? '')
                                            : (e?.product?.descriptionEn ?? ''),
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.spMin),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffF4F3FF),
                                    borderRadius: BorderRadius.circular(3)),
                                padding: EdgeInsets.only(
                                    left: 12, right: 12.w, top: 1, bottom: 1),
                                child: Text(
                                  isArabic
                                      ? (e?.product?.name ?? '')
                                      : (e?.product?.name ?? ''),
                                  textAlign: TextAlign.justify,
                                  maxLines: 2,
                                  style: AppFonts.apptextStyle.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13.spMin),
                                ),
                              ),
                              SizedBox(height: 6),
Text(
  'البائع: ${widget.getVendorNameById?.call(e?.product?.vendorId) ?? '---'}',
  style: AppFonts.apptextStyle.copyWith(
    color: AppColors.secondaryFontColor,
    fontWeight: FontWeight.w400,
    fontSize: 12.spMin,
  ),
),

                              Spacer(),
                              SizedBox(
                                width: 170.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${e?.product?.defaultPrice}\$',
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        style: AppFonts.apptextStyle.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18.spMin),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                            ],
                          ),
                        ),
                        // Column(
                        //   children: [Text(e?.product?.vendorId ?? '')],
                        // )
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 8,
              ),
              Text(
                LocaleKeys.orderDetails.tr(),
                style: AppFonts.apptextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              // SizedBox(
              //   height: 8,
              // ),
              // Row(
              //   children: [
              //     Text(
              //       LocaleKeys.subTotal.tr(),
              //       style: AppFonts.apptextStyle.copyWith(
              //           fontSize: 14,
              //           fontWeight: FontWeight.w400,
              //           color: AppColors.secondaryFontColor),
              //     ),
              //     Spacer(),
              //     Text(
              //       '${order?.subtotal ?? ''} ج.م',
              //       style: AppFonts.apptextStyle.copyWith(
              //           fontSize: 14,
              //           fontWeight: FontWeight.w400,
              //           color: AppColors.secondaryFontColor),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Text(
                    LocaleKeys.totalPrice.tr(),
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  ),
                  Spacer(),
                  Text(
                    totalOrderValueForVendor.toStringAsFixed(2),
                    style: AppFonts.apptextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryFontColor),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
