import 'dart:convert';

class CouponStatisticsModel {
  final String couponId;
  final String couponCode;
  final String? influencerName;
  final int totalUses;
  final double totalDiscount;
  final double totalSalesViaCoupon;
  final double profitPercentage;
  final double systemProfit;
  final double influencerProfit;
  final double influencerPercentage;
  final double systemPercentage;
  final double discountPercent;

  CouponStatisticsModel({
    required this.couponId,
    required this.couponCode,
    required this.influencerName,
    required this.totalUses,
    required this.totalDiscount,
    required this.totalSalesViaCoupon,
    required this.profitPercentage,
    required this.systemProfit,
    required this.influencerProfit,
    required this.influencerPercentage,
    required this.systemPercentage,
    required this.discountPercent,
  });

  factory CouponStatisticsModel.fromJson(Map<String, dynamic> json) {
    return CouponStatisticsModel(
      couponId: json['couponId'],
      couponCode: json['couponCode'],
      influencerName: json['influencerName'],
      totalUses: json['totalUses'],
      totalDiscount: (json['totalDiscount'] as num).toDouble(),
      totalSalesViaCoupon: (json['totalSalesViaCoupon'] as num).toDouble(),
      profitPercentage: (json['profitPercentage'] as num).toDouble(),
      systemProfit: (json['systemProfit'] as num).toDouble(),
      influencerProfit: (json['influencerProfit'] as num).toDouble(),
      influencerPercentage: (json['influencerPercentage'] as num).toDouble(),
      systemPercentage: (json['systemPercentage'] as num).toDouble(),
      discountPercent: (json['discountPercent'] as num).toDouble(),
    );
  }
}

class CouponDailyUsageModel {
  final String couponId;
  final String couponCode;
  final String? influencerName;
  final int uses;
  final double totalDiscount;
  final double totalSalesViaCoupon;
  final double profitPercentage;
  final double systemProfit;
  final double influencerProfit;
  final double influencerPercentage;
  final double systemPercentage;
  final double discountPercent;

  CouponDailyUsageModel({
    required this.couponId,
    required this.couponCode,
    required this.influencerName,
    required this.uses,
    required this.totalDiscount,
    required this.totalSalesViaCoupon,
    required this.profitPercentage,
    required this.systemProfit,
    required this.influencerProfit,
    required this.influencerPercentage,
    required this.systemPercentage,
    required this.discountPercent,
  });

  factory CouponDailyUsageModel.fromJson(Map<String, dynamic> json) {
    return CouponDailyUsageModel(
      couponId: json['couponId'] ?? '',
      couponCode: json['couponCode'] ?? '',
      influencerName: json['influencerName'],
      uses: json['uses'] ?? 0,
      totalDiscount: (json['totalDiscount'] ?? 0).toDouble(),
      totalSalesViaCoupon: (json['totalSalesViaCoupon'] ?? 0).toDouble(),
      profitPercentage: (json['profitPercentage'] ?? 0).toDouble(),
      systemProfit: (json['systemProfit'] ?? 0).toDouble(),
      influencerProfit: (json['influencerProfit'] ?? 0).toDouble(),
      influencerPercentage: (json['influencerPercentage'] ?? 0).toDouble(),
      systemPercentage: (json['systemPercentage'] ?? 0).toDouble(),
      discountPercent: (json['discountPercent'] ?? 0).toDouble(),
    );
  }
}
