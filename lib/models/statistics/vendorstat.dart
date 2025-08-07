import 'package:sislimoda_admin_dashboard/models/analysis/get_analysis_model.dart';

class GetAnalysisModel {
  List<GetAnalysisModelTopSellingProducts>? topSellingProducts;
  int? totalSoldProducts;
  double? totalRevenue;
  int? totalProduct;

  GetAnalysisModel({
    this.topSellingProducts,
    this.totalSoldProducts,
    this.totalRevenue,
    this.totalProduct,
  });

  factory GetAnalysisModel.fromJson(Map<String, dynamic> json) {
    return GetAnalysisModel(
      topSellingProducts: (json['topSellingProducts'] as List<dynamic>?)
          ?.map((e) => GetAnalysisModelTopSellingProducts.fromJson(e))
          .toList(),
      totalSoldProducts: json['totalSoldProducts'],
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble(),
      totalProduct: json['totalProduct'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topSellingProducts':
          topSellingProducts?.map((e) => e.toJson()).toList(),
      'totalSoldProducts': totalSoldProducts,
      'totalRevenue': totalRevenue,
      'totalProduct': totalProduct,
    };
  }
}
