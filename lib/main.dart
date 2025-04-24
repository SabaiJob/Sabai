import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/auth_pages/token_service.dart';
import 'package:sabai_app/services/general_provider.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/jobfilter_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/screens/walkthrough.dart';
import 'package:sabai_app/services/otp_code_timer_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';
import 'package:sabai_app/services/phone_number_provider.dart';
import 'package:sabai_app/services/quote_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuoteProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => JobProvider()),
        ChangeNotifierProvider(create: (context) => OtpCodeTimerProvider()),
        ChangeNotifierProvider(create: (context) => PhoneNumberProvider()),
        ChangeNotifierProvider(create: (context) => JobFilterProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => GeneralProvider())
      ],
      child: const Sabai(),
    ),
  );
}

class Sabai extends StatefulWidget {
  const Sabai({super.key});

  @override
  State<Sabai> createState() => _SabaiState();
}

class _SabaiState extends State<Sabai> {
  Future<Widget> _isUserLogin() async {
    final token = await TokenService.getToken();
    if (token == null) {
      return const Walkthrough();
    } else {
      return const NavigationHomepage();
    }
  }

  Future<void> getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission for iOS (no effect on Android)
    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await messaging.getToken();
      print("✅ FCM Token: $token");

      if (token != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('fcm_token', token);
      }

      // You can send this token to your backend server to send push notifications
    } else {
      print("❌ User declined or has not accepted permission");
    }
  }

  // // void fetchUserData() async {
  // //   final paymentProvider =
  // //       Provider.of<PaymentProvider>(context, listen: false);
  // //   try {
  // //     await paymentProvider.getProfileData(context);
  // //     // If we get here, token is valid
  // //   } catch (e) {
  // //     // If the API call fails due to auth issues, invalidate the token
  // //     if (e.toString().contains('401') ||
  // //         e.toString().contains('unauthorized')) {
  // //       await TokenService.deleteToken(); // Clear the invalid token
  // //     }
  // //   }
  // // }
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: child!);
      },
      home: FutureBuilder<Widget>(
        future: _isUserLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          return snapshot.data ?? const Walkthrough();
        },
      ),
    );
  }
}
