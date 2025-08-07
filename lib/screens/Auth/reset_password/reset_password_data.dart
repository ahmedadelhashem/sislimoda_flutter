import 'package:flutter/cupertino.dart';
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';

mixin ResetPasswordData {
  Loading loading = Loading();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isDone = false;
  String userId = '';
  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GenericCubit<String> validateOtpCubit = GenericCubit<String>();
  GenericCubit<bool> isVerifiedCubit = GenericCubit<bool>();
}
