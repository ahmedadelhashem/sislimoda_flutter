// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shimmer/shimmer.dart';
//
//
// class SliderButton extends StatefulWidget {
//   const SliderButton(
//       {Key? key,
//       required this.text,
//       required this.onSlide,
//       required this.backgroundColor,
//       required this.istoStart})
//       : super(key: key);
//   final String text;
//   final Function onSlide;
//   final Color backgroundColor;
//   final bool istoStart;
//   @override
//   State<SliderButton> createState() => _SliderButtonState();
// }
//
// class _SliderButtonState extends State<SliderButton> {
//   @override
//   Widget build(BuildContext context) {
//     return isArabic
//         ? Container(
//             width: .8.sw,
//             height: 40.h,
//             decoration: BoxDecoration(
//               color: AppColors.secondaryColor.withOpacity(.1),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             child: Stack(
//               alignment: widget.istoStart
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   child: Text(widget.text,
//                       style: TextStyle(
//                           fontSize: 12.sp,
//                           color: AppColors.secondaryColor,
//                           fontFamily: AppFonts.mainfont,
//                           fontWeight: FontWeight.w500)),
//                 ),
//                 Dismissible(
//                   confirmDismiss: (_) async {
//                     widget.onSlide();
//                     return false;
//                   },
//                   key: UniqueKey(),
//                   // dismissThresholds: {DismissDirection.startToEnd: .75},
//                   direction: widget.istoStart
//                       ? DismissDirection.startToEnd
//                       : DismissDirection.endToStart,
//                   onDismissed: (value) {},
//                   child: Container(
//                     width: .8.sw - 61.w,
//                     height: 40.h,
//                     alignment: widget.istoStart
//                         ? Alignment.centerRight
//                         : Alignment.centerLeft,
//                     child: Container(
//                       width: 50.w,
//                       height: 50.h,
//                       margin: EdgeInsets.all(5.sp),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.r),
//                         color: AppColors.secondaryColor,
//                       ),
//                       child: Center(
//                         child: Transform(
//                             alignment: Alignment.center,
//                             transform: widget.istoStart
//                                 ? Matrix4.rotationY(pi)
//                                 : Matrix4.rotationY(0),
//                             child: SvgPicture.asset(
//                               AppImages.arrow,
//                               width: 15.w,
//                               fit: BoxFit.fitWidth,
//                               color: Colors.white,
//                             )),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         : Container(
//             width: .8.sw,
//             height: 40.h,
//             decoration: BoxDecoration(
//               color: AppColors.secondaryColor.withOpacity(.1),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             child: Stack(
//               alignment: !widget.istoStart
//                   ? Alignment.centerRight
//                   : Alignment.centerLeft,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//                   child: Text(widget.text,
//                       style: TextStyle(
//                           fontSize: 12.sp,
//                           color: AppColors.secondaryColor,
//                           fontFamily: AppFonts.mainfont,
//                           fontWeight: FontWeight.w500)),
//                 ),
//                 Dismissible(
//                   confirmDismiss: (_) async {
//                     widget.onSlide();
//                     return false;
//                   },
//                   key: UniqueKey(),
//                   // dismissThresholds: {DismissDirection.startToEnd: .75},
//                   direction: widget.istoStart
//                       ? DismissDirection.startToEnd
//                       : DismissDirection.endToStart,
//                   onDismissed: (value) {},
//                   child: Container(
//                     width: .8.sw - 61.w,
//                     height: 40.h,
//                     alignment: !widget.istoStart
//                         ? Alignment.centerRight
//                         : Alignment.centerLeft,
//                     child: Container(
//                       width: 50.w,
//                       height: 50.h,
//                       margin: EdgeInsets.all(5.sp),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.r),
//                         color: AppColors.secondaryColor,
//                       ),
//                       child: Center(
//                         child: Transform(
//                             alignment: Alignment.center,
//                             transform: !widget.istoStart
//                                 ? Matrix4.rotationY(pi)
//                                 : Matrix4.rotationY(0),
//                             child: SvgPicture.asset(
//                               AppImages.arrow,
//                               width: 15.w,
//                               fit: BoxFit.fitWidth,
//                               color: Colors.white,
//                             )),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//   }
// }
