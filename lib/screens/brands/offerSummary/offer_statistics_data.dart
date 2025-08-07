// file: active_offer_summary_data.dart

import 'package:sislimoda_admin_dashboard/models/statistics/OfferModel.dart';
import 'package:sislimoda_admin_dashboard/screens/brands/offerSummary/offer_statistics_services.dart';

class ActiveOfferStats {
  final int totalOffers;
  final int percentageOffers;
  final int fixedOffers;
  final double totalAmount;
  final double averageAmount;

  ActiveOfferStats({
    required this.totalOffers,
    required this.percentageOffers,
    required this.fixedOffers,
    required this.totalAmount,
    required this.averageAmount,
  });
}

/// تحميل ملخص العروض في فترة محددة
Future<ActiveOfferStats?> loadOfferSummaryData({
  required DateTime from,
  required DateTime to,
}) async {
  try {
    final List<ActiveOfferModel> offers =
        await ActiveOffersServer.getActiveOffersByDateRange(from: from, to: to);

    final int percentageCount =
        offers.where((e) => e.offerType == 'نسبة مئوية').length;
    final int fixedCount =
        offers.where((e) => e.offerType == 'مبلغ ثابت').length;
    final double totalAmount =
        offers.fold(0.0, (sum, e) => sum + e.amount);
    final double avgAmount = offers.isNotEmpty
        ? totalAmount / offers.length
        : 0.0;

    return ActiveOfferStats(
      totalOffers: offers.length,
      percentageOffers: percentageCount,
      fixedOffers: fixedCount,
      totalAmount: totalAmount,
      averageAmount: avgAmount,
    );
  } catch (e, stack) {
    print('❌ خطأ في تحميل ملخص العروض: $e');
    print(stack);
    return null;
  }
}

/// تحميل قائمة العروض في فترة محددة
Future<List<ActiveOfferModel>> loadOfferList({
  required DateTime from,
  required DateTime to,
}) async {
  try {
    final List<ActiveOfferModel> offers =
        await ActiveOffersServer.getActiveOffersByDateRange(from: from, to: to);
    return offers;
  } catch (e, stack) {
    print('❌ خطأ في تحميل قائمة العروض: $e');
    print(stack);
    return [];
  }
}
