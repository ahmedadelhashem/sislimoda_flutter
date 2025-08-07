import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';

class UploadFileController {
  static Future<(String base64, String name)?> pickImageOrPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      withReadStream: true, // مهم للويب
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      final extension = file.extension?.toLowerCase();

      if (extension == null || !['jpg', 'jpeg', 'png', 'pdf'].contains(extension)) {
        showErrorMessage(message: "الملف يجب أن يكون بصيغة: jpg, png, jpeg, pdf");
        return null;
      }

      Uint8List? bytes = file.bytes;
      if (bytes == null && file.readStream != null) {
        // Web uses readStream
        final completer = Completer<Uint8List>();
        final chunks = <int>[];
        file.readStream!.listen(
          (chunk) => chunks.addAll(chunk),
          onDone: () => completer.complete(Uint8List.fromList(chunks)),
        );
        bytes = await completer.future;
      }

      if (bytes != null) {
        final img64 = base64Encode(bytes);
        return (img64, file.name);
      } else {
        showErrorMessage(message: "تعذر قراءة الملف.");
        return null;
      }
    } else {
      return null;
    }
  }
}
