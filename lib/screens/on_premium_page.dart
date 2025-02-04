import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';

import '../constants.dart';

class OnPremiumPackage extends StatelessWidget {
  const OnPremiumPackage({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
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
                "Pricing Details",
                style: appBarTitleStyleEng,
              )
            : const Text(
                'ပရိုဖိုင်',
                style: appBarTitleStyleMn,
              ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Gold Coin Image
            const Image(
              image: AssetImage('images/coin.png'),
              width: 113,
              height: 114,
            ),
            const SizedBox(
              height: 10,
            ),
            // Current Package Name
            const Text(
              '3 Months Package',
              style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 15.6,
                  color: Color(0xFF161719)),
            ),
            const SizedBox(
              height: 10,
            ),
            // Package Valid Date
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                  text: 'Expired Date : ',
                  style: TextStyle(
                    fontFamily: 'Bricolage-R',
                    fontSize: 12.5,
                    color: Color(0xFF616971),
                  ),
                ),
                TextSpan(
                  text: '12 February, 2025',
                  style: TextStyle(
                    fontFamily: 'Bricolage-R',
                    fontSize: 12.5,
                    color: Color(0xFF616971),
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            const Card(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  children: [
                    ListTile(
                      minTileHeight: 45,
                      leading: Text(
                        'Amount Paid',
                        style: TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                      trailing: Text(
                        '500 THB',
                        style: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                    ),
                    SizedBox(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFFD3D6D8),
                      ),
                    ),
                    ListTile(
                      minTileHeight: 45,
                      leading: Text(
                        'Package',
                        style: TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                      trailing: Text(
                        '500 THB(3 Months)',
                        style: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                    ),
                    SizedBox(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFFD3D6D8),
                      ),
                    ),
                    ListTile(
                      minTileHeight: 45,
                      leading: Text(
                        'Purchased on',
                        style: TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                      trailing: Text(
                        '12 Dec 2024',
                        style: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                    ),
                    SizedBox(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFFD3D6D8),
                      ),
                    ),
                    ListTile(
                      minTileHeight: 45,
                      leading: Text(
                        'Expired Date',
                        style: TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                      trailing: Text(
                        '12 Feb 2024',
                        style: TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
