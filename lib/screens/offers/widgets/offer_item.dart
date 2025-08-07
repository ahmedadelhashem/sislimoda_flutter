import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/models/offers/get_offers_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/screens/offers/widgets/offer_product_item.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({super.key, required this.offer});
  final OfferModel? offer;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          offer?.title ?? '',
          style: AppFonts.apptextStyle.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 19.spMin),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 224.h,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return OfferProductItem(
                  product: offer?.offersProducts?[index]?.product ?? ProductModel(),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 12.w,
                );
              },
              itemCount: offer?.offersProducts?.length ?? 0),
        )
      ],
    );
  }
}
