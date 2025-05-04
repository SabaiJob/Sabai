// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sabai_app/firebase_options.dart';
// import 'package:sabai_app/screens/navigation_homepage.dart';
// import 'package:sabai_app/screens/auth_pages/token_service.dart';
// import 'package:sabai_app/services/firebase_messaging_service.dart';
// import 'package:sabai_app/services/general_provider.dart';
// import 'package:sabai_app/services/job_provider.dart';
// import 'package:sabai_app/services/jobfilter_provider.dart';
// import 'package:sabai_app/services/language_provider.dart';
// import 'package:sabai_app/screens/walkthrough.dart';
// import 'package:sabai_app/services/otp_code_timer_provider.dart';
// import 'package:sabai_app/services/payment_provider.dart';
// import 'package:sabai_app/services/phone_number_provider.dart';
// import 'package:sabai_app/services/quote_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// // Future<void> _firebaseMessagingbackgroungHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   print('handling bg msg: ${message.messageId}');
// //   print('Messgae data ${message.data}');
// // }
//
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   print('🔵 Handling a background message: ${message.messageId}');
//   print('🔵 Message Data: ${message.data}');
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   // await FirebaseMessagingService().initNotification();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => QuoteProvider()),
//         ChangeNotifierProvider(create: (context) => LanguageProvider()),
//         ChangeNotifierProvider(create: (context) => JobProvider()),
//         ChangeNotifierProvider(create: (context) => OtpCodeTimerProvider()),
//         ChangeNotifierProvider(create: (context) => PhoneNumberProvider()),
//         ChangeNotifierProvider(create: (context) => JobFilterProvider()),
//         ChangeNotifierProvider(create: (context) => PaymentProvider()),
//         ChangeNotifierProvider(create: (context) => GeneralProvider())
//       ],
//       child: const Sabai(),
//     ),
//   );
// }
//
// class Sabai extends StatefulWidget {
//   const Sabai({super.key});
//
//   @override
//   State<Sabai> createState() => _SabaiState();
// }
//
// class _SabaiState extends State<Sabai> {
//   Future<Widget> _isUserLogin() async {
//     final token = await TokenService.getToken();
//     if (token == null) {
//       return const Walkthrough();
//     } else {
//       return const NavigationHomepage();
//     }
//   }
//
//   Future<void> getDeviceToken() async {
//     FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//     // Request permission for iOS (no effect on Android)
//     NotificationSettings settings = await messaging.requestPermission();
//
//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       String? token = await messaging.getToken();
//       print("✅ FCM Token: $token");
//
//       if (token != null) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('fcm_token', token);
//       }
//
//       // You can send this token to your backend server to send push notifications
//     } else {
//       print("❌ User declined or has not accepted permission");
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getDeviceToken();
//     FirebaseMessagingService.init(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       builder: (context, child) {
//         return MediaQuery(
//             data: MediaQuery.of(context)
//                 .copyWith(textScaler: const TextScaler.linear(1.0)),
//             child: child!);
//       },
//       home: FutureBuilder<Widget>(
//         future: _isUserLogin(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Scaffold(
//                 body: Center(child: CircularProgressIndicator()));
//           }
//           return snapshot.data ?? const Walkthrough();
//         },
//       ),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/firebase_options.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/screens/auth_pages/token_service.dart';
import 'package:sabai_app/services/firebase_messaging_service.dart';
import 'package:sabai_app/services/general_provider.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/jobfilter_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/screens/walkthrough.dart';
import 'package:sabai_app/services/otp_code_timer_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';
import 'package:sabai_app/services/phone_number_provider.dart';
import 'package:sabai_app/services/quote_provider.dart';

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('🔵 Handling a background message: ${message.messageId}');
  print('🔵 Message Data: ${message.data}');
  // You can perform background tasks here, but avoid UI-related operations
}

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Set foreground notification presentation options (for iOS)
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Show alert
    badge: true, // Update badge
    sound: true, // Play sound
  );

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
  // Check if user is logged in
  Future<Widget> _isUserLogin() async {
    final token = await TokenService.getToken();
    return token == null ? const Walkthrough() : const NavigationHomepage();
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  Future<void> _initializeFirebaseMessaging() async {
    // Initialize Firebase Messaging service
    await FirebaseMessagingService.init();

    // For iOS - request permission with more options
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
      // home: FutureBuilder<Widget>(
      //   future: _isUserLogin(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Scaffold(
      //         body: Center(child: CircularProgressIndicator()),
      //       );
      //     }
      //     return snapshot.data ?? const Walkthrough();
      //   },
      // ),
      home: FutureBuilder<Widget>(
        future: _isUserLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return FirebaseMessageHandler(
            child: snapshot.data ?? const Walkthrough(),
          );
        },
      ),
    );
  }
}

class FirebaseMessageHandler extends StatefulWidget {
  final Widget child;
  const FirebaseMessageHandler({required this.child, super.key});

  @override
  State<FirebaseMessageHandler> createState() => _FirebaseMessageHandlerState();
}

class _FirebaseMessageHandlerState extends State<FirebaseMessageHandler> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FirebaseMessagingService.setupInteractedMessage(context);
      FirebaseMessagingService.checkInitialMessage(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
