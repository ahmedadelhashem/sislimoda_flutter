import 'dart:ui';

import 'package:get/get.dart';
import 'package:sislimoda_admin_dashboard/language_json/ar.dart';
import 'package:sislimoda_admin_dashboard/language_json/en.dart';
import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lang extends Translations {
  static Future<Locale> getDefaultOrStoredLocal() async {
    var appLocale = const Locale('ar');

    //set defualt
    var prefs = await SharedPreferences
        .getInstance(); //create instance from SharedPreferences
    if (prefs.getString('language_code') == null) {
      await prefs.setString('language_code', 'ar'); //store defalut
      globalLang = appLocale.toString(); //set globalLang
      isArabic = true; //set isArabic
      return appLocale; //return default
    } else {
      appLocale = Locale(prefs.getString('language_code')!); //get stored
      globalLang = appLocale.toString(); //set globalLang
      isArabic = globalLang == "ar" ? true : false; //set isArabic
      return appLocale; //return stored
    }
  }

  static Future<Locale> changeLang() async {
    var prefs = await SharedPreferences.getInstance();
    var appLocale = await getDefaultOrStoredLocal();
    if (appLocale == const Locale("en")) {
      appLocale = const Locale("ar");
      await prefs.setString('language_code', 'ar');
      globalLang = appLocale.toString();
      isArabic = true;
      await prefs.setString('countryCode', '');
    } else {
      appLocale = const Locale("en");
      globalLang = appLocale.toString();
      isArabic = false;
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    return appLocale;
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };

  static final locales = [
    const Locale('en', 'US'),
    const Locale('ar', ''),
  ];
}
