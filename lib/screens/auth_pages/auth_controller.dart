import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabai_app/screens/auth_pages/api_service.dart';

class AuthController {
  Future<void> initialSignIn(
      {required BuildContext context,
      required String fullName,
      required String phoneNum,
      required String email,
      required String endPoint,
      required VoidCallback nextScreen}) async {
    try {
      final response =
          await http.post(Uri.parse('https://api.sabaijob.com/api$endPoint'),
              headers: await ApiService.getHeaders(),
              body: jsonEncode({
                "full_name": fullName,
                "phone": phoneNum,
                "email": email,
              }));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        nextScreen();
      } else {
        if (response.body.toString().contains('already exists')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User with this phone number already exists.'),
            ),
          );
        } else if (response.body.toString().contains('valid email')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter the correct email!'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter the essential information!'),
            ),
          );
        }
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
