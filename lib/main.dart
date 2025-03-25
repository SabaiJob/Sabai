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

void main() {
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
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }

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
