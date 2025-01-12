import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/screens/walkthrough.dart';
import 'package:sabai_app/services/otp_code_timer_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => JobProvider()),
        ChangeNotifierProvider(create: (context) => OtpCodeTimerProvider())
      ],
      child: const Sabai(),
    ),
  );
}

class Sabai extends StatelessWidget {
  const Sabai({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Walkthrough(),
    );
  }
}
