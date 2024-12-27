import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';

class RoseCountPage extends StatelessWidget {
  const RoseCountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
       backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: languageProvider.lan == 'English'
            ? const Text(
                "Your roses",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ကျွန်တော့်နှင်းဆီပွင့်များ',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
    );
  }
}