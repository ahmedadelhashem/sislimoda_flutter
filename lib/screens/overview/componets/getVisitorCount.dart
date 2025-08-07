import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int?> getVisitorCount() async {
  try {
    final response = await http.get(
      Uri.parse("http://sislimoda.runasp.net/Count"),
      headers: {
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['count'];
    } else {
      print("Error: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}
