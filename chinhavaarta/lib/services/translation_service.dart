import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  static const String _apiUrl = "https://libretranslate.com/translate";
  static const String _apiKey = "your_api_key"; // Optional: if needed for your custom instance

  // Fetch translation from API with alternatives
  static Future<String> fetchTranslation(String text, String targetLanguage) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "q": text, // Text to translate
          "source": "auto", // Auto-detect source language
          "target": targetLanguage, // Target language code
          "format": "text", // Text format
          "alternatives": 3, // Number of alternatives (optional)
          "api_key": _apiKey, // Your API key (optional)
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List && data.isNotEmpty) {
          return data[0]['translatedText'] ?? text; // Return translated text
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("API request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching translation: $e");
      print("Response body: ${response.body}"); // Log the response body for debugging
      return text; // Return original text in case of an error
    }
  }
}
