import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';

class CustomRichTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final double height;
  final TextEditingController controller;
  final TextFieldvalidatorType textFieldValidType;
  final Function? onChangeText;
  final int? maxLines;
  CustomRichTextField({
    required this.controller,
    required this.labelText,
    required this.height,
    required this.hintText,
    required this.textFieldValidType, this.onChangeText, this.maxLines=16,
  });

  @override
  _CustomRichTextFieldState createState() => _CustomRichTextFieldState();
}

class _CustomRichTextFieldState extends State<CustomRichTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
     
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.controller,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        maxLines: widget.maxLines,
        onChanged: (text){
         if( widget.onChangeText!=null){
           widget.onChangeText!();
         }
        },
        validator: (v) => validation(
            type: widget.textFieldValidType,
            value: v!,
            firstPAsswordForConfirm: ""),
        decoration: InputDecoration(
          border: InputBorder.none,

          errorStyle: TextStyle(
              fontFamily: AppFonts.mainfont,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.red),
          fillColor: Colors.white,

          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: AppFonts.mainfont,
            fontStyle: FontStyle.normal,
          ),
          alignLabelWithHint: true,

        ),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontFamily: AppFonts.mainfont,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}
