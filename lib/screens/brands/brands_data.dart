import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sislimoda_admin_dashboard/components/custom_items_cubits/loading_cubit/loading_cubit.dart';
import 'package:sislimoda_admin_dashboard/components/custom_pops.dart';
import 'package:sislimoda_admin_dashboard/cubits/generic_cubit/generic_cubit.dart';
import 'package:sislimoda_admin_dashboard/models/statistics/vendor_product_stat.dart';
import 'package:sislimoda_admin_dashboard/models/statistics/vendorstatistics.dart';
import 'package:sislimoda_admin_dashboard/services/app_services.dart';

mixin VendorStatisticsData {
  final Loading loading = Loading();

  GenericCubit<List<GetAnalysisModelTopSellingProducts>> topSellingProductsCubit =
      GenericCubit<List<GetAnalysisModelTopSellingProducts>>();

  GenericCubit<List<VendorModel>> vendorsCubit = GenericCubit<List<VendorModel>>();
  GenericCubit<List<VendorSalesStatsModel>> vendorsStatsCubit = GenericCubit<List<VendorSalesStatsModel>>();


  int totalSoldProducts = 0;
  double totalRevenue = 0.0;
  int totalProduct = 0;

  Future<void> getAllVendors() async {
    try {
      final result = await AppService.callService(
        actionType: ActionType.get,
        apiName: 'api/Vendor/GetAll',
        body: null,
      );

      result.fold((response) {
        final List<dynamic> jsonData = jsonDecode(response);
        final vendors = jsonData.map((e) => VendorModel.fromJson(e)).toList();
        vendorsCubit.update(data: vendors);
      }, (error) {
        showErrorMessage(message: error.message);
      });
    } catch (e) {
      showErrorMessage(message: 'حدث خطأ أثناء تحميل البائعين.');
    }
  }

  Future<void> getVendorStatistics(String vendorId) async {
    loading.show;

    try {
      final result = await AppService.callService(
        actionType: ActionType.get,
        apiName: 'api/Vendor/GetVendorStatistics?vendorId=$vendorId',
        body: null,
      );

      result.fold((response) {
        try {
          final Map<String, dynamic> jsonData = jsonDecode(response);

          final List<dynamic> productsJson = jsonData['topSellingProducts'] ?? [];
          final products = productsJson
              .map((e) => GetAnalysisModelTopSellingProducts.fromJson(e))
              .toList();

          topSellingProductsCubit.update(data: products);

          totalSoldProducts = jsonData['totalSoldProducts'] ?? 0;
          totalRevenue = (jsonData['totalRevenue'] ?? 0).toDouble();
          totalProduct = jsonData['totalProduct'] ?? 0;
        } catch (e) {
          showErrorMessage(message: 'فشل في قراءة البيانات من الخادم.');
        }
      }, (error) {
        showErrorMessage(message: error.message);
      });
    } catch (e) {
      showErrorMessage(message: 'حدث خطأ غير متوقع.');
    } finally {
      loading.hide;
    }
  }
  Future<void> getAllVendorsStatistics({
  required DateTime from,
  required DateTime to,
}) async {
  loading.show;

  try {
    final String fromStr = _formatDate(from);
    final String toStr = _formatDate(to);
    final String url = 'http://sislimoda.runasp.net/api/vendor-statistics/sales/by-vendor?from=$fromStr&to=$toStr';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      final List<VendorSalesStatsModel> vendors = jsonData
          .map((e) => VendorSalesStatsModel.fromJson(e))
          .toList();
        vendorsStatsCubit.update(data: vendors);


      totalSoldProducts = vendors.fold(0, (sum, e) => sum + e.totalProductsSold);
      totalRevenue = vendors.fold(0.0, (sum, e) => sum + e.totalSales);
      totalProduct = vendors.length;
    } else {
      showErrorMessage(message: 'فشل في تحميل البيانات: ${response.statusCode}');
    }
  } catch (e) {
    showErrorMessage(message: 'حدث خطأ أثناء تحميل البيانات: $e');
  } finally {
    loading.hide;
  }
}

String _formatDate(DateTime date) {
  return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
}
}
