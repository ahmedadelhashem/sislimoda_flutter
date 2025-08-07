// ملف: services/active_offers_server.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sislimoda_admin_dashboard/models/statistics/OfferModel.dart';

class ActiveOffersServer {
  static Future<List<ActiveOfferModel>> getActiveOffersByDateRange({
    required DateTime from,
    required DateTime to,
  }) async {
    final String baseUrl = "http://sislimoda.runasp.net";
    final String path = "/api/AdminOffersAnalytics/ActiveOffersByDateRange";

    final String startDate = from.toIso8601String().split('T').first;
    final String endDate = to.toIso8601String().split('T').first;
    final String fullUrl = "$baseUrl$path?startDate=$startDate&endDate=$endDate";

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List offers = jsonData['offers'];

      return offers.map((e) => ActiveOfferModel.fromJson(e)).toList();
    } else {
      throw Exception("❌ فشل في تحميل العروض الفعالة: ${response.statusCode}");
    }
  }
}
