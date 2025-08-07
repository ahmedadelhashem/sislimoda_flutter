//
// import 'dart:io' show Platform;
//
//
// import 'package:package_info_plus/package_info_plus.dart';
//
// import 'app_setting.dart';
//
//
//
// class AppInfo {
//   static PackageInfo packageInfo = PackageInfo(
//     appName: 'Unknown',
//     packageName: 'Unknown',
//     version: Platform.isIOS ? AppSetting.iosVersion : AppSetting.androidVersion,
//     buildNumber: 'Unknown',
//   );
//   static loadAppInfo() async {
//     final PackageInfo info = await PackageInfo.fromPlatform();
//     packageInfo = info;
//   }
// }
