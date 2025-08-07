// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:file_picker/file_picker.dart';


// class FilePickerManager {
//   static Future<void> pickFile({required Function toDo}) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowCompression: true,
//       type: FileType.custom,
//       allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
//     );

//     if (result != null) {
//       PlatformFile file = result.files.first;
//       final bytes = File(file.path.toString()).readAsBytesSync();
//       String img64 = base64Encode(bytes);
//       toDo(img64, file.name.toString(), file);
//       // log(img64);
//       // //////print(file.bytes);
//       // //////print(file.size);
//       //////print(file.extension);
//       // //////print(file.path);
//     } else {
//       // User canceled the picker
//     }
//   }
// }
