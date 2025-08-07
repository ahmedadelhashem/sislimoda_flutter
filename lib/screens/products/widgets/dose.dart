// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
//
// class Dose extends StatelessWidget {
//   const Dose({super.key, required this.doses});
//   final List<ProductModelDose?> doses;
//   @override
//   Widget build(BuildContext context) {
//     return doses.isEmpty
//         ? SizedBox()
//         : Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   // SvgPicture.asset(
//                   //   AppImages.headache,
//                   //   width: 32,
//                   // ),
//                   Text(
//                     'الجرعة',
//                     textAlign: TextAlign.justify,
//                     style: AppFonts.apptextStyle.copyWith(
//                         height: 1.6,
//                         color: AppColors.mainColor,
//                         fontSize: 15.spMin,
//                         fontWeight: FontWeight.w700),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5.h,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: List.generate(
//                     doses.length,
//                     (index) => Text(
//                           '${index + 1} - من عمر ${doses[index]?.startAge ?? ''} إلي عمر ${doses[index]?.endAge ?? ''} : ${isArabic ? (doses[index]?.dose?.AR ?? '') : (doses[index]?.dose?.EN ?? '')}',
//                           style: AppFonts.apptextStyle.copyWith(
//                               height: 1.6,
//                               color: AppColors.secondaryFontColor,
//                               fontSize: 12.spMin,
//                               fontWeight: FontWeight.w700),
//                         )),
//               ),
//             ],
//           );
//   }
// }
