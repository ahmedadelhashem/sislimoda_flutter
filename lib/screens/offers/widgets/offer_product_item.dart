import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class OfferProductItem extends StatefulWidget {
  const OfferProductItem({super.key, required this.product});
  final ProductModel? product;
  @override
  State<OfferProductItem> createState() => _OfferProductItemState();
}

class _OfferProductItemState extends State<OfferProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 224.h,
      width: 170,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          Container(
            height: 129.h,
            padding: EdgeInsets.only(left: 11.w, right: 11.w),
            width: double.infinity,
            decoration: BoxDecoration(
              image: widget.product!.defaultPhoto==null
                  ? DecorationImage(image: AssetImage(AppImages.logo))
                  : DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        AppSetting.serviceURL +
                            (widget.product?.defaultPhoto?.fullLink ?? ''),
                      )),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Color(0xffECFDF3)),
                      child: Text(
                        '${LocaleKeys.discount.tr()} ${widget.product?.discountPercentage ?? ''} %',
                        style: AppFonts.apptextStyle.copyWith(
                            color: AppColors.mainColor,
                            fontSize: 14.spMin,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 8.w, right: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  isArabic
                      ? (widget.product?.name ?? '')
                      : (widget.product?.nameEn ?? ''),
                  style: AppFonts.apptextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 15.spMin),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Color(0xffF6FEF9),
                      borderRadius: BorderRadius.circular(34)),
                  child: Row(
                    children: [
                      Text(
                        '${widget.product?.productPrice ?? ''} ج.م',
                        style: AppFonts.apptextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 15.spMin),
                      ),
                      Spacer(),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
