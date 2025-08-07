import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sislimoda_admin_dashboard/components/button/button.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/components/screen.dart';
import 'package:sislimoda_admin_dashboard/components/text_filed/text_filed_custom.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/screens/Auth/forget_password/forget_password_data.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

@RoutePage()
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with ForgetPasswordData {
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
            child: Row(
              children: [
                Container(
                  // height: .6.sh,
                  width: 400,
                  margin:
                      EdgeInsets.only(top: 60, bottom: 60, left: 60, right: 60),
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
                            'Lütfen e-postanızı girin',
                            style: AppFonts.apptextStyle.copyWith(
                                fontSize: context.isMobile ? 14.spMin : 17,
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
                            iconData: AppImages.mail,
                            onTap: () async {},
                          ),
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
                                    title: 'Kodu gönder',
                                    onPress: () async {
                                      if (formKey.currentState!.validate()) {
                                        loading.show;
                                        try {
                                          var result = await AppService.callService(
                                              actionType: ActionType.post,
                                              apiName:
                                                  'api/auth/ForgetPassword?userName=${emailController.text}',
                                              body: {});

                                          result.fold((success) {
                                            context.router.push(
                                                ResetPasswordRoute(
                                                    email:
                                                        emailController.text));
                                          }, (fails) {
                                            showTurkeyErrorMessage(
                                                message:
                                                    'kullanıcı bulunamadı');
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
            ),
          ),
        ),
      ),
    );
  }
}
