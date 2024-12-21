import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        title: languageProvider.lan == 'English'
            ? const Text(
                "Notifications",
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 19.53,
                ),
              )
            : const Text(
                "အသိပေးချက်များ",
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 19.53,
                ),
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xffFF3997),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/notification.png',
              width: 168,
              height: 298,
            ),
            languageProvider.lan == 'English'
                ? const Text(
                    "You're all caught up!",
                    style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 24.41,
                    ),
                  )
                : const Text(
                    "အသိပေးချက်အသစ်မရှိပါ",
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 24.41,
                    ),
                  ),
            languageProvider.lan == 'English'
                ? const Text(
                    "Check back later for updates.",
                    style: TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 15.63,
                    ),
                  )
                : const Text(
                    "နောက်ပိုင်းတွင် အပ်ဒိတ်များအတွက် ပြန်လည်စစ်ဆေးပါ။",
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 14,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
