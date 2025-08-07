// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
// import 'package:sislimoda_admin_dashboard/components/button/button.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_multiselect.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_network_image.dart';
// import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
// import 'package:sislimoda_admin_dashboard/components/screen.dart';
// import 'package:sislimoda_admin_dashboard/main.dart';
// import 'package:sislimoda_admin_dashboard/models/orders/get_tickets_pagination_model.dart';
// import 'package:sislimoda_admin_dashboard/models/product/product_model.dart';
// import 'package:sislimoda_admin_dashboard/screens/orders/models/convert_to_dummy_order_model.dart';
// import 'package:sislimoda_admin_dashboard/services/app_services.dart';
// import 'package:sislimoda_admin_dashboard/translations/locale_keys.g.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_colors.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
//
// class TicketItem extends StatelessWidget {
//   const TicketItem(
//       {super.key,
//       required this.ticket,
//       required this.products,
//       required this.width});
//   final TicketModel? ticket;
//   final double width;
//   final List<ProductModel> products;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(16)),
//       child: Column(
//         children: [
//           SizedBox(
//             height: 150,
//             width: width,
//             child: ticket?.text != null
//                 ? Text(ticket?.text ?? '')
//                 : CustomNetworkImage(
//                     link: ticket?.image ?? '',
//                     height: 150,
//                     width: width,
//                   ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           if (ticket?.status == 'opened')
//             SizedBox(
//               height: 35,
//               child: AppButton(
//                 onPress: acceptTicket,
//                 title: LocaleKeys.acceptTicket.tr(),
//               ),
//             ),
//           if (ticket?.status != 'opened')
//             SizedBox(
//               height: 35,
//               child: AppButton(
//                 title: LocaleKeys.accepted.tr(),
//                 backgroundColor: Colors.white,
//                 titleFontColor: AppColors.mainColor,
//                 borderColor: AppColors.mainColor,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   acceptTicket() {
//     List<ConvertToDummyOrderModel> selectedItems = [];
//     Loading loading = Loading();
//     showDialog(
//         context: currentContext,
//         builder: (ctx) {
//           return Screen(
//             loadingCubit: loading,
//             child: StatefulBuilder(builder: (context, state) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.symmetric(horizontal: .1.sw),
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16)),
//                     child: Column(
//                       children: [
//                         Material(
//                           child: SizedBox(
//                             height: 500,
//                             width: double.infinity,
//                             child: ticket?.description != null
//                                 ? Text(ticket?.description ?? '')
//                                 : Column(
//                                     children: [
//                                       Text(ticket?. ?? ''),
//                                       CustomNetworkImage(
//                                         link: ticket?.image ?? '',
//                                         height: 400,
//                                         width: width,
//                                       ),
//                                     ],
//                                   ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Material(
//                           child: CustomMultiSelect(
//                             isSingle: false,
//                             hint: LocaleKeys.selectProducts.tr(),
//                             onChange: (List<ValueItem> items) {
//                               if (items.isNotEmpty) {
//                                 selectedItems = [];
//                                 items.forEach((element) {
//                                   selectedItems.add(ConvertToDummyOrderModel(
//                                       name: element.label,
//                                       productId: element.value,
//                                       quantity: '1'));
//                                 });
//                                 state(() {});
//                               } else {
//                                 selectedItems = [];
//                               }
//                             },
//                             items: products
//                                 .map((ProductModel product) => ValueItem(
//                                     label: isArabic
//                                         ? (product.name ?? '')
//                                         : (product.nameEn ?? ''),
//                                     value: product.id))
//                                 .toList(),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         // Wrap(
//                         //   children: selectedItems.map((element) {
//                         //     return Material(
//                         //       child: Container(
//                         //         margin: EdgeInsets.symmetric(horizontal: 10),
//                         //         padding: EdgeInsets.symmetric(
//                         //             horizontal: 20, vertical: 10),
//                         //         decoration: BoxDecoration(
//                         //             borderRadius: BorderRadius.circular(8),
//                         //             border: Border.all(color: Colors.grey)),
//                         //         child: Row(
//                         //           mainAxisSize: MainAxisSize.min,
//                         //           children: [
//                         //             Text(
//                         //               element.name ?? '',
//                         //               style: AppFonts.apptextStyle.copyWith(
//                         //                   color: AppColors.secondaryFontColor,
//                         //                   fontSize: 14),
//                         //             ),
//                         //             SizedBox(
//                         //               width: 10,
//                         //             ),
//                         //             SizedBox(
//                         //                 width: 60,
//                         //                 child: TextFormField(
//                         //                   onTap: () {},
//                         //                   onChanged: (text) {
//                         //                     element.quantity = text;
//                         //                   },
//                         //                 ))
//                         //           ],
//                         //         ),
//                         //       ),
//                         //     );
//                         //   }).toList(),
//                         // )
//                         Row(
//                           children: [
//                             Spacer(),
//                             SizedBox(
//                               width: 100,
//                               height: 42,
//                               child: AppButton(
//                                 onPress: () async {
//                                   loading.show;
//                                   try {
//                                     var result = await AppService.callService(
//                                         actionType: ActionType.post,
//                                         apiName:
//                                             'ticket/${ticket?.id ?? ''}/order',
//                                         body: {
//                                           'products': selectedItems.map((e) {
//                                             return e.toJson();
//                                           }).toList()
//                                         });
//
//                                     result.fold((success) {
//                                       Navigator.pop(ctx);
//                                       showSuccessMessage(
//                                           message: LocaleKeys
//                                               .acceptedDoneSuccessfully
//                                               .tr());
//                                     }, (failure) {
//                                       showErrorMessage(
//                                           message: failure.message);
//                                     });
//                                   } catch (error) {}
//                                   loading.hide;
//                                 },
//                                 title: LocaleKeys.confirm.tr(),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               );
//             }),
//           );
//         });
//   }
// }
