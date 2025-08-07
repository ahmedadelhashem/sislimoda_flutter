import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sislimoda_admin_dashboard/models/statistics/vendorstatistics.dart';

class VendorStatisticsService {
  static const String baseUrl = "http://sislimoda.runasp.net";

  static Future<List<VendorSalesStatsModel>> getVendorSalesStats({
    required DateTime from,
    required DateTime to,
  }) async {
    final url = Uri.parse('$baseUrl/api/vendor-statistics/sales/by-vendor?from=${_formatDate(from)}&to=${_formatDate(to)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => VendorSalesStatsModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل تحميل مبيعات البائعين');
    }
  }

  static Future<List<DailySalesModel>> getDailySalesStats({
    required DateTime from,
    required DateTime to,
  }) async {
    final url = Uri.parse('$baseUrl/api/vendor-statistics/sales/daily?from=${_formatDate(from)}&to=${_formatDate(to)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => DailySalesModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل تحميل المبيعات اليومية');
    }
  }

  static Future<List<TopProductModel>> getTopProducts({
    required DateTime from,
    required DateTime to,
    int top = 5,
  }) async {
    final url = Uri.parse('$baseUrl/api/vendor-statistics/top-products?from=${_formatDate(from)}&to=${_formatDate(to)}&top=$top');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => TopProductModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل تحميل المنتجات الأعلى مبيعًا');
    }
  }

  static Future<DashboardStatsModel> getVendorDashboardStats({
    required String vendorId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final url = Uri.parse('$baseUrl/api/VendorStatistics/DashboardStats?vendorId=$vendorId&startDate=${_formatDate(startDate)}&endDate=${_formatDate(endDate)}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return DashboardStatsModel.fromJson(data);
    } else {
      throw Exception('فشل تحميل إحصائيات لوحة تحكم البائع');
    }
  }

  static Future<ProductsCountModel> getVendorProductsCount({
    required String vendorId,
  }) async {
    final url = Uri.parse('$baseUrl/api/VendorStatistics/ProductsCount?vendorId=$vendorId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return ProductsCountModel.fromJson(data);
    } else {
      throw Exception('فشل تحميل عدد المنتجات');
    }
  }

  static String _formatDate(DateTime date) {
    return date.toIso8601String().split('T').first;
  }
}
