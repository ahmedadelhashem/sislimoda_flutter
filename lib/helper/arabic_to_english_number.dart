import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/Text/text_custom.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';
import 'package:sislimoda_admin_dashboard/utility/local_storge_key.dart';

extension T on String {
  String get arabicNumberToEnglish {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var input = this;
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }
    //////print("$input after");
    return input;
  }

  String get getDateFormated {
    DateTime date = DateFormat('yyyy-MM-dd').parse(this);
    return DateFormat('yMMMMd', isArabic ? 'ar' : 'en').format(date);
  }

  String get getTime {
    DateTime date = DateFormat('yyyy-MM-ddThh:mm:ss').parse(this);
    String formattedTime =
        DateFormat('hh:mm', isArabic ? 'ar' : 'en').format(date);
    if (date.hour > 11) {
      formattedTime = '$formattedTime مساء';
    } else {
      formattedTime = '$formattedTime صباحا';
    }
    return formattedTime;
  }
}

extension Responsive on BuildContext {
  bool get isMobile {
    return MediaQuery.of(this).size.width < 1100 ? true : false;
  }
}

extension Uploads on BuildContext {
  Future<void> uploadAttachment(
      {required String img64,
      required String imageName,
      required Function(String id) afterUpload}) async {
    GenericCubit<double> progressCubit = GenericCubit<double>();
    progressCubit.update(data: 0);
    var client = Dio();
    Map<String, String> header = {
      "content-type": 'application/json',
      //  "Accept-Language": globalLang,

      "Accept": "*/*",
    };
    SharedPreferences ref = await SharedPreferences.getInstance();
    String? token = ref.getString(LocalStoreNames.userToken);

    header.update('Authorization', (value) => "Bearer " + token.toString(),
        ifAbsent: () => "Bearer " + token.toString());
    String lastPercentage = '';
    client.post(
      '${AppSetting.serviceURL}api/Attachment/upload',
      data: {"file": img64, "fileName": imageName},
      options: Options(
        headers: header,
      ),
      onSendProgress: (int sent, int total) {
        if (lastPercentage != (sent / total * 100).toStringAsFixed(0)) {
          progressCubit.update(data: sent / total);
        }
        lastPercentage = (sent / total * 100).toStringAsFixed(0);
      },
    ).then((value) {
      afterUpload(value.toString());
    });
    await showDialog(
      builder: (BuildContext ctx) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: .2.sw,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10.sp,
                        ),
                        Image.asset(AppImages.uploading, width: 70.w),
                        SizedBox(
                          height: 10.h,
                        ),
                        TxtN(
                          text: isArabic
                              ? 'جاري رفع المرفق'
                              : 'Uploading attachment',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          color: const Color(0xff12123C),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),

                        GenericBuilder<double>(
                            genericCubit: progressCubit,
                            builder: (progress) {
                              if (progress == 1) {
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.pop(ctx);
                                });
                              }
                              return Column(
                                children: [
                                  LinearProgressIndicator(
                                    value: progress,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "${isArabic ? 'تم الرفع' : 'Uploaded'} ${(progress * 100).toStringAsFixed(progress == 1 ? 0 : 1)} %",
                                    style: AppFonts.apptextStyle.copyWith(
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ],
                              );
                              // return LinearPercentIndicator(
                              //   padding: EdgeInsets.zero,
                              //   alignment: MainAxisAlignment.start,
                              //   lineHeight: 50.h,
                              //   barRadius: Radius.circular(12),
                              //   isRTL: isArabic ? true : false,
                              //   backgroundColor: Colors.transparent,
                              //   percent: progress,
                              //   progressColor: AppColors.secondaryColor,
                              //   center: Text(
                              //     "${AppWords.doneUpload.tr} ${(progress * 100).toStringAsFixed(progress == 1 ? 0 : 1)} %",
                              //     style: TextStyle(
                              //         fontFamily: AppFonts.mainfont,
                              //         fontSize: 13.sp,
                              //         color: progress < 0.7
                              //             ? AppColors.mainColor
                              //             : Colors.white),
                              //   ),
                              // );

                              //////////////////////////
                              //   LiquidLinearProgressIndicator(
                              //   value: progress, // Defaults to 0.5.
                              //   valueColor: AlwaysStoppedAnimation(
                              //
                              //       AppColors.secondaryColor.withOpacity(
                              //           0.5)), // Defaults to the current Theme's accentColor.
                              //   backgroundColor: Colors
                              //       .white, // Defaults to the current Theme's backgroundColor.
                              //   borderColor: Colors.transparent,
                              //   borderWidth: 5.0,
                              //   borderRadius: 12.0,
                              //   direction: Axis
                              //       .horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                              //   center: Text("تم رفع ${(progress*100).toStringAsFixed(progress==1?0:1)} %",style: TextStyle(
                              //     fontFamily: AppFonts.mainfont,
                              //     fontSize: 16.sp,
                              //     color: progress<0.5?AppColors.mainColor:Colors.white
                              //   ),),
                              // );
                            }),

                        SizedBox(
                          height: 30.h,
                        ),
                        // AppButton(
                        //   color: AppColors.mainColor,
                        //   height: 45.h,
                        //   fontSize: 13.sp,
                        //   onPress: () async {
                        //     isCanceled = true;
                        //     goBack();
                        //   },
                        //   text: AppWords.cancel.tr,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      context: this,
    );
  }
}
