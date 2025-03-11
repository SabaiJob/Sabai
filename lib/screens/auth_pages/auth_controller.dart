import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sabai_app/screens/auth_pages/api_service.dart';

class AuthController {
  Future<void> initialSignIn(
      {required BuildContext context,
      required String fullName,
      required String phoneNum,
      required String endPoint,
      required VoidCallback nextScreen
      }) async {
        try{
          final response = await http.post(Uri.parse('https://sabai-job-backend-k9wda.ondigitalocean.app/api$endPoint'),headers: await ApiService.getHeaders(), body: jsonEncode({
            "full_name" : fullName,
            "phone" : phoneNum,
          }) );
          if(response.statusCode >= 200 && response.statusCode < 300){
            nextScreen();
          }else{
            print(response.body);
          }
        }catch(e){
          print(e);
        }
      }
}
