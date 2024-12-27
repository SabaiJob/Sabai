import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

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
                "Help & Support",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'အကူအညီ',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(languageProvider.lan == 'English'
                ? 'How would you like to connect with us ?'
                : 'ကျွန်ုပ်တို့နှင့် ဘယ်လို ဆက်သွယ်လိုပါသလဲ?', 
                style: languageProvider.lan == 'English' ?
                const TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 15.63,
                ): const TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 14,
                ),),
                const SizedBox( 
                  height: 30,
                ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 139,
                  height: 139,
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFEBF6),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFFF3997),
                          width: 2,
                        ),
                        bottom: BorderSide(
                          color: Color(0xFFFF3997),
                          width: 2,
                        ),
                        left: BorderSide(
                          color: Color(0xFFFF3997),
                          width: 2,
                        ),
                        right: BorderSide(
                          color: Color(0xFFFF3997),
                          width: 2,
                        ),
                      )),
                ),
                Positioned(
                  right: -30,
                  bottom:-35,
                    child: Image.asset(
                  'images/support.png',
                  width: 200,
                  height: 200,
                )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border(
                    top: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    bottom: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    left: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    right: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                  )),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEBF6),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    CupertinoIcons.chat_bubble_text,
                    color: Color(0xFFFF3997),
                    size: 30,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageProvider.lan == 'English'
                          ? 'Chat with us'
                          : 'အီးမေး',
                      style: languageProvider.lan == 'English'
                          ? const TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 12.5,
                              color: Color(0xFF363B3F))
                          : const TextStyle(
                              fontFamily: 'Walone-B', fontSize: 11),
                    ),
                    const Text(
                      'support.sabaijobs@gmail.com',
                      style: TextStyle(
                          fontFamily: 'Bricolage-R',
                          fontSize: 10,
                          color: Color(0xFF6C757D)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border(
                    top: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    bottom: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    left: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    right: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                  )),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEBF6),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Icon(
                    CupertinoIcons.phone,
                    color: Color(0xFFFF3997),
                    size: 30,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      languageProvider.lan == 'English'
                          ? 'Call us'
                          : 'ဖုန်းနံပါတ်',
                      style: languageProvider.lan == 'English'
                          ? const TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 12.5,
                              color: Color(0xFF363B3F))
                          : const TextStyle(
                              fontFamily: 'Walone-B', fontSize: 11),
                    ),
                    Text(
                      languageProvider.lan == 'English'
                          ? '+66 789008893'
                          : '+၆၆ ၂၃၅၃၂၂၅၅၅',
                      style: languageProvider.lan == 'English'
                          ? const TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 10,
                              color: Color(0xFF6C757D))
                          : const TextStyle(
                              fontFamily: 'Walone-B', fontSize: 11, color: Color(0xFF6C757D)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  border: Border(
                    top: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    bottom: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    left: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                    right: BorderSide(color: Color(0xFFF0F1F2), width: 1.5),
                  )),
              child: ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFEBF6),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Image.asset('icons/line.png'),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('LINE',
                        style: TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 12.5,
                            color: Color(0xFF363B3F))),
                    Text(
                      languageProvider.lan == 'English'
                          ? '+66 789008893'
                          : '+၆၆ ၂၃၅၃၂၂၅၅၅',
                      style: languageProvider.lan == 'English'
                          ? const TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 10,
                              color: Color(0xFF6C757D))
                          : const TextStyle(
                              fontFamily: 'Walone-B',
                              fontSize: 11,
                              color: Color(0xFF6C757D)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
