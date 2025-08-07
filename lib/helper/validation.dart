import 'package:easy_localization/easy_localization.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';
import 'package:sislimoda_admin_dashboard/translations/local_keys.g.dart';
import 'package:sislimoda_admin_dashboard/utility/all_app_words.dart';

import '../utility/app_setting.dart';

enum TextFieldvalidatorType {
  email,
  password,
  passwordLogin,
  confirmPassword,
  phoneNumber,
  normalText,
  code,
  number,
  name,
  optional,
  firstVisit,
  idNumber,
  required,
  translateRequired,
  haveNotSenstiveWords
}

validation(
    {required TextFieldvalidatorType type,
    required String value,
    required String firstPAsswordForConfirm}) {
  if (type == TextFieldvalidatorType.translateRequired) {
    if (value.isEmpty) {
      return isArabic ? 'مطلوب' : 'required';
    }
    return null;
  } else if (type == TextFieldvalidatorType.required) {
    if (value.isEmpty) {
      return 'gerekli';
    }
    return null;
  } else if (type == TextFieldvalidatorType.phoneNumber) {
    if (value.isEmpty) {
      return LocaleKeys.phoneNumberRequired.tr();
    }
    return null;
  } else if (type == TextFieldvalidatorType.email) {
    if (value.isEmpty) {
      return 'E-posta gereklidir';
    } else if (value.isNotEmpty && !regExpEmail.hasMatch(value)) {
      return 'yanlış e-posta';
    } else {
      return null;
    }
  } else if (type == TextFieldvalidatorType.password) {
    if (value.isEmpty) {
      return 'şifre gerekli';
    } else if (value.length < 6) {
      return 'Şifre zayıf';
    } else {
      return null;
    }
  } else if (type == TextFieldvalidatorType.passwordLogin) {
    if (value.isEmpty) {
      return 'şifre gerekli';
    } else {
      return null;
    }
  } else if (type == TextFieldvalidatorType.confirmPassword) {
    if (value.isEmpty) {
      return 'Şifre Doğrulanmalıdır';
    } else if (value != firstPAsswordForConfirm) {
      return 'şifre Uyuşmazlığı';
    } else {
      return null;
    }
  } else if (type == TextFieldvalidatorType.optional) {
    return null;
  } else if (type == TextFieldvalidatorType.idNumber) {
    if (value.isEmpty) {
      return 'الهوية مطلوبة';
    }
    if (value.length != 10) {
      return 'رقم الهوية 10';
    }
    if (!regExpNumber.hasMatch(value.trim().replaceAll('‎', ''))) {
      //////print(value.toString());
      return ValidationWords.idNumberMustHaveNoSpecialChars.tr;
    }
  } else if (type == TextFieldvalidatorType.name) {
    if (value.isEmpty) {
      return LocaleKeys.nameRequired.tr();
    }
    if (!regExpName.hasMatch(value.trim().replaceAll('‎', ''))) {
      return LocaleKeys.lettersOnly.tr();
    }
  }
}
