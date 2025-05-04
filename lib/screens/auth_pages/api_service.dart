import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabai_app/screens/auth_pages/token_service.dart';
import 'package:sabai_app/screens/walkthrough.dart';

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
      // Uri.parse(
      //     'https://sabai-job-backend-k9wda.ondigitalocean.app/api$endPoint'),
      Uri.parse('https://api.sabaijob.com/api$endPoint'),
      headers: headers,
    );
    return response;
  }

  static Future<http.Response> post(String endPoint, dynamic body) async {
    final headers = await getHeaders();
    final response = await http.post(
      // Uri.parse(
      //     'https://sabai-job-backend-k9wda.ondigitalocean.app/api$endPoint'),
      Uri.parse('https://api.sabaijob.com/api$endPoint'),
      headers: headers,
      body: json.encode(body),
    );
    return response;
  }

  static Future<Response> putWithFile(String endPoint, {
    Map<String, dynamic>? data,
    File? photo,
  }) async {
    final dio = Dio();
    final headers = await getHeaders();

    try {
      FormData formData;
      
      if (photo != null) {
        formData = FormData.fromMap({
          ...data ?? {},
          'photo': await MultipartFile.fromFile(photo.path, filename: 'profile.jpg'),
        });
      } else {
        formData = FormData.fromMap(data ?? {});
      }

      final response = await dio.put(
        'https://api.sabaijob.com/api$endPoint',
        data: formData,
        options: Options(
          headers: headers,
          contentType: 'multipart/form-data',
        ),
      );

      return response;
    } catch (e) {
      throw e;
    }
  }


  static Future<http.Response> put(String endPoint, dynamic body) async {
    final headers = await getHeaders();
    final response = await http.put(
      // Uri.parse(
      //     'https://sabai-job-backend-k9wda.ondigitalocean.app/api$endPoint'),
      Uri.parse('https://api.sabaijob.com/api$endPoint'),
      headers: headers,
      body: json.encode(body),
    );
    return response;
  }

  

  static Future<void> logout(BuildContext context) async {
    await TokenService.deleteToken(); // Ensure token is removed
    
    // Debugging: Check if token is really deleted
    final token = await TokenService.getToken();
    if (token == null) {
      print("✅ Token deleted successfully.");
    } else {
      print("❌ Token still exists: $token");
    }

    // Navigate to login screen and remove all previous screens
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Walkthrough()),
      (route) => false,
    );
  }
}
