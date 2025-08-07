// import 'package:shared_preferences/shared_preferences.dart';

// class AppLocalStore {
//   static getString(String key) async {
//     var prefs = await SharedPreferences.getInstance();
//     if (prefs.getString(key) == null) {
//       //////print(key);
//     }
//     return prefs.getString(key);
//   }

//   static setString(String key, String value) async {
//     var prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, value);
//   }

//   static Future<bool> removeString(String key) async {
//     var prefs = await SharedPreferences.getInstance();
//     return await prefs.remove(key);
//   }

//   static setBool(String key, bool value) async {
//     var prefs = await SharedPreferences.getInstance();
//     prefs.setBool(key, value);
//   }
// }
