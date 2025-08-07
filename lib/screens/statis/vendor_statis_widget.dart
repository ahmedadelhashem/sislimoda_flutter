import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sislimoda_admin_dashboard/models/stati/VendorStatisticsData.dart';
/*
class AllVendorsComparisonChart extends StatelessWidget {
  final List<VendorStatisticsData> statsList;

  const AllVendorsComparisonChart({super.key, required this.statsList});

  @override
  Widget build(BuildContext context) {
    double chartHeight = math.max(300, statsList.length * 70);

    return SizedBox(
      height: chartHeight,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          maxY: _getMaxY(statsList),
          barGroups: _buildBarGroups(statsList),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < statsList.length) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                        statsList[index].vendorName,
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            topTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.black54,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final vendor = statsList[group.x.toInt()];
                final topProduct = vendor.topSellingProducts.isNotEmpty
                    ? vendor.topSellingProducts.first.product?.name ?? 'غير متوفر'
                    : 'غير متوفر';
                return BarTooltipItem(
                  'البائع: ${vendor.vendorName}\n'
                  'الإيرادات: ${vendor.totalRevenue.toStringAsFixed(2)} \$\n'
                  'المنتج الأكثر مبيعًا: $topProduct',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }

  double _getMaxY(List<VendorStatisticsData> list) {
    double maxRevenue = list.map((e) => e.totalRevenue).fold(0, math.max);
    return maxRevenue + (maxRevenue * 0.2); // زيادة 20% للمساحة البصرية
  }

  List<BarChartGroupData> _buildBarGroups(List<VendorStatisticsData> list) {
    return List.generate(list.length, (index) {
      final data = list[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data.totalRevenue,
            width: 20,
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(6),
          ),
        ],
      );
    });
  }
}
*/

class AllVendorsComparisonChart extends StatelessWidget {
  final List<VendorStatisticsData> statsList;

  const AllVendorsComparisonChart({super.key, required this.statsList});

  @override
  Widget build(BuildContext context) {
    final sortedStatsList = [...statsList];
    sortedStatsList.sort((a, b) => b.totalRevenue.compareTo(a.totalRevenue));

    double chartHeight = math.max(sortedStatsList.length * 60.0, 300.0);

    return SizedBox(
      height: chartHeight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            maxY: getMaxY(sortedStatsList),
            minY: 0,
            barTouchData: BarTouchData(
              enabled: true,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.black87,
               getTooltipItem: (group, groupIndex, rod, rodIndex) {
  final vendor = sortedStatsList[group.x.toInt()];
  return BarTooltipItem(
    '${vendor.vendorName}\n',
    const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    children: [
      TextSpan(
        text: 'الإيرادات: ${vendor.totalRevenue.toStringAsFixed(2)} \$\n',
        style: const TextStyle(color: Colors.yellow),
      ),
      TextSpan(
        text: 'المنتجات المباعة: ${vendor.totalSoldProducts}\n',
        style: const TextStyle(color: Colors.lightGreenAccent),
      ),
      TextSpan(
        text: 'الأكثر مبيعًا: ${vendor.topSellingProducts.isNotEmpty ? (vendor.topSellingProducts.first.product?.name ?? 'غير متوفر') : 'غير متوفر'}',
        style: const TextStyle(color: Colors.orangeAccent),
      ),
    ],
  );
},

              ),
            ),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(fontSize: 10),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 120,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < sortedStatsList.length) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          sortedStatsList[index].vendorName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: true),
            barGroups: List.generate(
              sortedStatsList.length,
              (index) {
                final data = sortedStatsList[index];
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: data.totalRevenue,
                      width: 12,
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: getMaxY(sortedStatsList),
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  double getMaxY(List<VendorStatisticsData> list) {
    return list.map((e) => e.totalRevenue).fold<double>(0, math.max) * 1.2;
  }
}

// import 'dart:math' as math;
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:sislimoda_admin_dashboard/models/stati/VendorStatisticsData.dart';

// class AllVendorsComparisonChart extends StatelessWidget {
//   final List<VendorStatisticsData> statsList;

//   const AllVendorsComparisonChart({super.key, required this.statsList});

//   @override
//   Widget build(BuildContext context) {
//     // نحدد العرض بناءً على عدد العناصر (كل عنصر 100 بكسل تقريبًا)
//     final double chartWidth = math.max(statsList.length * 100.0, MediaQuery.of(context).size.width);

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: SizedBox(
//         height: 400,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Container(
//             width: chartWidth,
//             padding: const EdgeInsets.only(bottom: 20), // مساحة للأسامي
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceBetween,
//                 maxY: getMaxY(),
//                 barTouchData: BarTouchData(enabled: true),
//                 titlesData: FlTitlesData(
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       getTitlesWidget: (value, meta) {
//                         final index = value.toInt();
//                         if (index >= 0 && index < statsList.length) {
//                           return Transform.rotate(
//                             angle: -0.5,
//                             child: Text(
//                               statsList[index].vendorName,
//                               style: const TextStyle(fontSize: 11),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           );
//                         }
//                         return const SizedBox();
//                       },
//                       reservedSize: 60,
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(showTitles: true),
//                   ),
//                   topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                 ),
//                 gridData: FlGridData(show: true),
//                 borderData: FlBorderData(show: true),
//                 barGroups: List.generate(
//                   statsList.length,
//                   (index) => BarChartGroupData(
//                     x: index,
//                     barRods: [
//                       BarChartRodData(
//                         toY: statsList[index].totalRevenue,
//                         color: Colors.blue,
//                         width: 30,
//                         borderRadius: BorderRadius.circular(4),
//                         backDrawRodData: BackgroundBarChartRodData(
//                           show: true,
//                           toY: getMaxY(),
//                           color: Colors.grey[200],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   double getMaxY() {
//     return statsList.map((e) => e.totalRevenue).fold<double>(0, math.max) * 1.2;
//   }
// }
