import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sislimoda_admin_dashboard/helper/arabic_to_english_number.dart';
import 'package:sislimoda_admin_dashboard/helper/validation.dart';
import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
import 'package:sislimoda_admin_dashboard/utility/image_path.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.inputType = TextInputType.text,
      this.labelText = '',
      this.hintText = '',
      this.textFieldValidType = TextFieldvalidatorType.translateRequired,
      this.controller,
      this.iconData,
      this.confirmPasswordController,
      this.firstPasswordToConfirm,
      this.maxLength,
      this.enabled = true,
      required this.onTap,
      this.obscureText = false,
      this.onChanged,
      this.maxlines = 1,
      this.formatters = const []})
      : super(key: key);

  final TextInputType inputType;
  final String labelText;
  final String hintText;
  final TextFieldvalidatorType textFieldValidType;
  final TextEditingController? controller;
  final String? iconData;
  final TextEditingController? confirmPasswordController;
  final String? firstPasswordToConfirm;
  final bool obscureText;
  final int? maxLength;
  final bool enabled;
  final List<TextInputFormatter> formatters;
  final Function onTap;
  final int maxlines;
  final Function(String)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool secure = false;

  @override
  void initState() {
    secure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText.isNotEmpty)
          Text(
            widget.labelText.tr(),
            style: AppFonts.apptextStyle.copyWith(
                fontSize: context.isMobile ? 12.sp : 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryFontColor),
          ),
        if (widget.labelText.isNotEmpty)
          SizedBox(
            height: context.isMobile ? 10.h : 10.h,
          ),
        TextFormField(
          onChanged: widget.onChanged,
          keyboardType: widget.inputType,
          maxLines: widget.maxlines,
          controller: widget.controller,
          enabled: widget.enabled,
          onTap: () {
            widget.onTap();
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: AppColors.mainColor,
          obscureText: secure,
          inputFormatters: widget.formatters,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              height: 2,
              fontWeight: FontWeight.w500),
          // focusNode: widget.currentFocusNode,
          keyboardAppearance: Brightness.dark,

          validator: (v) => validation(
              type: widget.textFieldValidType,
              value: v!,
              firstPAsswordForConfirm: widget.textFieldValidType ==
                      TextFieldvalidatorType.confirmPassword
                  ? widget.confirmPasswordController!.value.text
                  : ""),
          decoration: InputDecoration(
            hintStyle: AppFonts.apptextStyle.copyWith(
                fontWeight: FontWeight.w400,
                height: 1,
                fontSize: context.isMobile ? 12 : 16,
                color: AppColors.secondaryFontColor.withOpacity(.5)),
            errorStyle: AppFonts.apptextStyle.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 12.spMin),
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: AppColors.borderColor.withOpacity(.5),
                  style: BorderStyle.solid,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColors.mainColor,
                  style: BorderStyle.solid,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColors.error,
                  style: BorderStyle.solid,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(
                  color: AppColors.secondaryFontColor,
                  style: BorderStyle.solid,
                )),
            labelStyle: const TextStyle(
                fontSize: 12, height: 1.5, fontWeight: FontWeight.w600),
            floatingLabelStyle: const TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w600,
              height: .6,
            ),
            alignLabelWithHint: false,
            contentPadding: EdgeInsets.only(
                left: 10.w, right: 10.w, top: 20.h, bottom: 10.h),
            hintText: widget.hintText,
            suffixIcon:
                widget.textFieldValidType == TextFieldvalidatorType.password ||
                        widget.textFieldValidType ==
                            TextFieldvalidatorType.confirmPassword ||
                        widget.textFieldValidType ==
                            TextFieldvalidatorType.passwordLogin
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            secure = !secure;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              !secure ? AppImages.show : AppImages.hide,
                              width: 18,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      )
                    : null,
            // prefixIcon: widget.iconData != null
            //     ? Padding(
            //         padding:
            //             EdgeInsets.symmetric(vertical: 5, horizontal: 10.h),
            //         child: SizedBox(
            //           width: 40.h,
            //           child: Row(
            //             children: [
            //               SvgPicture.asset(
            //                 widget.iconData!,
            //                 width: 22,
            //                 // width: 22.w,
            //                 // height: 22.h,
            //                 // color: AppColors.secondaryFontColor,
            //               ),
            //               SizedBox(
            //                 height: 22.h,
            //                 child: VerticalDivider(),
            //               )
            //             ],
            //           ),
            //         ))
            //     : null,
                        prefixIcon: widget.iconData != null
    ? Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: SvgPicture.asset(
          widget.iconData!,
          width: 20.w,
          height: 20.h,
          fit: BoxFit.contain,
        ),
      )
    : null,
          ),
        ),
      ],
    );
  }
}

// class CustomTextFieldUnderline extends StatefulWidget {
//   const CustomTextFieldUnderline({
//     super.key,
//     this.inputType = TextInputType.text,
//     this.labelText = '',
//     this.hintText = '',
//     this.textFieldValidType = TextFieldvalidatorType.required,
//     this.controller,
//     this.iconData,
//     this.confirmPasswordController,
//     this.firstPasswordToConfirm,
//     this.maxLength,
//     this.enabled = true,
//     required this.onTap,
//     this.obscureText = false,
//     this.maxlines = 1,
//   });
//
//   final TextInputType inputType;
//   final String labelText;
//   final String hintText;
//   final TextFieldvalidatorType textFieldValidType;
//   final TextEditingController? controller;
//   final String? iconData;
//   final TextEditingController? confirmPasswordController;
//   final String? firstPasswordToConfirm;
//   final bool obscureText;
//   final int? maxLength;
//   final bool enabled;
//
//   final Function onTap;
//   final int maxlines;
//   @override
//   State<CustomTextFieldUnderline> createState() =>
//       _CustomTextFieldUnderlineState();
// }
//
// class _CustomTextFieldUnderlineState extends State<CustomTextFieldUnderline> {
//   bool secure = false;
//
//   @override
//   void initState() {
//     secure = widget.obscureText;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.hintText.isNotEmpty)
//           Text(
//             widget.hintText,
//             style: AppFonts.apptextStyle.copyWith(
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.black),
//           ),
//         TextFormField(
//           keyboardType: widget.inputType,
//           maxLines: widget.maxlines,
//           controller: widget.controller,
//           enabled: widget.enabled,
//           onTap: () {
//             widget.onTap();
//           },
//
//           onFieldSubmitted: (text) {
//             // if (widget.currentFocusNode == widget.nextFocusNode) {
//             //   widget.currentFocusNode.unfocus();
//             // } else {
//             //   widget.currentFocusNode.unfocus();
//             //   FocusScope.of(context).requestFocus(widget.nextFocusNode);
//             // }
//           },
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           cursorColor: AppColors.mainColor,
//           obscureText: secure,
//           style: const TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//               height: 2,
//               fontWeight: FontWeight.w500),
//           // focusNode: widget.currentFocusNode,
//           keyboardAppearance: Brightness.dark,
//           validator: (v) => validation(
//               type: widget.textFieldValidType,
//               value: v!,
//               firstPAsswordForConfirm: widget.textFieldValidType ==
//                       TextFieldvalidatorType.confirmPassword
//                   ? widget.confirmPasswordController!.value.text
//                   : ""),
//           decoration: InputDecoration(
//             labelText: widget.labelText,
//
//             labelStyle: const TextStyle(
//                 fontSize: 12, height: 1.5, fontWeight: FontWeight.w600),
//
//             floatingLabelStyle: const TextStyle(
//               color: Colors.teal,
//               fontWeight: FontWeight.w600,
//               height: .6,
//             ),
//             contentPadding: EdgeInsets.only(
//                 left: 10.w, right: 10.w, top: 20.h, bottom: 10.h),
//             alignLabelWithHint: false,
//             // border: OutlineInputBorder(
//             //   borderRadius:
//             //   BorderRadius.circular(widget.maxlines > 1 ? 10.r : 50.r),
//             //   gapPadding: 0,
//             // ),
//
//             suffixIcon:
//                 widget.textFieldValidType == TextFieldvalidatorType.password ||
//                         widget.textFieldValidType ==
//                             TextFieldvalidatorType.confirmPassword
//                     ? InkWell(
//                         onTap: () {
//                           setState(() {
//                             secure = !secure;
//                           });
//                         },
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               secure ? AppImages.show : AppImages.hide,
//                               width: 18,
//                             ),
//                           ],
//                         ),
//                       )
//                     : null,
//             //     : widget.textFieldValidType == TextFieldvalidatorType.phoneNumber
//             //     ? CountryCodePicker(
//             //   onChanged: (CountryCode code) {
//             //     print(code.dialCode!.replaceAll('+', ''));
//             //   },
//             //   onInit: (CountryCode? code) {
//             //     print(code!.dialCode!.replaceAll('+', ''));
//             //   },
//             //   initialSelection: 'SA',
//             //   favorite: const ['+966', 'SA'],
//             //   showCountryOnly: false,
//             //   showOnlyCountryWhenClosed: false,
//             //   alignLeft: false,
//             // )
//             //     : null,
//             // errorBorder: OutlineInputBorder(
//             //     borderRadius:
//             //     BorderRadius.circular(widget.maxlines > 1 ? 10.r : 50.r),
//             //     gapPadding: 0,
//             //     borderSide: const BorderSide(width: 2, color: Colors.red)),
//             prefixIcon: widget.iconData != null
//                 ? Padding(
//                     padding: const EdgeInsets.only(bottom: 3, top: 15),
//                     child: SvgPicture.asset(
//                       widget.iconData!,
//                       width: 15.w,
//                       height: 10.h,
//                     ))
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }
