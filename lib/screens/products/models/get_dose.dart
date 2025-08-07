import 'package:flutter/cupertino.dart';

class GetDose {
  final TextEditingController startAge;
  final TextEditingController endAge;
  final TextEditingController doseArabic;
  final TextEditingController doseEnglish;

  GetDose(
      {required this.startAge,
      required this.endAge,
      required this.doseArabic,
      required this.doseEnglish});
}
