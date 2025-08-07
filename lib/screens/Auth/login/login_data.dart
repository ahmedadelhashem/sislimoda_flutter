import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/user_cubit/user_cubit.dart';
import 'package:sislimoda_admin_dashboard/main.dart';
import 'package:sislimoda_admin_dashboard/models/auth/login_response_model.dart';
import 'package:sislimoda_admin_dashboard/routes/auto_route.gr.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:sislimoda_admin_dashboard/utility/local_storge_key.dart';

mixin LoginData {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  Loading loading = Loading();

  bool remember = false;
  initData() async {
    SharedPreferences ref = await SharedPreferences.getInstance();
    String? userName = ref.getString('userNameLogin');
    String? password = ref.getString('passwordLogin');
    print('userName$userName');
    print('userName$password');
    emailController.text = userName ?? '';
    passwordController.text = password ?? '';
  }

  login() async {
    if (formKey.currentState!.validate()) {
      // if (RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$")
      //     .hasMatch(passwordController.text)) {
      loading.show;
      try {
        // LoginRequest loginRequest = LoginRequest(
        //     email: emailController.text,
        //     password: passwordController.text,
        //     playerId: '123243435');
        var result = await AppService.callService(
            actionType: ActionType.post,
            apiName:
                'api/Auth/LoginAdmin?userName=${emailController.text}&password=${passwordController.text}',
            requestHeader: {
              "content-type": 'application/json',
              "Lang": isArabic ? 'AR' : 'EN',
              "Accept": "*/*",
              'agent': 'web'
            },
            body: {});

        result.fold((l) async {
          if (remember) {
            SharedPreferences ref = await SharedPreferences.getInstance();
            ref.setString('userNameLogin', emailController.text);
            ref.setString('passwordLogin', passwordController.text);
          }
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
          } else {
            showErrorMessage(
                message: LocaleKeys.emailOrPasswordAreIncorrect.tr());
          }
        }, (r) {
          showErrorMessage(message: r.message);
        });
      } catch (error) {}
      loading.hide;
      // } else {
      //   showErrorMessage(message: LocaleKeys.emailOrPasswordAreIncorrect.tr());
      // }
    }
  }
}
