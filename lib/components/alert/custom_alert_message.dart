import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class CustomAlert {
  static Future<bool?> showAlertMessage(
      {required String? txt,
      required String alertType,
      Function? onClick}) async {
    return await showDialog(
      barrierDismissible: false,
      context: currentContext,
      builder: (context) {
        return Stack(
          children: [],
        );
      },
    );
  }

  static showConfirmDialogue(
      {required confirmDone,
      required String message,
      required BuildContext context}) {
    showDialog(
      context: currentContext,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 500,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.spMin),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppImages.warning,
                  width: 140,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppFonts.apptextStyle.copyWith(
                    color: AppColors.black,
                    fontSize: 16,
                    height: 1.9,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10.spMin,
                    ),
                    Expanded(
                      child: SizedBox(
                          height: 40,
                          child: AppButton(
                            onPress: () {
                              confirmDone();
                              Navigator.pop(context);
                            },
                            title: LocaleKeys.confirm.tr(),
                            fontWeight: FontWeight.w600,
                            titleFontSize: 15,
                          )),
                    ),
                    SizedBox(
                      width: 10.spMin,
                    ),
                    Expanded(
                      child: SizedBox(
                          height: 40,
                          child: AppButton(
                            onPress: () {
                              Navigator.pop(context);
                            },
                            title: LocaleKeys.cancel.tr(),
                            fontWeight: FontWeight.w600,
                            backgroundColor: Colors.grey,
                            titleFontSize: 15,
                          )),
                    ),
                    SizedBox(
                      width: 10.spMin,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return;
    // showDialog(
    //     context: currentContext,
    //     builder: (context) {
    //       return Container();
    //     });
  }
  //   SimpleDialog(
          //   // insetPadding: EdgeInsets.only(right: .1.sw,left: .1.sw),
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.sp)),
          //
          //   children: [
          //     Container(
          //       //   width: .3.sw,
          //       //  height: .25.sh,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10.sp),
          //         color: Colors.white,
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           SizedBox(
          //             height: 20.h,
          //           ),
          //           Text(
          //             "$title",
          //             style: TextStyle(
          //               color: AppColors.mainColor,
          //               fontSize: 14.sp,
          //               fontFamily: AppFonts.mainfont,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           if (title == "")
          //             Text(
          //               "confirm",
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                   color: AppColors.mainColor,
          //                   fontSize: 14.sp,
          //                   fontFamily: AppFonts.mainfont,
          //                   fontWeight: FontWeight.w600),
          //             ),
          //           Container(
          //             margin: EdgeInsets.all(9.sp),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   message,
          //                   textAlign: TextAlign.center,
          //                   style: TextStyle(
          //                     color: AppColors.secondaryColor,
          //                     fontSize: 14.sp,
          //                     fontFamily: AppFonts.mainfont,
          //                     fontWeight: FontWeight.w300,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //               Expanded(
          //                   child: Button(
          //                 text: "ok",
          //                 color: AppColors.mainColor,
          //                 fontSize: 10.sp,
          //                 height: 30.h,
          //                 onPressed: () {
          //                   goBack();
          //                   confirmDone();
          //                 },
          //               )),
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //               Expanded(
          //                   child: Button(
          //                 text: "cancel",
          //                 color: AppColors.mainColor,
          //                 height: 30.h,
          //                 fontSize: 10.sp,
          //                 onPressed: () {
          //                   goBack();
          //                 },
          //               )),
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 10.h,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
  static showNotificationRequestDialog() async {
    await showDialog(
        context: currentContext,
        builder: (context) {
          return Stack(
            children: [],
          );
          //   SimpleDialog(
          //   // insetPadding: EdgeInsets.only(right: .1.sw,left: .1.sw),
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.sp)),
          //
          //   children: [
          //     Container(
          //       //   width: .3.sw,
          //       //  height: .25.sh,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10.sp),
          //         color: Colors.white,
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           SizedBox(
          //             height: 20.h,
          //           ),
          //           Text(
          //             "$title",
          //             style: TextStyle(
          //               color: AppColors.mainColor,
          //               fontSize: 14.sp,
          //               fontFamily: AppFonts.mainfont,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           if (title == "")
          //             Text(
          //               "confirm",
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                   color: AppColors.mainColor,
          //                   fontSize: 14.sp,
          //                   fontFamily: AppFonts.mainfont,
          //                   fontWeight: FontWeight.w600),
          //             ),
          //           Container(
          //             margin: EdgeInsets.all(9.sp),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   message,
          //                   textAlign: TextAlign.center,
          //                   style: TextStyle(
          //                     color: AppColors.secondaryColor,
          //                     fontSize: 14.sp,
          //                     fontFamily: AppFonts.mainfont,
          //                     fontWeight: FontWeight.w300,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //               Expanded(
          //                   child: Button(
          //                 text: "ok",
          //                 color: AppColors.mainColor,
          //                 fontSize: 10.sp,
          //                 height: 30.h,
          //                 onPressed: () {
          //                   goBack();
          //                   confirmDone();
          //                 },
          //               )),
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //               Expanded(
          //                   child: Button(
          //                 text: "cancel",
          //                 color: AppColors.mainColor,
          //                 height: 30.h,
          //                 fontSize: 10.sp,
          //                 onPressed: () {
          //                   goBack();
          //                 },
          //               )),
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 10.h,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        });
  }

  static helpDialog() {
    showDialog(
        context: currentContext,
        builder: (context) {
          return Stack(
            children: [],
          );
          //   SimpleDialog(
          //   // insetPadding: EdgeInsets.only(right: .1.sw,left: .1.sw),
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10.sp)),
          //
          //   children: [
          //     Container(
          //       //   width: .3.sw,
          //       //  height: .25.sh,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10.sp),
          //         color: Colors.white,
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           SizedBox(
          //             height: 20.h,
          //           ),
          //           Text(
          //             "$title",
          //             style: TextStyle(
          //               color: AppColors.mainColor,
          //               fontSize: 14.sp,
          //               fontFamily: AppFonts.mainfont,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           if (title == "")
          //             Text(
          //               "confirm",
          //               textAlign: TextAlign.center,
          //               style: TextStyle(
          //                   color: AppColors.mainColor,
          //                   fontSize: 14.sp,
          //                   fontFamily: AppFonts.mainfont,
          //                   fontWeight: FontWeight.w600),
          //             ),
          //           Container(
          //             margin: EdgeInsets.all(9.sp),
          //             child: Column(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   message,
          //                   textAlign: TextAlign.center,
          //                   style: TextStyle(
          //                     color: AppColors.secondaryColor,
          //                     fontSize: 14.sp,
          //                     fontFamily: AppFonts.mainfont,
          //                     fontWeight: FontWeight.w300,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: [
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //               Expanded(
          //                   child: Button(
          //                 text: "ok",
          //                 color: AppColors.mainColor,
          //                 fontSize: 10.sp,
          //                 height: 30.h,
          //                 onPressed: () {
          //                   goBack();
          //                   confirmDone();
          //                 },
          //               )),
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //               Expanded(
          //                   child: Button(
          //                 text: "cancel",
          //                 color: AppColors.mainColor,
          //                 height: 30.h,
          //                 fontSize: 10.sp,
          //                 onPressed: () {
          //                   goBack();
          //                 },
          //               )),
          //               SizedBox(
          //                 width: 5.h,
          //               ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 10.h,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        });
  }
}
