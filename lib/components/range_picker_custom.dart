// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';
// import 'package:sislimoda_admin_dashboard/model/day_custom.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
//
// class RangePickerCustom extends StatefulWidget {
//   final Function onDateSelect;
//   RangePickerCustom(
//       {Key? key,
//       required this.onDateSelect,})
//       : super(key: key);
//
//   @override
//   _RangePickerCustomState createState() => _RangePickerCustomState();
// }
//
// class _RangePickerCustomState extends State<RangePickerCustom> {
//   @override
//   Widget build(BuildContext context) {
//     return SfDateRangePicker(
//       todayHighlightColor: Colors.white,
//       toggleDaySelection: true,
//       selectionMode: DateRangePickerSelectionMode.single,
//       navigationMode: DateRangePickerNavigationMode.snap,
//       headerHeight: 45.h,
//       headerStyle: DateRangePickerHeaderStyle(
//           textAlign: TextAlign.start,
//           backgroundColor: Colors.transparent,
//           textStyle: TextStyle(
//               color: Colors.white,
//               fontFamily: AppFonts.mainfont,
//               fontSize: 15.sp)),
//       view: DateRangePickerView.month,
//       enablePastDates: true,
//       minDate: DateTime.now(),
//       maxDate: DateTime.now().add(Duration(days: 100)),
//       showNavigationArrow: true,
//       allowViewNavigation: false,
//       enableMultiView: false,
//       cellBuilder: (context, cellDetails) {
//         return Container(
//           height: 50,
//           margin: EdgeInsets.all(1.sp),
//           decoration: BoxDecoration(
//             // color: widget.day.any(
//             //   (element) =>
//             //       element.index == cellDetails.date.weekday &&
//             //       cellDetails.date
//             //           .isAfter(DateTime.now().subtract(Duration(days: 1))) &&
//             //       cellDetails.date.isBefore(
//             //         (widget.firstVistExp != null)
//             //             ? DateTime.now()
//             //                 .add(Duration(days: (widget.firstVistExp! + 1)))
//             //             : widget.maxDate!.add(Duration(days: 1)),
//             //       ),
//             // )
//             //     ? Colors.transparent
//             color: cellDetails.date.day==DateTime.now().day?AppColors.secondaryColor:Colors.transparent,
//             borderRadius: BorderRadius.circular(5.r),
//           ),
//           child: Center(
//             child: Center(
//               child: Text(
//                 cellDetails.date.day.toString(),
//                 style: TextStyle(
//                   fontFamily: AppFonts.mainfont,
//                   fontSize: 15.sp,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold
//                   // widget.day.any(
//                   //   (element) =>
//                   //       element.index == cellDetails.date.weekday &&
//                   //       cellDetails.date.isAfter(
//                   //         DateTime.now().subtract(
//                   //           Duration(days: 1),
//                   //         ),
//                   //       ) &&
//                   //       cellDetails.date.isBefore(
//                   //         (widget.firstVistExp != null)
//                   //             ? DateTime.now().add(
//                   //                 Duration(days: (widget.firstVistExp! + 1)))
//                   //             : widget.maxDate!.add(Duration(days: 1)),
//                   //       ),
//                   // )
//                   //     ? Colors.white
//                   //     : Colors.black,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       controller: DateRangePickerController(),
//       selectionShape: DateRangePickerSelectionShape.circle,
//       onSelectionChanged: (DateRangePickerSelectionChangedArgs
//           dateRangePickerSelectionChangedArgs) {
//         widget.onDateSelect(dateRangePickerSelectionChangedArgs);
//       },
//       // selectableDayPredicate: (date) {
//       //   try {
//       //     //////print(widget.day.length);
//       //     if ((!widget.day.any((element) => element.index == date.weekday))) {
//       //       return false;
//       //     } else {
//       //       return true;
//       //     }
//       //   } catch (ex) {
//       //     return false;
//       //   }
//       // },
//     );
//   }
// }
