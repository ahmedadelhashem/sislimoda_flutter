// import 'package:sislimoda_admin_dashboard/models/statistics/InfluencerSummaryModel.dart';
// import 'package:sislimoda_admin_dashboard/screens/brands/fluencerSummary/InfluencersSummary_data.dart';

// // Future<void> loadInfluencerSummaryData() async {
// //   try {
// //     List<InfluencerSummaryModel> list = await getAllInfluencersSummary(
// //       from: DateTime(2022, 1, 1),
// //       to: DateTime(2025, 7, 1),
// //     );

// //     int totalSoldProducts = 0;
// //     double totalRevenue = 0;
// //     int totalProducts = 0;

// //     for (var influencer in list) {
// //       totalSoldProducts += influencer.totalSoldProducts;
// //       totalRevenue += influencer.totalRevenue;
// //       totalProducts += influencer.totalProduct;
// //     }

// //     print('🛒 إجمالي المنتجات المباعة: $totalSoldProducts');
// //     print('💰 إجمالي الإيرادات: $totalRevenue');
// //     print('📦 إجمالي المنتجات : $totalProducts');

// //   } catch (e) {
// //     print('حدث خطأ أثناء تحميل البيانات: $e');
// //   }
// // }
// Future<void> loadInfluencerSummaryData({
//   required DateTime from,
//   required DateTime to,
// }) async {
//   try {
//     List<InfluencerSummaryModel> list = await getAllInfluencersSummary(
//       from: from,
//       to: to,
//     );

//     int totalSoldProducts = 0;
//     double totalRevenue = 0;
//     int totalProducts = 0;

//     for (var influencer in list) {
//       totalSoldProducts += influencer.totalSoldProducts;
//       totalRevenue += influencer.totalRevenue;
//       totalProducts += influencer.totalProduct;
//     }

//     print('🛒 إجمالي المنتجات المباعة: $totalSoldProducts');
//     print('💰 إجمالي الإيرادات: $totalRevenue');
//     print('📦 إجمالي المنتجات : $totalProducts');

//   } catch (e) {
//     print('❌ حدث خطأ أثناء تحميل البيانات: $e');
//   }
// }

import 'package:sislimoda_admin_dashboard/models/statistics/InfluencerSummaryModel.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/fluencerSummary/InfluencersSummary_data.dart';

class InfluencerSummaryStats {
  final int totalSoldProducts;
  final double totalRevenue;
  final int totalProducts;

  InfluencerSummaryStats({
    required this.totalSoldProducts,
    required this.totalRevenue,
    required this.totalProducts,
  });
}

Future<InfluencerSummaryStats?> loadInfluencerSummaryData({
  required DateTime from,
  required DateTime to,
}) async {
  try {
    final List<InfluencerSummaryModel> list = await getAllInfluencersSummary(
      from: from,
      to: to,
    );

    final int totalSoldProducts = list.fold(0, (sum, i) => sum + i.totalSoldProducts);
    final double totalRevenue = list.fold(0.0, (sum, i) => sum + i.totalRevenue);
    final int totalProducts = list.fold(0, (sum, i) => sum + i.totalProduct);

    print('🛒 إجمالي المنتجات المباعة: $totalSoldProducts');
    print('💰 إجمالي الإيرادات: $totalRevenue');
    print('📦 إجمالي المنتجات : $totalProducts');

    return InfluencerSummaryStats(
      totalSoldProducts: totalSoldProducts,
      totalRevenue: totalRevenue,
      totalProducts: totalProducts,
    );
  } catch (e, stack) {
    print('❌ حدث خطأ أثناء تحميل البيانات: $e');
    print(stack);
    return null;
  }
}
