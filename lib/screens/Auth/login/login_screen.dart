import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/check_box_custom.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/Auth/login/login_data.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginData {
  @override
  void initState() {
    // TODO: implement initState
    initData();
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
                    image: AssetImage(AppImages.login),
                    fit: BoxFit.cover)),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  // height: .6.sh,
                  width: context.isMobile ? 320 : 400,
                  margin: EdgeInsets.only(
                      top: 60,
                      bottom: 60,
                      left: context.isMobile ? 10 : 60.w,
                      right: context.isMobile ? 10 : 60.w),
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
                            'giriş yapmak',
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: context.isMobile ? 12.sp : 22.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Lütfen e-postanızı ve şifrenizi giriniz.',
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: context.isMobile ? 12.spMin : 17,
                                color: AppColors.secondaryFontColor,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          CustomTextField(
                            controller: emailController,
                            labelText: 'e-posta',
                            textFieldValidType: TextFieldvalidatorType.email,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: passwordController,
                            labelText: 'şifre',
                            textFieldValidType:
                                TextFieldvalidatorType.passwordLogin,
                            obscureText: true,
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              TextButton(
                                onPressed: () {
                                  context.router.push(ForgetPasswordRoute());
                                },
                                child: Text(
                                  'şifremi unuttum',
                                  style: AppFonts.apptextStyle.copyWith(
                                      fontSize: 12,
                                      color: AppColors.error,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              AppCheckbox(
                                onChanged: (value) {
                                  remember = value!;
                                },
                                label: Text(
                                  'Beni hatırla',
                                  style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 12,
                                    color: AppColors.secondaryFontColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: context.isMobile ? 200 : 300,
                                  height: 54,
                                  child: AppButton(
                                    title: 'giriş yapmak',
                                    onPress: login,
                                    titleFontSize: 16,
                                    titleFontColor: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hesabım yok ? ',
                                style: AppFonts.apptextStyle.copyWith(
                                  fontSize: 12,
                                  color: AppColors.secondaryFontColor
                                      .withOpacity(.6),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.router.push(SignupRoute());
                                },
                                child: Text(
                                  'Üye olmak',
                                  style: AppFonts.apptextStyle.copyWith(
                                    fontSize: 12,
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
