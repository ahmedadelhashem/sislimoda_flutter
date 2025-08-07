import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sislimoda_admin_dashboard/models/statistics/InfluencerSummaryModel.dart';

Future<List<InfluencerSummaryModel>> getAllInfluencersSummary({
  required DateTime from,
  required DateTime to,
}) async {
  final String fromDate = from.toIso8601String().split('T').first;
  final String toDate = to.toIso8601String().split('T').first;

  final Uri url = Uri.parse(
    'http://sislimoda.runasp.net/api/admin/influencer-statistics/all-influencers-summary?from=$fromDate&to=$toDate',
  );

  final response = await http.get(url, headers: {
    'accept': 'application/json',
  });

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data
        .map((json) => InfluencerSummaryModel.fromJson(json))
        .toList();
  } else {
    throw Exception('فشل في تحميل بيانات المؤثرين');
  }
}
