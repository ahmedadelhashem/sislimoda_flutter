import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/models/orders/get_order_pagination_model.dart';

class OrderDeliveringDetails extends StatelessWidget {
  const OrderDeliveringDetails({super.key, required this.order});
  final OrderModel? order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   LocaleKeys.orderDetails.tr(),
        //   style: AppFonts.apptextStyle.copyWith(
        //       fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        // Container(
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //       color: Colors.white, borderRadius: BorderRadius.circular(22)),
        //   padding: EdgeInsets.all(20),
        //   child: EasyStepper(
        //       activeStep: 0,
        //       activeStepTextColor: Colors.black87,
        //       finishedStepTextColor: Colors.black87,
        //       internalPadding: 0,
        //       showLoadingAnimation: false,
        //       stepRadius: 8,
        //       lineStyle: LineStyle(
        //           lineLength: 100,
        //           activeLineColor: AppColors.mainColor,
        //           defaultLineColor: AppColors.secondaryFontColor),
        //       showStepBorder: false,
        //       steps: [
        //         EasyStep(
        //           customStep: CircleAvatar(
        //             radius: 8,
        //             backgroundColor: Colors.white,
        //             child: CircleAvatar(
        //               radius: 7,
        //               backgroundColor: AppColors.mainColor,
        //             ),
        //           ),
        //           customTitle: Text(
        //             LocaleKeys.orderd.tr(),
        //             textAlign: TextAlign.center,
        //             style: AppFonts.apptextStyle.copyWith(
        //                 color: AppColors.secondaryFontColor,
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 12),
        //           ),
        //         ),
        //         EasyStep(
        //           customStep: CircleAvatar(
        //             radius: 8,
        //             backgroundColor: Colors.white,
        //             child: CircleAvatar(
        //                 radius: 7,
        //                 backgroundColor: (order?.status == 'onway' ||
        //                         order?.status == 'delivered')
        //                     ? AppColors.mainColor
        //                     : AppColors.secondaryFontColor),
        //           ),
        //           customTitle: Text(
        //             LocaleKeys.delivering.tr(),
        //             textAlign: TextAlign.center,
        //             style: AppFonts.apptextStyle.copyWith(
        //                 color: AppColors.secondaryFontColor,
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 12),
        //           ),
        //           topTitle: true,
        //         ),
        //         EasyStep(
        //           customStep: CircleAvatar(
        //             radius: 8,
        //             backgroundColor: Colors.white,
        //             child: CircleAvatar(
        //                 radius: 7,
        //                 backgroundColor: (order?.status == 'delivered')
        //                     ? AppColors.mainColor
        //                     : AppColors.secondaryFontColor),
        //           ),
        //           customTitle: Text(
        //             LocaleKeys.delivered.tr(),
        //             textAlign: TextAlign.center,
        //             style: AppFonts.apptextStyle.copyWith(
        //                 color: AppColors.secondaryFontColor,
        //                 fontWeight: FontWeight.w600,
        //                 fontSize: 12),
        //           ),
        //           topTitle: false,
        //         ),
        //       ],
        //       onStepReached: (index) {}),
        // )
      ],
    );
  }
}
