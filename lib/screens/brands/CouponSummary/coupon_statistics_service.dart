import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sislimoda_admin_dashboard/models/statistics/CouponStatisticsModel.dart';

class CouponStatisticsServer {
  static Future<List<CouponStatisticsModel>> getStatistics({
    required DateTime from,
    required DateTime to,
  }) async {
    final String baseUrl = "http://sislimoda.runasp.net";
    final String path = "/api/admin/coupon-statistics/summary";
    final String fullUrl =
        "$baseUrl$path?from=${from.toIso8601String().split('T').first}&to=${to.toIso8601String().split('T').first}";

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((e) => CouponStatisticsModel.fromJson(e))
          .toList();
    } else {
      throw Exception("فشل في تحميل البيانات: ${response.statusCode}");
    }
  }
}

class CouponStatisticsDailyUsageServer {
  static Future<List<CouponDailyUsageModel>> getDailyUsage({
    required DateTime from,
    required DateTime to,
  }) async {
    final String baseUrl = "http://sislimoda.runasp.net";
    final String path = "/api/admin/coupon-statistics/daily-usage";
    final String fullUrl =
        "$baseUrl$path?from=${from.toIso8601String().split('T').first}&to=${to.toIso8601String().split('T').first}";

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
                print("الرد: ${response.body}");

      return jsonData
          .map((e) => CouponDailyUsageModel.fromJson(e))
          .toList();
          
    } else {
      
      throw Exception("❌ فشل تحميل بيانات الاستخدام اليومي: ${response.statusCode}");
    }
  }
}
