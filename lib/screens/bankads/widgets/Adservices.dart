import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';  
import 'package:multi_dropdown/models/value_item.dart';
import 'package:sislimoda_admin_dashboard/screens/bankads/AdModel.dart';
import 'package:http_parser/http_parser.dart';

class AdServices {
  static const String baseUrl = "http://sislimoda.runasp.net";

  static Future<List<AdModel>> fetchAds() async {
    final uri = Uri.parse("$baseUrl/api/Ads/all");
    final response = await http.get(uri, headers: {
      'accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => AdModel.fromJson(e)).toList();
    } else {
      throw Exception('فشل تحميل الإعلانات من السيرفر');
    }
  }
static Future<void> addAd({
  required XFile image,
  required ValueItem country,
}) async {
  final uri = Uri.parse("$baseUrl/api/Ads/UploadAd");

  print("Selected Country: ${country.value}");
  print("Image Name: ${image.name}");

  final request = http.MultipartRequest('POST', uri)
    ..fields['country'] = country.value;

  final bytes = await image.readAsBytes();

  request.files.add(
    http.MultipartFile.fromBytes(
      'image',
      bytes,
      filename: image.name,
      contentType: MediaType('image', 'jpeg'), 
    ),
  );

  request.headers.addAll({
    "Accept": "application/json",
  });

  final response = await request.send();
  final responseBody = await response.stream.bytesToString();

  print("Status: ${response.statusCode}");
  print("Response Body: $responseBody");

  if (response.statusCode != 200) {
    throw Exception('فشل رفع الإعلان:\n$responseBody');
  }
}


}
