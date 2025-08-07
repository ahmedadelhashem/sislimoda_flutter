// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
//
// class SideEffects extends StatelessWidget {
//   const SideEffects({super.key, required this.sideEffects});
//   final List<ProductModelSideEffects?> sideEffects;
//   @override
//   Widget build(BuildContext context) {
//     return sideEffects.isEmpty
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
//                     'الأعراض الجانبية',
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
//                     sideEffects.length,
//                     (index) => Text(
//                           '${index + 1} - ${sideEffects[index]?.AR ?? ''}',
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
