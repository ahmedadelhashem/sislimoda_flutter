//
// import 'package:sislimoda_admin_dashboard/components/button/button.dart';
// import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/image_path.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class NotLoggedinAppbar extends PreferredSize {
//   NotLoggedinAppbar({
//     Key? key,
//     required this.currentPage,
//   }) : super(
//             key: key, child: Container(), preferredSize: Size.fromHeight(60.h));
//   LandingCurrentPage currentPage;
//   @override
//   Widget build(BuildContext context) {
//     return MediaQuery.of(context).size.width < 600
//         ? AppBar(
//           toolbarHeight: 40.h,
//             backgroundColor: AppColors.selectedfontColor,
//             actionsIconTheme: IconThemeData(
//               color: Colors.white,
//               size: 30.w
//             ),
//
//            title: Row(
//             children: [
//                Image.asset(
//                 AppImages.ashtarLogoWhite,
//                 width: 45.w,
//                 height: 36.h,
//               ),
//             ],
//            ),
//           )
//         : Container(
//             padding: EdgeInsets.zero,
//             height: 80.h,
//             color: AppColors.selectedfontColor,
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 80.w,
//                 ),
//                 Image.asset(
//                   AppImages.ashtarLogoWhite,
//                   width: 50.w,
//                   height: 41.h,
//                 ),
//                 SizedBox(
//                   width: 47.w,
//                 ),
//                 SizedBox(
//                   width: 425.w,
//                   height: 39.h,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'الرئيسية',
//                         style: TextStyle(
//                             fontWeight: currentPage == LandingCurrentPage.home
//                                 ? FontWeight.w600
//                                 : FontWeight.w400,
//                             fontSize: 16.spMin,
//                             color: currentPage == LandingCurrentPage.home
//                                 ? Colors.white
//                                 : AppColors.secondaryColor),
//                       ),
//                       Text(
//                         'ذاكر',
//                         style: TextStyle(
//                             fontWeight: currentPage == LandingCurrentPage.zaker
//                                 ? FontWeight.w600
//                                 : FontWeight.w400,
//                             fontSize: 16.spMin,
//                             color: currentPage == LandingCurrentPage.zaker
//                                 ? Colors.white
//                                 : AppColors.secondaryColor),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           currentPage = LandingCurrentPage.ourTeachers;
//                           context.router.navigate(TeacherNotLogin());
//                         },
//                         child: Text(
//                           'مدرسينا',
//                           style: TextStyle(
//                               fontWeight:
//                                   currentPage == LandingCurrentPage.ourTeachers
//                                       ? FontWeight.w600
//                                       : FontWeight.w400,
//                               fontSize: 16.spMin,
//                               color:
//                                   currentPage == LandingCurrentPage.ourTeachers
//                                       ? Colors.white
//                                       : AppColors.secondaryColor),
//                         ),
//                       ),
//                       Text(
//                         'عن أشطر',
//                         style: TextStyle(
//                             fontWeight:
//                                 currentPage == LandingCurrentPage.aboutUs
//                                     ? FontWeight.w600
//                                     : FontWeight.w400,
//                             fontSize: 16.spMin,
//                             color: currentPage == LandingCurrentPage.aboutUs
//                                 ? Colors.white
//                                 : AppColors.secondaryColor),
//                       ),
//                       Text(
//                         'تواصل معنا',
//                         style: TextStyle(
//                             fontWeight:
//                                 currentPage == LandingCurrentPage.contactUs
//                                     ? FontWeight.w600
//                                     : FontWeight.w400,
//                             fontSize: 16.spMin,
//                             color: currentPage == LandingCurrentPage.contactUs
//                                 ? Colors.white
//                                 : AppColors.secondaryColor),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacer(),
//                 SizedBox(
//                   height: 40.h,
//                   child: AppButton(
//                     backgroundColor: Colors.white,
//                     borderRadius: 8.r,
//                     title: 'تسجيل الدخول',
//                     titleFontColor: AppColors.selectedfontColor,
//                     fontWeight: FontWeight.w600,
//                     titleFontSize: 16.spMin,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 80.w,
//                 )
//               ],
//             ),
//           );
//   }
// }
//
// enum LandingCurrentPage { home, zaker, ourTeachers, aboutUs, contactUs }