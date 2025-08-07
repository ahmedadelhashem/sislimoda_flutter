import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';

class VendorStatisticsData {
  final String vendorId;
  final String vendorName;
  final int totalProducts;
  final double totalRevenue;
  final int totalSoldProducts;
  final List<GetAnalysisModelTopSellingProducts> topSellingProducts;

  VendorStatisticsData({
    required this.vendorId,
    required this.vendorName,
    required this.totalProducts,
    required this.totalRevenue,
    required this.totalSoldProducts,
    required this.topSellingProducts,
  });

  factory VendorStatisticsData.fromJson(Map<String, dynamic> json) {
    return VendorStatisticsData(
      vendorId: json['vendorId'] ?? '',
      vendorName: json['vendorName'] ?? '',
      totalProducts: json['totalProduct'] ?? 0,
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      totalSoldProducts: json['totalSoldProducts'] ?? 0,
      topSellingProducts:
          (json['topSellingProducts'] as List<dynamic>?)
                  ?.map((e) => GetAnalysisModelTopSellingProducts.fromJson(e))
                  .toList() ??
              [],
    );
  }
}

