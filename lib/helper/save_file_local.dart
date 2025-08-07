//
// //import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
// import 'dart:html';
//
// import 'package:ext_storage/ext_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class SavedFilePDFLocaly {
//   ///[htmlString] this function take html string and convert it to pdf and saved it localy on dowenload path
//   static savedFilePDFLocaly({@required String htmlString}) async {
//     var status = await Permission.storage.status;
//     if (status.isGranted) {
//       Map<Permission, PermissionStatus> statuses = await [
//         Permission.storage,
//       ].request();
//       //////print(statuses[Permission.storage]);
//
//       var targetPath = await ExtStorage.getExternalStoragePublicDirectory(
//           ExtStorage.DIRECTORY_DOWNLOADS);
//
//       final DateTime now = DateTime.now();
//       var targetFileName = "Contract-${now.toLocal().toString()}";
//
//       var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//           htmlString, targetPath, targetFileName);
//
//       //////print(generatedPdfFile.path);
//       return generatedPdfFile.path; //saved file path
//     }
//   }
// }
