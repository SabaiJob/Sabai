import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';

class GeneralProvider extends ChangeNotifier {
  int _notiCount = 0;
  int get notiCount => _notiCount;

  bool _help = false;
  bool get help => _help;
  void sethelp(bool value){
    _help = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> _noti = [];
  List<Map<String, dynamic>> get noti => _noti;
  bool isLoading = true;
  Future<void> loadNotification() async {
    try {
      isLoading = true;
      notifyListeners(); //
      final response = await ApiService.get('/notifications/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = json.decode(response.body);
        _notiCount = data['count'];
        notifyListeners();

        List<Map<String, dynamic>> notiList =
            data['results'].map<Map<String, dynamic>>((item) {
          return {
            'title': item['text'] ?? 'No title',
            'time': item['created_at'] ?? 'Unknown time',
            'type': item['type'] ?? 'none'
          };
        }).toList();
        _noti = notiList;
        notifyListeners();
        //print(_noti);
        //return noti;
      } else {
        print('error ${response.body}');
        //return [];
      }
    } catch (e) {
      print('Error : $e');
      //return [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
