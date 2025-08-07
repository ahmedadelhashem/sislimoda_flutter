// import 'dart:async';
//
// import 'package:sislimoda_admin_dashboard/utility/local_storge_key.dart';
// import 'package:hive_flutter/hive_flutter.dart';
//
// class HiveHelper {
//   static late Box<String> studentToken;
//   static late Box<String> password;
//   static late Box<String> signature;
//
//   static Future<void> init() async {
//     await Hive.initFlutter();
//     //// Open Boxes
//     studentToken = await Hive.openBox<String>(LocalStoreNames.userToken);
//     signature = await Hive.openBox<String>(LocalStoreNames.signature);
//     password = await Hive.openBox<String>(LocalStoreNames.password);
//   }
//
//   static Future<void> putInBox({
//     required Box box,
//     required String key,
//     required dynamic data,
//   }) async {
//     return await box.put(key, data);
//   }
//
//   static dynamic getBoxData({
//     required Box box,
//     required String key,
//   }) {
//     return box.get(key, defaultValue: null);
//   }
//
//   static void removeData({
//     required Box box,
//     required String key,
//   }) {
//     box.delete(key);
//   }
// }
