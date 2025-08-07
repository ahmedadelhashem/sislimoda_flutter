// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:sislimoda_admin_dashboard/components/Text/text_custom.dart';
// import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
// import 'package:sislimoda_admin_dashboard/utility/all_app_words.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
//
// class DatePickerCustom extends StatelessWidget {
//   const DatePickerCustom(
//       {Key? key,
//       required this.pickDate,
//       required this.date,
//       required this.title})
//       : super(key: key);
//   final Function pickDate;
//   final String date;
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         // _pickDateDialog();
//         DateTime? selectedTime = await showDatePicker(
//             context: context,
//             locale: Locale(isArabic ? 'ar' : 'en'),
//             initialDate: DateTime.now(),
//             firstDate: DateTime.now(),
//             lastDate: DateTime.now().add(Duration(days: 50)));
//         if (selectedTime != null) {
//           var formatter = DateFormat('dd-MM-yyyy');
//           String formatted =
//               formatter.format(selectedTime).arabicNumberToEnglish;
//           pickDate(selectedTime);
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.only(top: 15.sp, right: 15.sp, left: 15.sp),
//         decoration: BoxDecoration(
//             color: AppColors.unselectedColor,
//             borderRadius: BorderRadius.circular(15.sp)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TxtN(
//               text: title,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.w500,
//               color: AppColors.mainColor,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TxtN(
//                     text: date,
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.black,
//                     height: 2,
//                   ),
//                 ),
//                 Icon(
//                   Icons.calendar_month,
//                   color: Colors.grey,
//                   size: 25.sp,
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 5.h,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class TimePickerCustom extends StatelessWidget {
//   const TimePickerCustom(
//       {Key? key,
//       required this.pickTime,
//       required this.time,
//       required this.title})
//       : super(key: key);
//
//   final Function pickTime;
//   final String time;
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         // _pickDateDialog();
//         // DateTime? selectedTime = await showDatePicker(
//         //     context: context,
//         //     locale: Locale(isArabic ? 'ar' : 'en'),
//         //     initialDate: DateTime.now(),
//         //     firstDate: DateTime.now(),
//         //     lastDate: DateTime.now().add(Duration(days: 50)));
//         final TimeOfDay? selectedTime = await showTimePicker(
//           context: context,
//           confirmText: AppWords.ok.tr,
//           cancelText: AppWords.cancel.tr,
//           helpText: AppWords.selectTime.tr,
//
//           initialTime: TimeOfDay.now(),
//
//         );
//         //////print(selectedTime);
//         if (selectedTime != null) {
//           pickTime(selectedTime.hour.toString()+':'+selectedTime.minute.toString());
//         }
//       },
//       child: Container(
//         padding: EdgeInsets.only(top: 15.sp, right: 15.sp, left: 15.sp),
//         decoration: BoxDecoration(
//             color:AppColors.unselectedColor,
//             borderRadius: BorderRadius.circular(15.sp)),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TxtN(
//               text: title,
//               fontSize: 14.sp,
//               fontWeight: FontWeight.normal,
//               color: Colors.grey,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TxtN(
//                     text: time,
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.black,
//                     height: 2,
//                   ),
//                 ),
//                 SvgPicture.asset('assets/images/clock.svg',width: 20.w,color: Color(0xffC4C4D2),)
//               ],
//             ),
//             SizedBox(
//               height: 5.h,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
