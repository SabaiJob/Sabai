import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sabai_app/screens/registration_&_login_pages/token_service.dart';

class ApiService {
  static Future<Map<String, String>> getHeaders() async {
    final token = await TokenService.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<http.Response> get(String endPoint) async {
    final headers = await getHeaders();
    final response = await http.get(
      Uri.parse(
          'https://sabai-job-backend-k9wda.ondigitalocean.app/api$endPoint'),
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> post(String endPoint, dynamic body) async {
    final headers = await getHeaders();
    final response = await http.post(
      Uri.parse(
          'https://sabai-job-backend-k9wda.ondigitalocean.app/api$endPoint'),
      headers: headers,
      body: json.encode(body),
    );
    return response;
  }
}
