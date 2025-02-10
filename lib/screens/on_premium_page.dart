import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';
import '../constants.dart';

class OnPremiumPackage extends StatelessWidget {
  const OnPremiumPackage({super.key, required this.datetime});

  final String datetime;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);
    DateTime parsedDate = DateTime.parse(datetime);
    String formattedDate = DateFormat("d MMM y").format(parsedDate);
    if (datetime.isEmpty) {
      return const Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: CircularProgressIndicator(
            color: primaryPinkColor,
          ),
        ),
      );
    }
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
            paymentProvider.paymentMethodId == 0
                ? const Text(
                    '1 Month Package',
                    style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 15.6,
                        color: Color(0xFF161719)),
                  )
                : const Text(
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
              text: TextSpan(children: [
                const TextSpan(
                  text: 'Expired Date : ',
                  style: TextStyle(
                    fontFamily: 'Bricolage-R',
                    fontSize: 12.5,
                    color: Color(0xFF616971),
                  ),
                ),
                TextSpan(
                  text: formattedDate,
                  style: const TextStyle(
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
            Card(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  children: [
                    const ListTile(
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
                    const SizedBox(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFFD3D6D8),
                      ),
                    ),
                    const ListTile(
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
                    const SizedBox(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFFD3D6D8),
                      ),
                    ),
                    ListTile(
                      minTileHeight: 45,
                      leading: const Text(
                        'Purchased on',
                        style: TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                      trailing: Text(
                        paymentProvider.purchaseDate,
                        style: const TextStyle(
                            fontFamily: 'Bricolage-M',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                    ),
                    const SizedBox(
                      child: Divider(
                        thickness: 1,
                        color: Color(0xFFD3D6D8),
                      ),
                    ),
                    ListTile(
                      minTileHeight: 45,
                      leading: const Text(
                        'Expired Date',
                        style: TextStyle(
                            fontFamily: 'Bricolage-R',
                            fontSize: 10,
                            color: Color(0xFF41464B)),
                      ),
                      trailing: Text(
                        formattedDate,
                        style: const TextStyle(
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
