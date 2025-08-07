import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sislimoda_admin_dashboard/models/statistics/vendor_product_stat.dart';

class VendorService {
  static Future<List<VendorModel>> getAllVendors() async {
    final url = Uri.parse("http://sislimoda.runasp.net/api/Vendor/GetAll");

    final response = await http.get(url, headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => VendorModel.fromJson(e)).toList();
    } else {
      throw Exception("❌ فشل في تحميل قائمة البائعين");
    }
  }
}
