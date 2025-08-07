import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/models/auth/send_verify_code.dart';
import 'package:sislimoda_admin_dashboard/models/auth/set_new_password_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/Auth/reset_password/reset_password_data.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, @pathParam required this.email});
  final String email;
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with ResetPasswordData {
  @override
  void initState() {
    // TODO: implement initState
    isVerifiedCubit.update(data: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      loadingCubit: loading,
      child: Scaffold(
        body: Localizations(
          locale: Locale('en'),
          delegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          child: Container(
            width: 1.sw,
            height: 1.sh,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImages.loginBackground),
                    fit: BoxFit.cover)),
            child: GenericBuilder(
                genericCubit: isVerifiedCubit,
                builder: (isCodeVerified) {
                  return Row(
                    children: [
                      if (isCodeVerified)
                        Container(
                          // height: .6.sh,
                          width: 400.h,
                          margin: EdgeInsets.only(
                              top: 60, bottom: 60, left: 60, right: 60),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r)),
                          padding: EdgeInsets.only(
                              left: context.isMobile ? 23.w : 50,
                              right: context.isMobile ? 23.w : 50),
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Şifreyi ayarla',
                                    style: AppFonts.apptextStyle.copyWith(
                                        fontSize: context.isMobile ? 16 : 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Yeni şifrenizi belirleyin',
                                    style: AppFonts.apptextStyle.copyWith(
                                        fontSize:
                                            context.isMobile ? 14.spMin : 17,
                                        color: AppColors.secondaryFontColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  CustomTextField(
                                    onTap: () {},
                                    labelText: 'Yeni Şifre',
                                    hintText: 'yeni şifrenizi girin',
                                    controller: newPasswordController,
                                    textFieldValidType:
                                        TextFieldvalidatorType.password,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  CustomTextField(
                                    onTap: () {},
                                    labelText: 'şifreyi onayla',
                                    hintText: 'yeni şifrenizi girin',
                                    controller: confirmPasswordController,
                                    confirmPasswordController:
                                        newPasswordController,
                                    textFieldValidType:
                                        TextFieldvalidatorType.confirmPassword,
                                  ),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: context.isMobile ? 200.w : 150,
                                          height: 54,
                                          child: AppButton(
                                            title: 'iptal etmek',
                                            onPress: () async {
                                              isVerifiedCubit.update(
                                                  data: false);
                                            },
                                            titleFontSize: 16,
                                            titleFontColor: AppColors.mainColor,
                                            backgroundColor: AppColors
                                                .secondaryFontColor
                                                .withOpacity(.1),
                                            fontWeight: FontWeight.w600,
                                          )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      SizedBox(
                                          width: context.isMobile ? 200.w : 150,
                                          height: 54,
                                          child: AppButton(
                                            title: 'şifreyi sıfırla',
                                            onPress: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                loading.show;
                                                try {
                                                  var result = await AppService.callService(
                                                      actionType:
                                                          ActionType.post,
                                                      apiName:
                                                          'api/Auth/ForgetPasswordConfirm',
                                                      body: SetNewPasswordModel(
                                                              userId: userId,
                                                              newpassword:
                                                                  newPasswordController
                                                                      .text)
                                                          .toJson());

                                                  result.fold((success) {
                                                    context.router.popAndPush(
                                                        LoginRoute());
                                                    Future.delayed(
                                                      Duration(seconds: 1),
                                                      () {
                                                        showTurkeySuccessMessage(
                                                            message:
                                                                'şifre başarıyla değiştirildi');
                                                      },
                                                    );
                                                  }, (fail) {
                                                    showTurkeyErrorMessage(
                                                        message: 'Hata oluştu');
                                                  });
                                                } catch (error) {}
                                                loading.hide;
                                              }
                                            },
                                            titleFontSize: 16,
                                            titleFontColor: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      if (!isCodeVerified)
                        Container(
                          // height: .6.sh,
                          width: 400.h,
                          margin: EdgeInsets.only(
                              top: 60, bottom: 60, left: 60, right: 60),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.r)),
                          padding: EdgeInsets.only(
                              left: context.isMobile ? 23.w : 50,
                              right: context.isMobile ? 23.w : 50),
                          child: SingleChildScrollView(
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'şifreyi sıfırla',
                                    style: AppFonts.apptextStyle.copyWith(
                                        fontSize: context.isMobile ? 16 : 22,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'e-posta hesabınıza gönderilen kodu girin',
                                    style: AppFonts.apptextStyle.copyWith(
                                        fontSize:
                                            context.isMobile ? 14.spMin : 17,
                                        color: AppColors.secondaryFontColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  PinCodeTextField(
                                    onTextChanged: (text) {
                                      if (text.length == 6) {
                                        isDone = true;
                                        validateOtpCubit.update(data: '');
                                      } else if (text.isEmpty) {
                                        validateOtpCubit.update(
                                            data: 'Gerekli');
                                      } else if (text.length <= 6) {
                                        isDone = false;
                                        validateOtpCubit.update(
                                            data: 'Altı haneli sayı gerekli');
                                      }
                                    },
                                    controller: otpController,
                                    maxLength: 6,
                                    pinBoxWidth: 40.h,
                                    pinBoxHeight: 40.h,
                                    wrapAlignment: WrapAlignment.spaceBetween,
                                    pinBoxOuterPadding: EdgeInsets.all(5.sp),
                                    pinBoxDecoration: (color, color1,
                                            {double? borderWidth,
                                            double? radius}) =>
                                        BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            // color: Colors.grey.withOpacity(.2),
                                            border:
                                                Border.all(color: Colors.grey)),
                                    pinTextStyle: TextStyle(
                                        fontSize: 15.0.sp,
                                        fontFamily: AppFonts.mainfont,
                                        fontWeight: FontWeight.bold),
                                    // pinTextAnimatedSwitcherTransition:
                                    // ProvidedPinBoxTextAnimation.scalingTransition,
                                    //                    pinBoxColor: Colors.green[100],
                                    // pinTextAnimatedSwitcherDuration:
                                    // Duration(milliseconds: 300),
                                    //                    highlightAnimation: true,
                                    // highlightAnimationBeginColor: Colors.black,
                                    // highlightAnimationEndColor: Colors.white12,
                                    keyboardType: TextInputType.number,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  GenericBuilder<String>(
                                      builder: (validationMessage) {
                                        return Row(
                                          children: [
                                            Text(
                                              validationMessage,
                                              style: AppFonts.apptextStyle
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11.sp,
                                                      color: Colors.red),
                                            ),
                                          ],
                                        );
                                      },
                                      genericCubit: validateOtpCubit),
                                  SizedBox(
                                    height: 60,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: context.isMobile ? 200.w : 300,
                                          height: 54,
                                          child: AppButton(
                                            title: 'kodu doğrula',
                                            onPress: () async {
                                              if (isDone) {
                                                loading.show;
                                                // try {
                                                var result = await AppService
                                                    .callService(
                                                        actionType:
                                                            ActionType.post,
                                                        apiName:
                                                            'api/Auth/ForgetPasswordCodeVerify',
                                                        body: SendVerifyCode(
                                                                userName: widget
                                                                    .email,
                                                                code:
                                                                    otpController
                                                                        .text)
                                                            .toJson());

                                                result.fold((success) {
                                                  if (jsonDecode(
                                                          success)['userId'] !=
                                                      null) {
                                                    userId = jsonDecode(
                                                        success)['userId'];
                                                    isVerifiedCubit.update(
                                                        data: true);
                                                  } else {
                                                    showTurkeyErrorMessage(
                                                        message: 'yanlış kod');
                                                  }
                                                }, (fails) {
                                                  showTurkeyErrorMessage(
                                                      message: 'yanlış kod');
                                                });
                                                // } catch (error) {}
                                                loading.hide;
                                              } else {
                                                validateOtpCubit.update(
                                                    data: 'Gerekli');
                                              }
                                            },
                                            titleFontSize: 16,
                                            titleFontColor: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                      // if (1.sw > 800)
                      //   Container(
                      //     width: .5.sw,
                      //     height: 1.sh,
                      //     color: AppColors.mainColor,
                      //     child: Center(
                      //       child: SvgPicture.asset(AppImages.loginIcon),
                      //     ),
                      //   )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
