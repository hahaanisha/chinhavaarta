import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendQuizResults(String email, int score) async {
  // Kestra API endpoint
  final url = Uri.parse('http://localhost:8084/api/v1/executions/company.team/send_quiz_results');

  try {
    // Create the multipart request
    var request = http.MultipartRequest('POST', url);

    // Add fields (inputs)
    request.fields['email'] = email;
    request.fields['score'] = score.toString();

    // Send the request
    var response = await request.send();

    // Handle the response
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Quiz results sent successfully!");
    } else {
      print("Failed to send quiz results. Status code: ${response.statusCode}");
      print(await response.stream.bytesToString());
    }
  } catch (e) {
    print("Error sending quiz results: $e");
  }
}
