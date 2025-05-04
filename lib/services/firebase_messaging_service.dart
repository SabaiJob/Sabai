import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sabai_app/screens/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessagingService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> init() async {
    // Request permissions
    NotificationSettings settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // Get token and save it
      String? token = await _messaging.getToken();
      if (token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', token);
        print("✅ FCM Token: $token");
      }

      // Handle token refresh
      _messaging.onTokenRefresh.listen((newToken) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', newToken);
        print("🔁 Token refreshed: $newToken");
      });
    } else {
      print('❌ User declined or has not accepted permission');
    }
  }

  // Call this from your widget tree where context is available
  static void setupInteractedMessage(BuildContext context) {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('✅ Message received in foreground: ${message.notification?.title}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('You Have a new notification!'),
          ),
        );
      }
    });

    // Handle app opened from background notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          '📨 App opened from background notification: ${message.notification?.title}');
      //Navigate to Notification
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NotificationPage(),
        ),
      );
    });
  }

  // Call this to check for initial message when app launches
  static Future<void> checkInitialMessage(BuildContext context) async {
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      print(
          '🚀 App opened from terminated state with notification: ${initialMessage.notification?.title}');
      // You can navigate based on initialMessage
    }
  }
}
