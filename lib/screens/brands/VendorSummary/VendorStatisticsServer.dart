import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sislimoda_admin_dashboard/models/statistics/vendorstat.dart'; 

class VendorStatisticsServer {
  static Future<GetAnalysisModel> getStatistics({
    required String vendorId,
    required DateTime from,
    required DateTime to,
  }) async {
    final String baseUrl = "http://sislimoda.runasp.net";
    final String path = "/api/Vendor/GetVendorStatistics";
    final String fullUrl =
        "$baseUrl$path?vendorId=$vendorId&from=${from.toIso8601String().split('T').first}&to=${to.toIso8601String().split('T').first}";

    final response = await http.get(
      Uri.parse(fullUrl),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return GetAnalysisModel.fromJson(jsonData);
    } else {
      throw Exception("❌ فشل في تحميل إحصائيات البائع: ${response.statusCode}");
    }
  }
}
