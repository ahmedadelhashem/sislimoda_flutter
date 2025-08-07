import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart' hide GetAnalysisModel;
import 'package:sislimoda_admin_dashboard/models/statistics/vendorstat.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/VendorSummary/VendorStatisticsServer.dart';

class VendorStatisticsSummary {
  final int totalSoldProducts;
  final double totalRevenue;
  final int totalProducts;
  final List<GetAnalysisModelTopSellingProducts> topSellingProducts;

  VendorStatisticsSummary({
    required this.totalSoldProducts,
    required this.totalRevenue,
    required this.totalProducts,
    required this.topSellingProducts,
  });
}

Future<VendorStatisticsSummary?> loadVendorStatisticsData({
  required String vendorId,
  required DateTime from,
  required DateTime to,
}) async {
  try {
    final GetAnalysisModel data = await VendorStatisticsServer.getStatistics(
      vendorId: vendorId,
      from: from,
      to: to,
    );

    return VendorStatisticsSummary(
      totalSoldProducts: data.totalSoldProducts ?? 0,
      totalRevenue: data.totalRevenue ?? 0.0,
      totalProducts: data.totalProduct ?? 0,
      topSellingProducts: data.topSellingProducts ?? [],
    );
  } catch (e, stack) {
    print('❌ حدث خطأ أثناء تحميل إحصائيات البائع: $e');
    print(stack);
    return null;
  }
}
