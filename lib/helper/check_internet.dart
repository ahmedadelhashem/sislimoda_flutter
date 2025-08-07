// import 'package:connectivity/connectivity.dart';
// import 'package:sislimoda_admin_dashboard/components/button/button.dart';
// import 'package:sislimoda_admin_dashboard/routes/routes.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_theme.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// // bool checkInternetIsLoading = true;
// checkInternet() {
//   // connectifiysubscription =
//
//   Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
// }
//
// bool appStatusinternet = false;
// void showConnectivitySnackBar(ConnectivityResult result) async {
//   // final result = await Connectivity().checkConnectivity();
//   final hasInternet = result == ConnectivityResult.none ? false : true;
//   appStatusinternet = hasInternet;
//   if (!hasInternet) {
//     noInternetScreen();
//   } else {
//     checkInternetAction();
//   }
// }
//
// // bool showinternetalert = false;
//
// Future noInternetScreen() async {
//   // showinternetalert = true;
//   return showGeneralDialog(
//     context: Get.context!,
//     barrierColor: Colors.black12.withOpacity(0.6),
//     // Background color
//     barrierDismissible: true,
//     barrierLabel: 'Dialog',
//     transitionDuration: Duration(milliseconds: 100),
//     // How long it takes to popup dialog after button click
//     pageBuilder: (_, __, ___) {
//       // Makes widget fullscreen
//       return SizedBox.expand(
//           child: WillPopScope(
//         onWillPop: () async {
//           return false;
//         },
//         child: Scaffold(
//           body: Container(
//               height: 1.sh,
//               width: 1.sw,
//               color: Colors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: .5.sh,
//                     child: Image.asset(
//                       "AppImage.noInternet",
//                       height: .5.sh,
//                       width: .5.sw,
//                     ),
//                   ),
//                   SizedBox(height: 20.sp),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Button(
//                         onPressed: () {
//                           checkInternetAction();
//                         },
//                         color: AppColors.mainColor,
//                         text: 'لا يوجد اتصال ',
//                       )
//                     ],
//                   ),
//                 ],
//               )),
//         ),
//       ));
//     },
//   );
// }
//
// checkInternetAction() async {
//   FocusScope.of(Get.context!).requestFocus(new FocusNode());
//   final result = await Connectivity().checkConnectivity();
//
//   appStatusinternet = result == ConnectivityResult.none ? false : true;
//   // if (!checkInternetIsLoading) {
//   if (appStatusinternet) goBack();
//   // }
//   //checkInternetIsLoading = false;
// }
