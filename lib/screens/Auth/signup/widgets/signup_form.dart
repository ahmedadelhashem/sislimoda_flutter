import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/auth/login_response_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';
import 'dart:html' as html;

import 'package:sislimoda_admin_dashboard/utility/local_storge_key.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  Loading loading = Loading();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // loading.show;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Screen(
        loadingCubit: loading,
        child: Container(
          width: 600,
          margin: EdgeInsets.only(
              left: context.isMobile ? 35.w : 130.w,
              right: context.isMobile ? 35.w : 90.w,
              bottom: 120),
          padding: EdgeInsets.symmetric(
              horizontal: context.isMobile ? 12.sp : 37.w, vertical: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.02),
                    spreadRadius: 7,
                    blurRadius: 100),
                BoxShadow(
                    color: Colors.black.withOpacity(.03),
                    spreadRadius: 4,
                    blurRadius: 100),
                BoxShadow(
                    color: Colors.black.withOpacity(.04), spreadRadius: 2),
              ]),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: context.isMobile ? 10.sp : 20.h,
                  ),
                  Text(
                    'Kayıt Ol',
                    style: GoogleFonts.lato(
                        fontSize: context.isMobile ? 16.sp : 30.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: context.isMobile ? 8.sp : 25.h,
                  ),
                  Text(
                    'Turk ürünlerinin kalitesini en üst seviyeye\n taşıyoruz.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontSize: context.isMobile ? 12.sp : 18.sp,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: context.isMobile ? 12.sp : 38.h,
                  ),
                  CustomTextField(
                    onTap: () {},
                    labelText: 'Şirket Adı',
                    hintText: 'Şirket adınızı buraya girin',
                    iconData: AppImages.company,
                    controller: companyNameController,
                  ),
                  SizedBox(
                    height: context.isMobile ? 10.sp : 28.h,
                  ),
                  CustomTextField(
                    onTap: () {},
                    labelText: 'E-posta',
                    hintText: 'E-posta adresinizi buraya girin',
                    iconData: AppImages.mail,
                    controller: userNameController,
                    textFieldValidType: TextFieldvalidatorType.email,
                  ),
                  SizedBox(
                    height: context.isMobile ? 16.sp : 28.h,
                  ),
                  CustomTextField(
                    onTap: () {},
                    labelText: 'Şifre',
                    hintText: 'Şifrenizi buraya girin',
                    iconData: AppImages.pass,
                    controller: passwordController,
                    textFieldValidType: TextFieldvalidatorType.password,
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  SizedBox(
                    height: context.isMobile ? 40.h : 62.h,
                    child: AppButton(
                      borderRadius: 12,
                      onPress: signup,
                      backgroundColor: Color(0xffF00024),
                      title: 'Kayıt Ol',
                      titleFontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Zaten bir hesabınız var mı?',
                        style: GoogleFonts.lato(
                            fontSize: context.isMobile ? 8.sp : 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff121111)),
                      ),
                      TextButton(
                          onPressed: () {
                            context.router.push(LoginRoute());
                          },
                          child: Text(
                            'Giriş Yap',
                            style: GoogleFonts.lato(
                                fontSize: context.isMobile ? 8.sp : 16.sp,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff121111)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Yardım gerekir mi? ',
                        style: GoogleFonts.lato(
                            fontSize: context.isMobile ? 8.sp : 16.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff121111)),
                      ),
                      TextButton(
                          onPressed: () {
                            html.window.open(
                                'whatsapp://send?phone=96560066009', '_blank');
                          },
                          child: Text(
                            ' WhatsApp’tan yazın: +90 **********',
                            style: GoogleFonts.lato(
                                fontSize: context.isMobile ? 8.sp : 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff121111)),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signup() async {
    loading.show;
    try {
      if (formKey.currentState!.validate()) {
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName: 'api/auth/RegisterVendor',
            body: {
              "appUser": {
                "firstName": "",
                "middleName": "",
                "lastName": "",
                "isActive": true,
                "address": "",
                "otherPhoneNumber": "",
                "isVendor": true,
                "isAdmin": false,
                "email": userNameController.text,
                "userName": userNameController.text,
                "phoneNumer": "",
                "password": passwordController.text,
                "gender": 0,
                "photoId": null,
                "birthDate": "",
                "enableNotification": true,
                "pantsMeasurement": "",
                "coachMeasurement": "",
                "tShirtmeasurement": "",
                "isInfluencer": false,
                "socialLogin": 0,
                "isSocialLogin": false
              },
              "vendor": {
                "name": '',
                "nameEn": "",
                "description": "",
                "descriptionEn": "",
                "ownerName": "",
                "ownerPhoneNumber": "",
                "ownerPhoneNumber2": "",
                "isActive": true,
                "isApproved": false,
                "companyName": companyNameController.text,
                "fullCompanyAddress": "",
                "numberOfProductsToSell": 0,
                "workFieldsList": [],
                "bankNumber": "",
                "iban": "",
                "bankName": "",
                "vendorCompanyAttachments": []
              }
            });
        result.fold((success) {
          login();
        }, (fail) {
          showTurkeyErrorMessage(message: "E-posta Zaten Mevcut");
        });
      }
    } catch (error) {}
    loading.hide;
  }

  login() async {
    loading.show;
    try {
      var result = await AppService.callService(
          actionType: ActionType.post,
          apiName:
              'api/Auth/LoginAdmin?userName=${userNameController.text}&password=${passwordController.text}',
          requestHeader: {
            "content-type": 'application/json',
            "Lang": isArabic ? 'AR' : 'EN',
            "Accept": "*/*",
            'agent': 'web'
          },
          body: {});

      result.fold((l) async {
        LoginResponseModel loginResponseModel =
            LoginResponseModel.fromJson(jsonDecode(l));
        SharedPreferences ref = await SharedPreferences.getInstance();

        // ref.setString(LocalStoreNames.userRefreshToken,
        //     loginResponseModel.refreshToken ?? '');
        if (loginResponseModel.user?.isAdmin ?? false) {
          ref.setString(
              LocalStoreNames.userToken, loginResponseModel.token ?? '');
          ref.setString('role', 'admin');
          ref.setString('userId', loginResponseModel.user?.id ?? "");

          currentContext.router.push(DashBoardLayout());
        } else if (loginResponseModel.user?.isVendor ?? false) {
          ref.setString(
              LocalStoreNames.userToken, loginResponseModel.token ?? '');
          ref.setString('role', 'vendor');
          ref.setString('userId', loginResponseModel.user?.id ?? "");
          ref.setString('vendorId', loginResponseModel.vendorData?.id ?? "");
          BlocProvider.of<UserCubit>(currentContext).getUserData();
          currentContext.router.push(VendorHomeLayout());
        } else {}
      }, (r) {
        showErrorMessage(message: r.message);
      });
    } catch (error) {}
    loading.hide;
  }
}
