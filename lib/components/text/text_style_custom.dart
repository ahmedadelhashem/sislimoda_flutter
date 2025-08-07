part of 'text_custom.dart';

class TxtStyle {
  static TextStyle txtStyle(
      {required Color color, required double fontSize}) {
    return TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: AppFonts.mainfont,
        fontWeight: FontWeight.bold);
  }
}
