import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteProvider extends ChangeNotifier{
  List<Map<String, String>> _quotes = [];
  bool _isLoading = true;

  List<Map<String, String>> get quotes => _quotes;
  bool get isLoading => _isLoading;

  Future<void> fetchQuotes() async{
    try{
      final response = await http.get(Uri.parse('https://sabai-job-backend-k9wda.ondigitalocean.app/api/quotes/'));
      if(response.statusCode >= 200 && response.statusCode < 300){
        List<dynamic> responseData = jsonDecode(response.body);
        _quotes = responseData.map((quote)=>{
          'text': quote['text'] as String
        }).toList();
      }else{
        throw Exception("Failed to load quotes");
      }
    }catch(e){
      _quotes = [
        {'text': "Error loading quotes", 'author': ""}
      ];
    }
  }
}