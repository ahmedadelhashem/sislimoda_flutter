// file: coupon_summary_data.dart

import 'package:sislimoda_admin_dashboard/models/statistics/CouponStatisticsModel.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/CouponSummary/coupon_statistics_service.dart';

class CouponSummaryStats {
  final int totalUses;
  final double totalDiscount;
  final double totalSalesViaCoupon;
  final double totalInfluencerProfit;
  final double totalSystemProfit;

  CouponSummaryStats({
    required this.totalUses,
    required this.totalDiscount,
    required this.totalSalesViaCoupon,
    required this.totalInfluencerProfit,
    required this.totalSystemProfit,
  });
}

Future<CouponSummaryStats?> loadCouponSummaryData({
  required DateTime from,
  required DateTime to,
}) async {
  try {
    final List<CouponStatisticsModel> list = await CouponStatisticsServer.getStatistics(
      from: from,
      to: to,
    );

    final int totalUses = list.fold(0, (sum, c) => sum + c.totalUses);
    final double totalDiscount = list.fold(0.0, (sum, c) => sum + c.totalDiscount);
    final double totalSales = list.fold(0.0, (sum, c) => sum + c.totalSalesViaCoupon);
    final double totalInfluencerProfit = list.fold(0.0, (sum, c) => sum + c.influencerProfit);
    final double totalSystemProfit = list.fold(0.0, (sum, c) => sum + c.systemProfit);



    return CouponSummaryStats(
      totalUses: totalUses,
      totalDiscount: totalDiscount,
      totalSalesViaCoupon: totalSales,
      totalInfluencerProfit: totalInfluencerProfit,
      totalSystemProfit: totalSystemProfit,
    );
  } catch (e, stack) {
    print('❌ حدث خطأ أثناء تحميل ملخص الكوبونات: $e');
    print(stack);
    return null;
  }
}

Future<List<CouponDailyUsageModel>> loadCouponDailyUsage({
  required DateTime from,
  required DateTime to,
}) async {
  try {
    final List<CouponDailyUsageModel> list =
        await CouponStatisticsDailyUsageServer.getDailyUsage(
      from: from,
      to: to,
    );

    return list;
  } catch (e, stack) {
    print('❌ حدث خطأ أثناء تحميل الاستخدام اليومي للكوبونات: $e');
    print(stack);
    return [];
  }
}

