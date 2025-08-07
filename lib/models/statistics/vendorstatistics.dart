class VendorSalesStatsModel {
  final String vendorId;
  final String vendorName;
  final double totalSales;
  final int totalOrders;
  final double totalProfit;
  final int totalProductsSold;

  VendorSalesStatsModel({
    required this.vendorId,
    required this.vendorName,
    required this.totalSales,
    required this.totalOrders,
    required this.totalProfit,
    required this.totalProductsSold,
  });

factory VendorSalesStatsModel.fromJson(Map<String, dynamic> json) {
  return VendorSalesStatsModel(
    vendorId: json["vendorId"],
    vendorName: json["vendorName"],
    totalSales: (json["totalSales"] as num).toDouble(),
    totalOrders: json["totalOrders"],
    totalProfit: (json["totalProfit"] as num).toDouble(),
    totalProductsSold: json["totalProductsSold"],
  );
}

}

class DailySalesModel {
  final DateTime date;
  final String vendorName;
  final double totalSales;
  final int totalOrders;
  final double totalProfit;
  final int totalProductsSold;

  DailySalesModel({
    required this.date,
    required this.vendorName,
    required this.totalSales,
    required this.totalOrders,
    required this.totalProfit,
    required this.totalProductsSold,
  });

  factory DailySalesModel.fromJson(Map<String, dynamic> json) {
    return DailySalesModel(
      date: DateTime.parse(_fixDateFormat(json['date'] ?? '')),
      vendorName: json['vendorName'] ?? '',
      totalSales: (json['totalSales'] ?? 0).toDouble(),
      totalOrders: json['totalOrders'] ?? 0,
      totalProfit: (json['totalProfit'] ?? 0).toDouble(),
      totalProductsSold: json['totalProductsSold'] ?? 0,
    );
  }

  static String _fixDateFormat(String raw) {
    try {
      final parts = raw.split(' ')[0].split('-');
      return '${parts[2]}-${parts[1]}-${parts[0]}T00:00:00.000';
    } catch (_) {
      return DateTime.now().toIso8601String(); // fallback
    }
  }
}


class TopProductModel {
  final String productId;
  final String vendorName;
  final String productName;
  final int totalSold;
  final double totalSales;
  final double totalProfit;

  TopProductModel({
    required this.productId,
    required this.vendorName,
    required this.productName,
    required this.totalSold,
    required this.totalSales,
    required this.totalProfit,
  });

  factory TopProductModel.fromJson(Map<String, dynamic> json) {
    return TopProductModel(
      productId: json['productId'] ?? '',
      vendorName: json['vendorName'] ?? '',
      productName: json['productName'] ?? '',
      totalSold: json['totalSold'] ?? 0,
      totalSales: (json['totalSales'] ?? 0).toDouble(),
      totalProfit: (json['totalProfit'] ?? 0).toDouble(),
    );
  }
}

class DashboardStatsModel {
  final int productsCount;
  final int ordersCount;
  final double totalSales;
  final double totalRevenue;
  final List<TopProductSummaryModel> topProducts;
  final DateRangeModel dateRange;

  DashboardStatsModel({
    required this.productsCount,
    required this.ordersCount,
    required this.totalSales,
    required this.totalRevenue,
    required this.topProducts,
    required this.dateRange,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return DashboardStatsModel(
      productsCount: json['productsCount'] ?? 0,
      ordersCount: json['ordersCount'] ?? 0,
      totalSales: (json['totalSales'] ?? 0).toDouble(),
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
      topProducts: (json['topProducts'] as List<dynamic>? ?? [])
          .map((e) => TopProductSummaryModel.fromJson(e))
          .toList(),
      dateRange: DateRangeModel.fromJson(json['dateRange'] as Map<String, dynamic>? ?? {}),
    );
  }
}

class TopProductSummaryModel {
  final String productId;
  final String productName;
  final int totalSold;

  TopProductSummaryModel({
    required this.productId,
    required this.productName,
    required this.totalSold,
  });

  factory TopProductSummaryModel.fromJson(Map<String, dynamic> json) {
    return TopProductSummaryModel(
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      totalSold: json['totalSold'] ?? 0,
    );
  }
}

class DateRangeModel {
  final DateTime startDate;
  final DateTime endDate;

  DateRangeModel({
    required this.startDate,
    required this.endDate,
  });

  factory DateRangeModel.fromJson(Map<String, dynamic> json) {
    DateTime parse(String raw) {
      // raw format: "dd-MM-yyyy HH:mm:ss"
      final parts = raw.split(' ')[0].split('-');
      return DateTime.parse('${parts[2]}-${parts[1]}-${parts[0]}T00:00:00');
    }

    return DateRangeModel(
      startDate: parse(json['startDate'] ?? ''),
      endDate: parse(json['endDate'] ?? ''),
    );
  }
}

class ProductsCountModel {
  final int productsCount;

  ProductsCountModel({required this.productsCount});

  factory ProductsCountModel.fromJson(Map<String, dynamic> json) {
    return ProductsCountModel(
      productsCount: json['productsCount'] ?? 0,
    );
  }
}
