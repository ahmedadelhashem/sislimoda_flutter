// import 'dart:developer';
// import 'dart:ui';
//
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sislimoda_admin_dashboard/cubits/get_all_country/get_all_countries_cubit.dart';
// import 'package:sislimoda_admin_dashboard/model/general_model/item.dart';
// import 'package:sislimoda_admin_dashboard/utility/all_app_words.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_theme.dart';
// import 'custom_items_cubits/loading_cubit/loading_cubit.dart';
//
// extension T on String {
//   String get arabicNumberToEnglish {
//     const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
//     const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
//     var input = this;
//     for (int i = 0; i < english.length; i++) {
//       input = input.replaceAll(arabic[i], english[i]);
//     }
//
//     return input;
//   }
// }
//
// class PhoneCodePicker extends StatefulWidget {
//   const PhoneCodePicker(
//       {Key? key,
//       required this.phoneController,
//       required this.width,
//       required this.textAlign,
//       required this.loading})
//       : super(key: key);
//   final TextEditingController phoneController;
//   final double width;
//   final TextAlign textAlign;
//   final Loading loading;
//
//   @override
//   _PhoneCodePickerState createState() => _PhoneCodePickerState();
// }
//
// class _PhoneCodePickerState extends State<PhoneCodePicker> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<GetAllCountriesCubit, GetAllCountriesState>(
//       listener: (context, state) {
//         if (state is GetAllCountriesLoading) {
//           widget.loading.show;
//         } else {
//           widget.loading.hide;
//         }
//       },
//       builder: (context, state) {
//         if (state is GetAllCountriesSuccess) {
//           if (BlocProvider.of<GetAllCountriesCubit>(context).validation ==
//               null) {
//             state.result.forEach((element) {
//               log(element.id.toString() +
//                   '  ,  ' +
//                   element.name.toString() +
//                   '  ,  ' +
//                   element.nameEN.toString() +
//                   '  ,  ' +
//                   element.ioS2.toString() +
//                   '  ,  ' +
//                   element.prefixCode.toString());
//               BlocProvider.of<GetAllCountriesCubit>(context)
//                   .countriesFilter
//                   .add(element.ioS2.toString());
//               BlocProvider.of<GetAllCountriesCubit>(context).validate.add(
//                     Item(key: element.ioS2, value: element.regex),
//                   );
//               BlocProvider.of<GetAllCountriesCubit>(context).prefixCodeList.add(
//                     Item(key: element.ioS2, value: element.prefixCode),
//                   );
//               BlocProvider.of<GetAllCountriesCubit>(context)
//                   .idList
//                   .add(Item(key: element.ioS2, value: element.id.toString()));
//               BlocProvider.of<GetAllCountriesCubit>(context).id =
//                   element.id.toString();
//               BlocProvider.of<GetAllCountriesCubit>(context).initialCountry =
//                   element.ioS2.toString();
//               BlocProvider.of<GetAllCountriesCubit>(context).validation =
//                   element.regex.toString();
//               BlocProvider.of<GetAllCountriesCubit>(context).prefixCode =
//                   element.prefixCode.toString();
//             });
//             BlocProvider.of<GetAllCountriesCubit>(context).regex = RegExp(r"^" +
//                 BlocProvider.of<GetAllCountriesCubit>(context)
//                     .validation
//                     .toString() +
//                 "\$");
//           }
//
//           return Container(
//             padding: EdgeInsets.all(10.sp),
//             decoration: BoxDecoration(
//               color: AppColors.unselectedColor,
//               borderRadius: BorderRadius.circular(15.r),
//             ),
//             margin: EdgeInsets.only(
//               top: 10.h,
//               bottom: 10.h,
//             ),
//             // padding: EdgeInsets.only(right: 10.w, left: 10.w),
//             width: .85.sw,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(AppWords.mobileNumber.tr,
//                     style: TextStyle(
//                         fontFamily: AppFonts.mainfont, fontSize: 14.sp)),
//                 TextFormField(
//                   textAlign: TextAlign.start,
//                   cursorHeight: 10.h,
//                   showCursor: false,
//                   style: TextStyle(
//                       height: 2,
//                       fontSize: 14.sp,
//                       fontFamily: AppFonts.mainfont),
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   // textAlign: widget.textAlign,
//                   textDirection: TextDirection.ltr,
//                   validator: (text) {
//                     text = text!.arabicNumberToEnglish;
//
//                     // if (text.startsWith('0')) {
//                     //   text = text.substring(1);
//                     // }
//
//                     if (text.isEmpty) {
//                       return isArabic
//                           ? 'من فضلك ادخل رقم الجوال'
//                           : 'please enter phone number';
//                     } else if (!BlocProvider.of<GetAllCountriesCubit>(context)
//                         .regex!
//                         .hasMatch(text)) {
//                       return isArabic
//                           ? 'رقم الجوال  خاطئ'
//                           : 'invalid phone number';
//                     }
//                   },
//                   controller: widget.phoneController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                       gapPadding: 1,
//                       borderRadius: BorderRadius.circular(14.sp),
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: EdgeInsets.all(5.sp),
//                     fillColor: const Color(0xffF7F7FA),
//                     filled: true,
//                     prefixIcon: Container(
//                       decoration: const BoxDecoration(),
//                       child: CountryCodePicker(
//                         onChanged: (c) {
//                           BlocProvider.of<GetAllCountriesCubit>(context)
//                                   .validation =
//                               BlocProvider.of<GetAllCountriesCubit>(context)
//                                   .validate
//                                   .firstWhere(
//                                       (element) => element.key == c.dialCode)
//                                   .value
//                                   .toString();
//                           BlocProvider.of<GetAllCountriesCubit>(context)
//                                   .prefixCode =
//                               BlocProvider.of<GetAllCountriesCubit>(context)
//                                   .prefixCodeList
//                                   .firstWhere(
//                                       (element) => element.key == c.dialCode)
//                                   .value
//                                   .toString();
//                           BlocProvider.of<GetAllCountriesCubit>(context).regex =
//                               RegExp(r"^" +
//                                   BlocProvider.of<GetAllCountriesCubit>(context)
//                                       .validation
//                                       .toString() +
//                                   "\$");
//                           BlocProvider.of<GetAllCountriesCubit>(context).id =
//                               BlocProvider.of<GetAllCountriesCubit>(context)
//                                   .idList
//                                   .firstWhere(
//                                       (element) => element.key == c.dialCode)
//                                   .value
//                                   .toString();
//                           BlocProvider.of<GetAllCountriesCubit>(context)
//                               .initialCountry = c.dialCode;
//                           //////print(c.dialCode);
//                         },
//
//                         initialSelection:
//                             BlocProvider.of<GetAllCountriesCubit>(context)
//                                 .initialCountry,
//                         countryFilter:
//                             BlocProvider.of<GetAllCountriesCubit>(context)
//                                 .countriesFilter,
//                         dialogSize: Size.square(.7.sw),
//                         dialogTextStyle: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14.sp,
//                           fontFamily: AppFonts.mainfont,
//                         ),
//                         builder: (countryCode) {
//                           return Container(
//                             margin: EdgeInsets.only(
//                                 right: 0.w, left: 0.w, bottom: 5.h, top: 5.h),
//                             child: Column(
//                               children: [
//                                 // SizedBox(
//                                 //   height: 10.h,
//                                 // ),
//
//                                 Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Container(
//                                       margin: EdgeInsets.only(
//                                           left: 5.w, right: 5.w),
//                                       child: Text(
//                                         countryCode!.dialCode.toString(),
//                                         style: TextStyle(
//                                             fontFamily: AppFonts.mainfont,
//                                             fontSize: 15.sp),
//                                       ),
//                                     ),
//                                     Container(
//                                       // margin:
//                                       //     EdgeInsets.only(left: 10.w, right: 10.w),
//                                       child: Icon(
//                                         Icons.arrow_drop_down_rounded,
//                                         size: 35.sm,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                         // countryList: [{'EG':'+20','SA':'203'}],
//                       ),
//                     ),
//                     errorStyle: TextStyle(
//                         fontFamily: AppFonts.mainfont,
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.red),
//                   ),
//                   keyboardType: TextInputType.phone,
//                 ),
//               ],
//             ),
//           );
//           // Container(
//           //   height: 80.h,
//           //   padding: EdgeInsets.all(4.h),
//           //   margin: EdgeInsets.only(top: 10.h),
//           //   width: widget.width,
//           //   child: Stack(
//           //     children: [
//           //       Container(
//           //         width: widget.width - .2.sw,
//           //         height: 45.h,
//           //         decoration: BoxDecoration(
//           //             color: AppColors.white,
//           //             borderRadius: BorderRadius.circular(10.sp)),
//           //       ),
//           //       Container(
//           //         width: widget.width - .34.sw,
//           //         child: TextFormField(
//           //           autovalidateMode: AutovalidateMode.onUserInteraction,
//           //           textAlign: widget.textAlign,
//           //           textDirection: TextDirection.ltr,
//           //           validator: (text) {
//           //             text = text!.arabicNumberToEnglish;
//           //
//           //             if (text.startsWith('0')) {
//           //               text = text.substring(1);
//           //             }
//           //
//           //             if (text.isEmpty) {
//           //               return 'من فضلك ادخل رقم الجوال';
//           //             } else if (!allCountriesCubit.regex!
//           //                 .hasMatch(allCountriesCubit.prefixCode! + text)) {
//           //               return 'رقم الجوال  خاطئ';
//           //             }
//           //           },
//           //           controller: widget.phoneController,
//           //           decoration: InputDecoration(
//           //             border: InputBorder.none,
//           //             errorStyle: TextStyle(
//           //                 fontFamily: AppFonts.hanimation,
//           //                 fontSize: 12.sp,
//           //                 fontWeight: FontWeight.w500,
//           //                 color: AppColors.red),
//           //             counterStyle: TextStyle(fontFamily: AppFonts.hanimation),
//           //           ),
//           //           keyboardType: TextInputType.phone,
//           //         ),
//           //       ),
//           //       Positioned(
//           //         left: 0,
//           //         child: Container(
//           //           decoration: BoxDecoration(
//           //               color: AppColors.secondaryButtonColor,
//           //               borderRadius: BorderRadius.only(
//           //                   topLeft: Radius.circular(10.sp),
//           //                   bottomLeft: Radius.circular(10.sp))),
//           //           child: CountryCodePicker(
//           //             onChanged: (c) {
//           //               allCountriesCubit.validation =
//           //                   "${allCountriesCubit.validate.firstWhere((element) => element.key == c.code).value.toString()}";
//           //               allCountriesCubit.prefixCode =
//           //                   "${allCountriesCubit.prefixCodeList.firstWhere((element) => element.key == c.code).value.toString()}";
//           //               allCountriesCubit.regex = RegExp(r"^" +
//           //                   allCountriesCubit.validation.toString() +
//           //                   "\$");
//           //               allCountriesCubit.id = allCountriesCubit.idList
//           //                   .firstWhere((element) => element.key == c.code)
//           //                   .value
//           //                   .toString();
//           //               allCountriesCubit.initialCountry = c.code;
//           //             },
//           //
//           //             initialSelection: allCountriesCubit.initialCountry,
//           //             countryFilter: allCountriesCubit.countriesFilter,
//           //             dialogSize: Size.square(.7.sw),
//           //             builder: (countryCode) {
//           //               //////print(countryCode!.flagUri.toString());
//           //               return Container(
//           //                 height: 45.h,
//           //                 width: .3.sw,
//           //                 decoration: BoxDecoration(
//           //                   color: AppColors.secondaryButtonColor,
//           //                   borderRadius: BorderRadius.only(
//           //                       topLeft: Radius.circular(10.sp),
//           //                       bottomLeft: Radius.circular(10.sp)),
//           //                 ),
//           //                 child: Row(
//           //                   mainAxisSize: MainAxisSize.min,
//           //                   children: [
//           //                     Container(
//           //                       margin: EdgeInsets.only(left: 5.w, right: 5.w),
//           //                       child: Text(
//           //                         countryCode.dialCode.toString(),
//           //                         style: TextStyle(
//           //                             fontFamily: AppFonts.hanimation,
//           //                             fontSize: 16.sp),
//           //                       ),
//           //                     ),
//           //                     Container(
//           //                       margin: EdgeInsets.only(left: 5.w, right: 5.w),
//           //                       child: Icon(Icons.expand_more),
//           //                     ),
//           //                     Container(
//           //                       height: 20.h,
//           //                       margin: EdgeInsets.only(left: 10.w),
//           //                       child: Image.asset(
//           //                         countryCode.flagUri.toString(),
//           //                         package: 'country_code_picker',
//           //                       ),
//           //                     ),
//           //                   ],
//           //                 ),
//           //               );
//           //             },
//           //             // countryList: [{'EG':'+20','SA':'203'}],
//           //           ),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // );
//         }
//         widget.loading.show;
//         return Container(
//           height: 40.h,
//           width: widget.width,
//           padding: EdgeInsets.all(4.h),
//           margin: EdgeInsets.only(top: 10.h),
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(10.sp)),
//         );
//       },
//     );
//   }
// }
