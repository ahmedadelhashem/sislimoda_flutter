// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:sislimoda_admin_dashboard/components/generic_bind.dart';
// import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
// import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_fonts.dart';
// import 'package:sislimoda_admin_dashboard/utility/app_setting.dart';
//
// class TopCategories extends StatefulWidget {
//   const TopCategories({super.key, this.products});
//   final List<GetAnalysisModelDataFrequentSoldCategories?>? products;
//   @override
//   State<TopCategories> createState() => _TopCategoriesState();
// }
//
// class _TopCategoriesState extends State<TopCategories> {
//   Map<String, double> productsData = {};
//   Map<String, String> labelsData = {};
//   double totalSealed = 0;
//
//   GenericCubit<Map<String, double>> dataCubit =
//       GenericCubit<Map<String, double>>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getAnalytics();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 450,
//       height: 230,
//       padding: EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             isArabic ? 'اعلى الاقسام مبيعا ' : 'Top categories',
//             style: AppFonts.apptextStyle.copyWith(
//                 color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           GenericBuilder<Map<String, double>>(
//               genericCubit: dataCubit,
//               builder: (data) {
//                 return PieChart(
//                   chartLegendSpacing: 20,
//                   chartRadius: 150,
//                   dataMap: data,
//                   chartValuesOptions: ChartValuesOptions(
//                       showChartValueBackground: false,
//                       showChartValues: false,
//                       showChartValuesOutside: true,
//                       showChartValuesInPercentage: true),
//                   legendLabels: labelsData,
//                   centerWidget: CircleAvatar(
//                     backgroundColor: Colors.white,
//                     radius: 50,
//                     child: Text(
//                       totalSealed.toString(),
//                       textAlign: TextAlign.center,
//                       style: AppFonts.apptextStyle.copyWith(
//                           color: Colors.black,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   colorList: [
//                     Color(0xffA48AFB),
//                     Color(0xffE478FA),
//                     Color(0xff06AED4),
//                     Color(0xffFFE01A),
//                     Color(0xffFD6F8E),
//                   ],
//                   legendOptions: LegendOptions(
//                       legendPosition:
//                           isArabic ? LegendPosition.left : LegendPosition.right,
//                       legendTextStyle:
//                           AppFonts.apptextStyle.copyWith(color: Colors.black)),
//                   animationDuration: const Duration(milliseconds: 800),
//                 );
//               }),
//         ],
//       ),
//     );
//   }
//
//   getAnalytics() {
//     for (var element in widget.products!) {
//       productsData.addIf(productsData.length < 5, element?.name?.EN ?? '',
//           double.parse(element?.numberOfSale ?? '0'));
//       labelsData.addIf(productsData.length <= 5, element?.name?.EN ?? '',
//           '${isArabic ? (element?.name?.AR ?? '') : (element?.name?.EN ?? '')}  :  ${element?.numberOfSale ?? '0'}');
//       if (productsData.length < 5) {
//         totalSealed = totalSealed + double.parse(element?.numberOfSale ?? '0');
//       }
//     }
//     dataCubit.update(data: productsData);
//   }
// }
