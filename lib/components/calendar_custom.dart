// import 'package:flutter/material.dart';
// import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
//
// class CalendarCustom extends StatelessWidget {
//   const CalendarCustom(
//       {Key? key,
//       required this.selectedDate,
//       this.isMonday = false,
//       this.isTuesday = false,
//       this.isWednesday = false,
//       this.isThursday = false,
//       this.isFriday = false,
//       this.isSaturday = false,
//       this.isSunday = false,
//       required this.selectDate})
//       : super(key: key);
//   final DateTime selectedDate;
//   final bool isMonday,
//       isTuesday,
//       isWednesday,
//       isThursday,
//       isFriday,
//       isSaturday,
//       isSunday;
//   final Function selectDate;
//   @override
//   Widget build(BuildContext context) {
//     return Calendar(
//       startOnMonday: false,
//
//       bottomBarColor: Colors.transparent,
//       dayBuilder: (context, time) {
//         return Container(
//           height: 100,
//           margin: EdgeInsets.only(right: 9.w, left: 9.w),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(7.r),
//               // color:AppColors.secondaryColor.withOpacity(.5)
//               color: (DateTime.now().year == selectedDate.year &&
//                       DateTime.now().day == selectedDate.day &&
//                       selectedDate.year == time.year &&
//                       selectedDate.day == time.day)
//                   ? AppColors.secondaryColor
//                   : (selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white.withOpacity(.1)
//                       : Colors.transparent),
//           child: Center(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 time.day.toString(),
//                 style: TextStyle(
//                     fontSize: 13.sp,
//                     color: (DateTime.now().year == selectedDate.year &&
//                             DateTime.now().day == selectedDate.day &&
//                             selectedDate.year == time.year &&
//                             selectedDate.day == time.day)
//                         ? Colors.white
//                         : (DateTime.now().year == time.year &&
//                                 DateTime.now().day == time.day)
//                             ? AppColors.secondaryColor
//                             : (selectedDate.year == time.year &&
//                                     selectedDate.day == time.day)
//                                 ? Colors.white
//                                 : Colors.white.withOpacity(.6)),
//               ),
//               SizedBox(
//                 height: 3.h,
//               ),
//               if (time.weekday == 1 && isMonday)
//                 CircleAvatar(
//                   radius: 3,
//                   backgroundColor: (DateTime.now().year == selectedDate.year &&
//                           DateTime.now().day == selectedDate.day &&
//                           selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white
//                       : (DateTime.now().year == time.year &&
//                               DateTime.now().day == time.day)
//                           ? AppColors.secondaryColor
//                           : (selectedDate.year == time.year &&
//                                   selectedDate.day == time.day)
//                               ? Colors.white
//                               : Colors.white.withOpacity(.6),
//                 ),
//               if (time.weekday == 2 && isTuesday)
//                 CircleAvatar(
//                   radius: 3,
//                   backgroundColor: (DateTime.now().year == selectedDate.year &&
//                           DateTime.now().day == selectedDate.day &&
//                           selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white
//                       : (DateTime.now().year == time.year &&
//                               DateTime.now().day == time.day)
//                           ? AppColors.secondaryColor
//                           : (selectedDate.year == time.year &&
//                                   selectedDate.day == time.day)
//                               ? Colors.white
//                               : Colors.white.withOpacity(.6),
//                 ),
//               if (time.weekday == 3 && isWednesday)
//                 CircleAvatar(
//                   radius: 3,
//                   backgroundColor: (DateTime.now().year == selectedDate.year &&
//                           DateTime.now().day == selectedDate.day &&
//                           selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white
//                       : (DateTime.now().year == time.year &&
//                               DateTime.now().day == time.day)
//                           ? AppColors.secondaryColor
//                           : (selectedDate.year == time.year &&
//                                   selectedDate.day == time.day)
//                               ? Colors.white
//                               : Colors.white.withOpacity(.6),
//                 ),
//               if (time.weekday == 4 && isThursday)
//                 CircleAvatar(
//                   radius: 3,
//                   backgroundColor: (DateTime.now().year == selectedDate.year &&
//                           DateTime.now().day == selectedDate.day &&
//                           selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white
//                       : (DateTime.now().year == time.year &&
//                               DateTime.now().day == time.day)
//                           ? AppColors.secondaryColor
//                           : (selectedDate.year == time.year &&
//                                   selectedDate.day == time.day)
//                               ? Colors.white
//                               : Colors.white.withOpacity(.6),
//                 ),
//               if (time.weekday == 5 && isFriday)
//                 CircleAvatar(
//                   radius: 3,
//                   backgroundColor: (DateTime.now().year == selectedDate.year &&
//                           DateTime.now().day == selectedDate.day &&
//                           selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white
//                       : (DateTime.now().year == time.year &&
//                               DateTime.now().day == time.day)
//                           ? AppColors.secondaryColor
//                           : (selectedDate.year == time.year &&
//                                   selectedDate.day == time.day)
//                               ? Colors.white
//                               : Colors.white.withOpacity(.6),
//                 ),
//               if (time.weekday == 6 && isSaturday)
//                 CircleAvatar(
//                   radius: 3,
//                   backgroundColor: (DateTime.now().year == selectedDate.year &&
//                           DateTime.now().day == selectedDate.day &&
//                           selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white
//                       : (DateTime.now().year == time.year &&
//                               DateTime.now().day == time.day)
//                           ? AppColors.secondaryColor
//                           : (selectedDate.year == time.year &&
//                                   selectedDate.day == time.day)
//                               ? Colors.white
//                               : Colors.white.withOpacity(.6),
//                 ),
//               if (time.weekday == 7 && isSunday)
//                 CircleAvatar(
//                   radius: 3,
//                   backgroundColor: (DateTime.now().year == selectedDate.year &&
//                           DateTime.now().day == selectedDate.day &&
//                           selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white
//                       : (DateTime.now().year == time.year &&
//                               DateTime.now().day == time.day)
//                           ? AppColors.secondaryColor
//                           : (selectedDate.year == time.year &&
//                                   selectedDate.day == time.day)
//                               ? Colors.white
//                               : Colors.white.withOpacity(.6),
//                 ),
//               SizedBox(
//                 height: 3.h,
//               ),
//             ],
//           )),
//         );
//       },
//
//       // weekDays:  isArabic?['الأثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعه', 'السبت', 'الأحد']:['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
//       // events: {},
//       // eventsList: [
//       //   NeatCleanCalendarEvent('',
//       //       startTime: DateTime.now().add(Duration(days: 2)),
//       //       endTime: DateTime.now().add(Duration(hours: 50))),
//       //   NeatCleanCalendarEvent('',
//       //       startTime: DateTime.now(),
//       //       endTime: DateTime.now().add(Duration(hours: 2)))
//       // ],
//       onEventSelected: (onEventSelected) {
//         //////print(onEventSelected.toString());
//       },
//       bottomBarArrowColor: Colors.white,
//       bottomBarTextStyle: TextStyle(
//         fontFamily: AppFonts.mainfont,
//         color: Colors.white,
//         fontSize: 15.sp,
//       ),
//
//       onDateSelected: (value) {
//         selectDate(value);
//         // //////print(pickedDate.toString());
//       },
//
//       defaultOutOfMonthDayColor: Colors.blueGrey,
//       defaultDayColor: Colors.white,
//       hideTodayIcon: true,
//
//       isExpandable: true,
//       eventListBuilder: (BuildContext context,
//           List<NeatCleanCalendarEvent> _selectesdEvents) {
//         return Container();
//       },
//       // dayBuilder: (a,b){
//       //   return Container(child: Center(child: Text(b.day.toString())),);
//       // },
//       displayMonthTextStyle: TextStyle(
//         color: Colors.white,
//         fontFamily: AppFonts.mainfont,
//         fontSize: 16.sp,
//       ),
//
//       eventColor: Colors.white,
//       locale: isArabic ? 'ar' : 'en',
//       todayColor: Colors.white,
//       selectedTodayColor: Colors.amberAccent,
//       dayOfWeekStyle: TextStyle(
//           color: Colors.white,
//           fontFamily: AppFonts.mainfont,
//           fontWeight: FontWeight.bold,
//           fontSize: 15.sp),
//     );
//   }
// }
//
// class CalendarCustomWithEvents extends StatelessWidget {
//   const CalendarCustomWithEvents(
//       {Key? key, required this.selectedDate, required this.selectDate})
//       : super(key: key);
//   final DateTime selectedDate;
//
//   final Function selectDate;
//   @override
//   Widget build(BuildContext context) {
//     return Calendar(
//       startOnMonday: false,
//       bottomBarColor: Colors.transparent,
//       dayBuilder: (context, time) {
//         //////print(time);
//         return Container(
//           height: 100.h,
//           margin: EdgeInsets.only(right: 9.w, left: 9.w),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(7.r),
//               // color:AppColors.secondaryColor.withOpacity(.5)
//
//               color: (DateTime.now().year == selectedDate.year &&
//                       DateTime.now().day == selectedDate.day &&
//                       selectedDate.year == time.year &&
//                       selectedDate.day == time.day)
//                   ? AppColors.secondaryColor
//                   : (selectedDate.year == time.year &&
//                           selectedDate.day == time.day)
//                       ? Colors.white.withOpacity(.1)
//                       : Colors.transparent),
//           child: Center(
//               child: Text(
//             time.day.toString(),
//             style: TextStyle(
//                 fontSize: 13.sp,
//                 color: (DateTime.now().year == selectedDate.year &&
//                         DateTime.now().day == selectedDate.day &&
//                         selectedDate.year == time.year &&
//                         selectedDate.day == time.day)
//                     ? Colors.white
//                     : (DateTime.now().year == time.year &&
//                             DateTime.now().day == time.day)
//                         ? AppColors.secondaryColor
//                         : (selectedDate.year == time.year &&
//                                 selectedDate.day == time.day)
//                             ? Colors.white
//                             : Colors.white.withOpacity(.6)),
//           )),
//         );
//       },
//
//       // weekDays:  isArabic?['الأثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعه', 'السبت', 'الأحد']:['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'],
//       // events: {},
//       eventsList: [
//         NeatCleanCalendarEvent('',
//             startTime: DateTime.now().add(Duration(days: 2)),
//             endTime: DateTime.now().add(Duration(hours: 50))),
//         NeatCleanCalendarEvent('',
//             startTime: DateTime.now(),
//             endTime: DateTime.now().add(Duration(hours: 2)))
//       ],
//       onEventSelected: (onEventSelected) {
//         //////print(onEventSelected.toString());
//       },
//       bottomBarArrowColor: AppColors.greyColor,
//       bottomBarTextStyle: TextStyle(
//         fontFamily: AppFonts.mainfont,
//         color: Colors.white,
//         fontSize: 15.sp,
//       ),
//
//       onDateSelected: (value) {
//         selectDate(value);
//         // //////print(pickedDate.toString());
//       },
//
//       defaultOutOfMonthDayColor: Colors.blueGrey,
//       defaultDayColor: Colors.grey,
//       hideTodayIcon: true,
//
//       isExpandable: true,
//       eventListBuilder: (BuildContext context,
//           List<NeatCleanCalendarEvent> _selectesdEvents) {
//         return Container();
//       },
//       // dayBuilder: (a,b){
//       //   return Container(child: Center(child: Text(b.day.toString())),);
//       // },
//       displayMonthTextStyle: TextStyle(
//         color: Colors.white,
//         fontFamily: AppFonts.mainfont,
//         fontSize: 16.sp,
//       ),
//
//       eventColor: Colors.white,
//       locale: isArabic ? 'ar' : 'en',
//       dayOfWeekStyle: TextStyle(
//           color: Colors.white,
//           fontFamily: AppFonts.mainfont,
//           fontWeight: FontWeight.bold,
//           fontSize: 15.sp),
//     );
//   }
// }
