import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const String _apiKey = 'AIzaSyAD2C9SJP_ZBH5KrthnvLdYd14Wsm_FoGw';
  static const String _baseUrl = 'https://translation.googleapis.com/language/translate/v2';

  // ترجمة ذكية حسب اللغة
 static Future<String?> translateAuto(String text) async {
  final targetLang = isArabicText(text) ? 'tr' : 'ar';
  final url = Uri.parse('$_baseUrl?key=$_apiKey');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'q': text, 'target': targetLang}),
  );

  if (response.statusCode == 200) {
    final body = json.decode(response.body);
    final result = body['data']['translations'][0]['translatedText'];

    if (result != null && result.trim() != text.trim()) {
      return result;
    } else {
      return null; 
    }
  } else {
    print('Translation failed: ${response.body}');
    return null;
  }
}


  static Future<String?> translateText(String text, String targetLang) async {
    final url = Uri.parse('$_baseUrl?key=$_apiKey');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'q': text, 'target': targetLang}),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['data']['translations'][0]['translatedText'];
    } else {
      print('Translation failed: ${response.body}');
      return null;
    }
  }
}

// مساعد خارجي لاكتشاف النص العربي
bool isArabicText(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text);
}
