import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/translations/codegen_loader.g.dart';

class UploadImageController {
  static Future<XFile?> getFormDataImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? response = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (response != null) {
      String extension = '';
      extension = response.name.split('.').last;
      if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
        return response;
      } else {
        showErrorMessage(
            message: '${LocaleKeys.extensionError.tr()} (jpg-png-jpeg)');
        return null;
      }
    } else {
      return null;
    }
  }
}
