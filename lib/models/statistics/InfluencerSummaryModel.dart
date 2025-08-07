class TopSellingProduct {
  final String productId;
  final String productName;
  final int totalSold;

  TopSellingProduct({
    required this.productId,
    required this.productName,
    required this.totalSold,
  });

  factory TopSellingProduct.fromJson(Map<String, dynamic> json) {
    return TopSellingProduct(
      productId: json['productId'],
      productName: json['productName'],
      totalSold: json['totalSold'],
    );
  }
}

class InfluencerSummaryModel {
  final String influencerId;
  final String? influencerName;
  final int totalSoldProducts;
  final double totalRevenue;
  final int totalProduct;
  final List<TopSellingProduct> topSellingProducts;

  InfluencerSummaryModel({
    required this.influencerId,
    required this.influencerName,
    required this.totalSoldProducts,
    required this.totalRevenue,
    required this.totalProduct,
    required this.topSellingProducts,
  });

  factory InfluencerSummaryModel.fromJson(Map<String, dynamic> json) {
    var list = (json['topSellingProducts'] as List)
        .map((e) => TopSellingProduct.fromJson(e))
        .toList();

    return InfluencerSummaryModel(
      influencerId: json['influencerId'],
      influencerName: json['influencerName'],
      totalSoldProducts: json['totalSoldProducts'],
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
      totalProduct: json['totalProduct'],
      topSellingProducts: list,
    );
  }
}
