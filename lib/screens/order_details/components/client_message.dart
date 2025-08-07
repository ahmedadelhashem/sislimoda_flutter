import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

import '../../../models/orders/get_order_pagination_model.dart';

class ClientMessage extends StatelessWidget {
  const ClientMessage({super.key, required this.order});
  final OrderModel? order;

  @override
  Widget build(BuildContext context) {
    return true?SizedBox():Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.clientMessage.tr(),
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
          child: Text(
            '',
            style: AppFonts.apptextStyle.copyWith(
                color: AppColors.secondaryFontColor,
                fontWeight: FontWeight.w400,
                fontSize: 16),
          ),
        )
      ],
    );
  }
}
