import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

void showAddBankAdDialog({
  required BuildContext context,
  required List<ValueItem> countries,
  required bool isArabic,
  required Function(File?, ValueItem?) onSubmit,
}) {
  final picker = ImagePicker();
  File? selectedImage;
  ValueItem? selectedCountry;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text(isArabic ? "إضافة إعلان بنك" : "Add Bank Ad"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final pickedImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {
                        selectedImage = File(pickedImage.path);
                      });
                    }
                  },
                  child: Text(isArabic ? "اختيار صورة" : "Pick Image"),
                ),
                SizedBox(height: 10.h),
                if (selectedImage != null)
                  Image.file(selectedImage!, height: 100, width: 100),
                SizedBox(height: 10.h),
                MultiSelectDropDown(
                  hint: isArabic ? "اختر الدولة" : "Select Country",
                  onOptionSelected: (options) {
                    if (options.isNotEmpty) {
                      setState(() {
                        selectedCountry = options.first;
                      });
                    }
                  },
                  options: countries,
                  selectedOptions:
                      selectedCountry != null ? [selectedCountry!] : [],
                  maxItems: 1,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(isArabic ? "إلغاء" : "Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onSubmit(selectedImage, selectedCountry);
                Navigator.pop(context);
              },
              child: Text(isArabic ? "إضافة" : "Add"),
            ),
          ],
        );
      });
    },
  );
}
