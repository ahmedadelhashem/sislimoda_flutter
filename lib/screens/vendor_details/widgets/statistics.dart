// import 'package:flutter/material.dart';
// import 'package:sislimoda_admin_dashboard/screens/vendor_details/models/statistics.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// class Statistics extends StatefulWidget {
//   const Statistics({super.key, required this.dataSource});
//   final List<StatisticsModel> dataSource;
//
//   @override
//   State<Statistics> createState() => _StatisticsState();
// }
//
// class _StatisticsState extends State<Statistics> {
//   final TooltipBehavior _tooltipBehavior = TooltipBehavior(
//       enable: true,
//       tooltipPosition: TooltipPosition.pointer,
//       builder: (data, point, points, value, value2) {
//         return Container(
//           padding: EdgeInsets.all(10),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircleAvatar(
//                     radius: 9,
//                     backgroundColor: Colors.blue,
//                     child: CircleAvatar(
//                       radius: 5,
//                       backgroundColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 12,
//                   ),
//                   Text(
//                     'Target : ',
//                     style: TextStyle(
//                         color: Color(0xff7A899F),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     '${data.target} %',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircleAvatar(
//                     radius: 9,
//                     backgroundColor: Color(0xffD9EBFF),
//                     child: CircleAvatar(
//                       radius: 5,
//                       backgroundColor: Colors.black,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 12,
//                   ),
//                   Text(
//                     'Actual : ',
//                     style: TextStyle(
//                         color: Color(0xff7A899F),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     '${data.actual} %',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       });
//
//   @override
//   Widget build(BuildContext context) {
//     return SfCartesianChart(
//         primaryXAxis: CategoryAxis(),
//         tooltipBehavior: _tooltipBehavior,
//         primaryYAxis: NumericAxis(
//           minimum: 0,
//           maximum: 100,
//           interval: 10,
//         ),
//         series: [
//           ColumnSeries<StatisticsModel, String>(
//               name: 'Actual',
//               width: .5,
//               spacing: .1,
//               color: Color(0xffD9EBFF),
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12)),
//               dataSource: widget.dataSource,
//               xValueMapper: (StatisticsModel data, _) => data.name,
//               yValueMapper: (StatisticsModel data, _) => data.value),
//         ]);
//   }
// }
