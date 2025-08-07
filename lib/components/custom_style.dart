// import 'package:sislimoda_admin_dashboard/components/alert/custom_alert_message.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/selectitems_cubit/selectitems_cubit.dart';
// import 'package:sislimoda_admin_dashboard/components/text/text_custom.dart';
// import 'package:sislimoda_admin_dashboard/model/general_model/item.dart';
// import 'package:sislimoda_admin_dashboard/utility/all_app_words.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_theme.dart';
// import 'package:sislimoda_admin_dashboard/helper/lang.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class CustomItems {
//   static Padding steps(int number, int activenumber) {
//     var divider = const Expanded(
//       child: Divider(
//         thickness: 1,
//         color: Colors.grey,
//       ),
//     );
//
//     List<Widget> ls = [];
//     for (var i = 1; i <= number; i++) {
//       var xx = Container(
//           width: 30,
//           height: 30,
//           child: Center(
//               child: Text(
//             i.toString(),
//             style: const TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           )),
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: Color(0xFFe0f2f1),
//             // gradient: i == activenumber
//             //     ? AppStyle.bgLinearGradientGray()
//             //     : AppStyle.bgLinearGradientbrand(),
//           ));
//       ls.add(xx);
//       if (i != number) {
//         ls.add(divider);
//       }
//     }
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
//       child: Container(
//         child: Row(
//           children: ls,
//         ),
//       ),
//     );
//   }
//
//   static sizeboxwidth(double width) {
//     return SizedBox(
//       width: width,
//     );
//   }
//
//   static sizeboxheight(double height) {
//     return SizedBox(
//       height: height,
//     );
//   }
//
//   static loder(context) {
//     return Positioned(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color.fromRGBO(1, 6, 0, 0.15),
//                 Color.fromRGBO(0, 0, 0, 0),
//               ]),
//         ),
//         child: Center(
//           child: Container(
//             width: 60.h,
//             height: 60.h,
//             child: Padding(
//               padding: EdgeInsets.all(5.sp),
//               child: Image.asset(
//                 'assets/images/loader.gif',
//                 height: 70.h,
//                 fit: BoxFit.fitHeight,
//               ),
//             ),
//             decoration: BoxDecoration(
//                 color: AppColors.mainColor,
//                 borderRadius: BorderRadius.circular(13.r)),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static loaderWithLogo(context, [String? message]) {
//     var messagetemp = message ?? "برجاء الانتظار.......";
//
//     return Positioned(
//       child: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color.fromRGBO(1, 6, 0, 0.15),
//                 Color.fromRGBO(0, 0, 0, 0),
//               ]),
//         ),
//         child: Center(
//           child: Container(
//             width: 150.sp + (messagetemp.length).toDouble(),
//             height: 100.sp + (messagetemp.length).toDouble(),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Center(
//                         child: Text(
//                           messagetemp,
//                           textAlign: TextAlign.center,
//                           style: TxtStyle.txtStyle(
//                             color: Colors.black,
//                             fontSize: FS.fs14,
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: 55.h,
//                         height: 55.h,
//                         child: Padding(
//                           padding: EdgeInsets.all(10.sp),
//                           child: const CircularProgressIndicator(
//                               color: AppColors.mainColor),
//                         ),
//                         decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                       )
//                     ],
//                   ),
//                 )),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static noDataFound(String? errormessage, context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
//               child: Image.asset(
//                 ' AppImage.noData',
//                 width: 150,
//                 height: 150,
//               ),
//             ),
//           ),
//           TxtN(
//             text: errormessage ?? "No data",
//             color: AppColors.mainColor,
//             fontSize: 20.sp,
//             fontFamily: AppFonts.mainfont,
//           ),
//         ],
//       ),
//     );
//   }
//
//   static showAlertDialog(BuildContext context, List<Item> list, Item item,
//       Function updateState, Function afterItemTap) {
//     var mylist = list;
//     double? containerhight = list.length > 7
//         ? MediaQuery.of(context).size.height -
//             (MediaQuery.of(context).padding.top +
//                 MediaQuery.of(context).padding.bottom +
//                 200)
//         : null;
//
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return SimpleDialog(
//               shape: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(15))),
//               contentPadding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
//               title: SizedBox(
//                 height: 40,
//                 child: Center(
//                   child: TextFormField(
//                     onChanged: (val) {
//                       setState(() {
//                         list = mylist
//                             .where((element) => element.value!
//                                 .toLowerCase()
//                                 .contains(val.toLowerCase()))
//                             .toList();
//                         containerhight = list.length > 7
//                             ? MediaQuery.of(context).size.height -
//                                 (MediaQuery.of(context).padding.top +
//                                     150 +
//                                     MediaQuery.of(context).padding.bottom +
//                                     MediaQuery.of(context).viewInsets.bottom +
//                                     MediaQuery.of(context).viewInsets.top)
//                             : null;
//                       });
//                     },
//                     textAlign: TextAlign.center,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: const BorderSide(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               children: [
//                 Stack(
//                   // overflow: Overflow.visible,
//                   alignment: AlignmentDirectional.bottomCenter,
//                   children: [
//                     SizedBox(
//                       height: containerhight,
//                       child: Padding(
//                         padding: const EdgeInsets.fromLTRB(3, 10, 3, 30),
//                         child: Scrollbar(
//                           radius: const Radius.circular(150),
//                           child: SingleChildScrollView(
//                             child: Column(
//                               children: [
//                                 for (var i = 0; i < list.length; i++)
//                                   GestureDetector(
//                                     onTap: () {
//                                       item.key = list[i].key;
//                                       item.value = list[i].value;
//                                       afterItemTap();
//                                       updateState();
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Center(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text(list[i].value!,
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   color: AppColors.mainColor,
//                                                   fontSize: 14.sp)),
//                                           const Padding(
//                                             padding: EdgeInsets.fromLTRB(
//                                                 30, 10, 30.0, 10),
//                                             child: Divider(
//                                               thickness: 0.5,
//                                               height: 0.5,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 sizeboxheight(30),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Container(
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(15),
//                               bottomRight: Radius.circular(15)),
//                           // gradient: AppStyle.bgLinearGradientbrand2(),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Center(
//                             child: TxtN(
//                               text: "back",
//                               fontWeight: FontWeight.normal,
//                               fontSize: 16.sp,
//                               color: Colors.white,
//                               fontFamily: AppFonts.mainfont,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   static customloder() {
//     return Stack(
//       children: [
//         Positioned(
//           child: Center(
//             child: SizedBox(
//               width: 50,
//               height: 50,
//               child: Image.asset("AppImage.loader"),
//               // decoration: BoxDecoration(
//               //     color: Colors.black,
//               //     borderRadius: BorderRadius.circular(10)),
//               // child:
//               //  Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: CircularProgressIndicator(
//               //     strokeWidth: 3,
//               //     valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
//               //   ),
//               //),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   static textfild(
//       TextEditingController textEditingController,
//       FocusNode focusNode,
//       String hintText,
//       bool errortxt,
//       TextInputType textInputType,
//       Function? onchage,
//       [Icon? icon,
//       bool obscureText = false]) {
//     return TextFormField(
//       //textAlign: TextAlign.center,
//       onChanged: (value) {
//         if (onchage != null) {
//           onchage(value);
//         }
//       },
//       validator: (val) {
//         return 'error12';
//       },
//       obscureText: obscureText,
//       controller: textEditingController,
//       focusNode: focusNode,
//       maxLines: 1,
//
//       style: TextStyle(
//         color: AppColors.secondaryColor,
//         fontSize: 16.sp,
//       ),
//
//       keyboardType: textInputType,
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.all(8.0),
//         hintText: hintText,
//         prefixIcon: icon,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(35.0),
//           borderSide: const BorderSide(color: Colors.green),
//         ),
//         // errorText: errortxt ? 'error' : null,
//       ),
//     );
//   }
//
//   static Future<bool?> showCustomAllert(
//       {required BuildContext context, required List<Widget> children}) {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return SimpleDialog(
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(15))),
//             contentPadding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
//             children: children);
//       },
//     );
//   }
//
//   static customSelectItems({
//     required String displayName,
//     required SelectitemsCubit selectitemsCubit,
//     required Function(Item item) afterSelectItem,
//   }) {
//     double? containerhight = selectitemsCubit.state.searchItemsList!.length > 7
//         ? MediaQuery.of(Get.context!).size.height -
//             (MediaQuery.of(Get.context!).padding.top +
//                 MediaQuery.of(Get.context!).padding.bottom +
//                 200)
//         : null;
//     if (selectitemsCubit.state.items!.isNotEmpty) {
//       return showDialog(
//         context: Get.context!,
//         builder: (context) {
//           return BlocConsumer<SelectitemsCubit, SelectitemsState>(
//             bloc: selectitemsCubit,
//             listener: (context, state) {
//               //! Check State Here
//               //! Ex. call api acording state change or any action
//             },
//             builder: (context, state) {
//               return SimpleDialog(
//                 shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(15))),
//                 contentPadding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
//                 title: SizedBox(
//                   height: 40,
//                   child: Center(
//                     child: selectitemsCubit.state.items!.length > 10
//                         ? TextFormField(
//                             onChanged: (val) {
//                               containerhight = MediaQuery.of(context)
//                                       .size
//                                       .height -
//                                   (MediaQuery.of(context).padding.top +
//                                       150 +
//                                       MediaQuery.of(context).padding.bottom +
//                                       MediaQuery.of(context).viewInsets.bottom +
//                                       MediaQuery.of(context).viewInsets.top);
//
//                               //!  Search in Items By Text From Text Input Field
//                               selectitemsCubit.searchInItemsList(val);
//                             },
//                             textAlign: TextAlign.center,
//                             decoration: InputDecoration(
//                               filled: true,
//                               hintText: AppWords.search.tr,
//                               hintStyle: TextStyle(
//                                   fontFamily: AppFonts.mainfont,
//                                   fontSize: FS.fs14,
//                                   fontWeight: FontWeight.bold),
//                               fillColor: Colors.white,
//                               focusColor: Colors.white,
//                               alignLabelWithHint: true,
//                               contentPadding: const EdgeInsets.all(0),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(50.sp),
//                                 borderSide: const BorderSide(
//                                   width: 0,
//                                   style: BorderStyle.none,
//                                 ),
//                               ),
//                             ),
//                           )
//                         : Container(),
//                   ),
//                 ),
//                 children: [
//                   Stack(
//                     //overflow: Overflow.visible,
//                     alignment: AlignmentDirectional.bottomCenter,
//                     children: [
//                       SizedBox(
//                         height: containerhight,
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(3, 10, 3, 30),
//                           child: Scrollbar(
//                             radius: const Radius.circular(150),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   Center(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         TxtN(
//                                           text: displayName,
//                                           textAlign: TextAlign.center,
//                                           maxLines: 1,
//                                           fontFamily: AppFonts.mainfont,
//                                           color: Colors.grey,
//                                           fontSize: 13.sp,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                         const Padding(
//                                           padding: EdgeInsets.fromLTRB(
//                                               30, 10, 30.0, 10),
//                                           child: Divider(
//                                             thickness: 0.5,
//                                             height: 0.5,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                   for (var i = 0;
//                                       i <
//                                           selectitemsCubit
//                                               .state.searchItemsList!.length;
//                                       i++)
//                                     GestureDetector(
//                                       onTap: () {
//                                         //! Select Item From List
//                                         selectitemsCubit.selectItems(
//                                             selectitemsCubit
//                                                 .state.searchItemsList![i]);
//                                         //! Load Api Or Emit Action Acording Selected Value
//                                         //! Please Pass Func
//                                         //! Code Here
//                                         afterSelectItem(selectitemsCubit
//                                             .state.searchItemsList![i]);
//                                         Navigator.of(context).pop();
//                                         //! Close Alert
//                                       },
//                                       child: Container(
//                                         color: Colors.white,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         child: Center(
//                                             child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             TxtN(
//                                               text: selectitemsCubit.state
//                                                   .searchItemsList![i].value!,
//                                               textAlign: TextAlign.center,
//                                               fontFamily: AppFonts.mainfont,
//                                               maxLines: 1,
//                                               fontWeight: FontWeight.bold,
//                                               color: AppColors.mainColor,
//                                               fontSize: 13.sp,
//                                             ),
//                                             const Padding(
//                                               padding: EdgeInsets.fromLTRB(
//                                                   30, 10, 30.0, 10),
//                                               child: Divider(
//                                                 thickness: 0.5,
//                                                 height: 0.6,
//                                               ),
//                                             )
//                                           ],
//                                         )),
//                                       ),
//                                     ),
//                                   selectitemsCubit
//                                           .state.searchItemsList!.isEmpty
//                                       ? Padding(
//                                           padding: const EdgeInsets.all(10),
//                                           child: Text(
//                                             '${AppWords.noMatchedResult.tr}  " ${selectitemsCubit.state.searchWord} "',
//                                             style: TextStyle(
//                                               fontSize: 16.sp,
//                                               fontFamily: AppFonts.mainfont,
//                                               color: AppColors.mainColor,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                           ),
//                                         )
//                                       : const Text(''),
//                                   sizeboxheight(30),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         child: Container(
//                           width: double.infinity,
//                           decoration: const BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                               bottomLeft: Radius.circular(15),
//                               bottomRight: Radius.circular(15),
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: TxtN(
//                                 text: "back",
//                                 fontSize: 14.sp,
//                                 fontFamily: AppFonts.mainfont,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//       );
//     } else {
//       return CustomAlert.showAlertMessage(
//           txt: "no data", alertType: displayName);
//     }
//   }
// }
