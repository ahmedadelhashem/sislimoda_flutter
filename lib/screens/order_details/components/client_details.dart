import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class ClientDetails extends StatelessWidget {
  const ClientDetails({super.key, this.order});
  final OrderModel? order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.clientDetails.tr(),
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
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LocaleKeys.name.tr()}  :  ',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.secondaryFontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text:
                          '${order?.user?.firstName ?? ''} ${order?.user?.lastName ?? ''}',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LocaleKeys.mobileNumber.tr()}  :  ',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.secondaryFontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: order?.user?.phoneNumer ?? '',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LocaleKeys.adress.tr()}  :  ',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.secondaryFontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: order?.address ?? '',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LocaleKeys.email.tr()}  :  ',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.secondaryFontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: order?.user?.email ?? '',
                      style: AppFonts.apptextStyle.copyWith(
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
