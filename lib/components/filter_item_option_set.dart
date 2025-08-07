// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sislimoda_admin_dashboard/model/option_set_model.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
//
// class FilterItemOptionSet extends StatelessWidget {
//   const FilterItemOptionSet({Key? key, required this.data, required this.isSelected, required this.onSelect}) : super(key: key);
//   final OptionSetModelOptionSetItems data;
//   final bool isSelected;
//   final Function onSelect;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onSelect(data);
//       },
//       child: Container(
//         margin: EdgeInsets.only(
//             left: isArabic ? 5.w : 0, right: isArabic ? 0.w : 5.w, top: 10.h),
//         decoration: BoxDecoration(
//             color:
//             isSelected ? AppColors.secondaryColor : const Color(0xffF7F7FA),
//             borderRadius: BorderRadius.circular(10.r)),
//         padding:
//         EdgeInsets.only(top: 10.h, bottom: 7.h, right: 20.w, left: 20.w),
//         child: Center(
//             child: Text(
//               isArabic?data.nameAr.toString():data.nameEn.toString(),
//               style: TextStyle(
//                   fontFamily: AppFonts.mainfont,
//                   color: isSelected ? Colors.white : const Color(0xff8A8AA5),
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.bold),
//             )),
//       ),
//     );
//   }
// }
