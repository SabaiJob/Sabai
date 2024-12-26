import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/screens/bottom_navi_pages/job_listing_page.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/services/language_provider.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationHomepage(
            showButtonSheet: true,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/success_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarGlow(
                glowColor: Colors.pinkAccent,
                child: Container(
                  width: 94,
                  height: 94,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffFF3997),
                  ),
                  child: const Icon(
                    CupertinoIcons.check_mark,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'Take a bow',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 30.52,
                      ),
                    )
                  : const Text(
                      'အလုပ်ကိုင်တွေရှာကြစို့',
                      style: TextStyle(
                        fontFamily: 'Walone-B',
                        fontSize: 30.52,
                      ),
                    ),
              const SizedBox(
                height: 10,
              ),
              languageProvider.lan == 'English'
                  ? const Text(
                      'Congratulations! Your profile is all set up.',
                      style: TextStyle(
                        fontFamily: 'Bricolage-R',
                        fontSize: 15.63,
                      ),
                    )
                  : const Text(
                      'သင့်ပရိုဖိုင်ကို ပြင်ဆင်ပြီးပါပြီ.',
                      style: TextStyle(
                        fontFamily: 'Walone-B',
                        fontSize: 14,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
