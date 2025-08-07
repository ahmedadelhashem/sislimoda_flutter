import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class IndicationForUse extends StatelessWidget {
  const IndicationForUse({super.key, required this.indicationsForuse});
  final List<ProductDetails?> indicationsForuse;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                indicationsForuse.length,
                (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${index + 1} - ${indicationsForuse[index]?.key ?? ''} :${indicationsForuse[index]?.value ?? ''}',
                          style: AppFonts.apptextStyle.copyWith(
                              height: 1.6,
                              color: AppColors.secondaryFontColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          '${index + 1} - ${indicationsForuse[index]?.keyEn ?? ''} :${indicationsForuse[index]?.valueEn ?? ''}',
                          style: AppFonts.apptextStyle.copyWith(
                              height: 1.6,
                              color: AppColors.secondaryFontColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
          ),
        ],
      ),
    );
  }
}
