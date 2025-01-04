import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/services/language_provider.dart';

class Qr extends StatelessWidget {
  Qr({
    super.key,
    required this.isPrompt,
    required this.isKbz,
  });

  final bool isKbz;
  final bool isPrompt;
  @override
  Widget build(BuildContext context) {
    //var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: primaryPinkColor),
        title: const Text(
          'QR code',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 255,
                  height: 299,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Scan this Qr to make payment',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontFamily: 'Bricolage-R',
                          color: Color(0xff363B3F),
                        ),
                      ),
                      Image.asset(
                        'images/qr.png',
                        width: 195,
                        height: 195,
                      ),
                      const SizedBox(
                        child: Divider(
                          height: 2,
                          indent: 30,
                          endIndent: 30,
                          color: Color(0xffF0F1F2),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.file_download_outlined,
                                  color: primaryPinkColor,
                                  size: 16,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Save',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    fontSize: 12.5,
                                    color: primaryPinkColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: -20,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      // Add this to make the image circular
                      child: Image.asset(
                        isKbz == true ? 'images/kbz.png' : 'images/prompt.png',
                        fit: BoxFit
                            .fill, // This ensures the image fills the circle
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                    child: Divider(
                      height: 10,
                    ),
                  ),
                  const Text(
                    'After you complete the payment',
                    style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 12.5,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    width: 375,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: primaryPinkColor,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Set the border radius
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_upload_outlined,
                            color: primaryPinkColor,
                            size: 24,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Upload e-receipt or screenshot',
                            style: TextStyle(
                                color: primaryPinkColor,
                                fontFamily: 'Bricolage-M'),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
