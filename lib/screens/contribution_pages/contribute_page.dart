import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:sabai_app/screens/contribution_pages/posting.dart';
import 'package:sabai_app/services/language_provider.dart';

import '../../components/reusable_alertbox.dart';

class ContributePage extends StatefulWidget {
  final Function() whenUploadPhotoOnTap;
  const ContributePage({super.key, required this.whenUploadPhotoOnTap});

  @override
  State<ContributePage> createState() => _ContributePageState();
}

class _ContributePageState extends State<ContributePage> {
  final linkController = TextEditingController();

  Future<bool> isUrlReachable(String url) async {
    try {
      final respond = await http.head(Uri.parse(url));
      return respond.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    linkController.addListener(() {
      setState(() {}); // Rebuild when text changes
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            Image.asset(
              'images/contribute.png',
              width: 208,
              height: 208,
            ),
            languageProvider.lan == 'English'
                ? const Text(
                    'Contribute to community',
                    style: TextStyle(
                      fontFamily: 'Bricolage-SMB',
                      fontSize: 24.41,
                    ),
                  )
                : const Text(
                    textAlign: TextAlign.center,
                    'အလုပ်တင်ပြီး\nအခြားသူများကိုကူညီမယ်',
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 24.41,
                    ),
                  ),
            languageProvider.lan == 'English'
                ? const Text(
                    'Help others to find jobs',
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 15.63,
                      color: Color(0xff6C757D),
                    ),
                  )
                : const Text(
                    'အခြားသူများကို အလုပ်ရှာဖွေရေး၌ ကူညီရာရောက်ပါတယ်',
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 14,
                      color: Color(0xff6C757D),
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
             Align(
              alignment: Alignment.topLeft,
              child: 
              languageProvider.lan == 'English'?
              const Text(
                'Paste Job Post Link',
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 15.63,
                ),
              ): const Text(
                'အလုပ် ပို့စ်လင့်ခ် ကို တင်မယ်',
                style: TextStyle(
                  fontFamily: 'Walone-B',
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                      controller: linkController,
                      decoration:  InputDecoration(
                        hintStyle: languageProvider.lan == 'English'?
                        const TextStyle(
                          fontFamily: 'Bricolage-R',
                          fontSize: 14,
                          color: Color(0xff7B838A),
                        ):const TextStyle(
                          fontFamily: 'Walone-R',
                          fontSize: 14,
                          color: Color(0xff7B838A),
                        ),
                        hintText: languageProvider.lan == 'English'? 'Paste here': 'လင့်ခ်ကိုဒီမှာတင်မှာ',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            linkController.text.trim().isEmpty == true
                                ? Colors.pink.shade50
                                : primaryPinkColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    onPressed: () async {
                      Future<bool> canShare =
                          isUrlReachable(linkController.text);
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          return const ReusableAlertBox(
                            text: 'Loading...',
                          );
                        },
                      );
                      Future.delayed(
                          const Duration(
                            seconds: 3,
                          ), () async {
                        if (await canShare) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Posting(
                                url: linkController.text,
                              ),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.white,
                                  child: SizedBox(
                                    width: 300,
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.asset(
                                          'images/link.png',
                                          width: 105,
                                          height: 105,
                                        ),
                                        const Text(
                                          'The link is invalid.',
                                          style: TextStyle(
                                              fontFamily: 'Bricolage-SMB',
                                              fontSize: 19.53),
                                        ),
                                        const Text(
                                          textAlign: TextAlign.center,
                                          'Try using a different link to\ncontribute.',
                                          style: TextStyle(
                                            fontFamily: 'Bricolage-R',
                                            fontSize: 15.63,
                                            color: Color(0xff6C757D),
                                          ),
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: primaryPinkColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            'Done',
                                            style: TextStyle(
                                              fontFamily: 'Bricolage-B',
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      });
                    },
                    child: const Text(
                      'Share',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 12.5,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
             Row(
              children: [
                const Expanded(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: 
                  languageProvider.lan == 'English' ?
                  const  Text(
                    'or',
                    style: TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 15.63,
                      color: Color(0xff6C757D),
                    ),
                  ): const Text(
                    'သို့မဟုတ်',
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 14,
                      color: Color(0xff6C757D),
                    ),
                  ),
                ),
                const Expanded(
                  child: Divider(
                    height: 5,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: widget.whenUploadPhotoOnTap,
              child: Container(
                width: double.infinity,
                height: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: primaryPinkColor,
                  ),
                ),
                child:  Center(
                  child: 
                    languageProvider.lan == 'English' ?
                  const Text(
                    'Upload Photo',
                    style: TextStyle(
                      fontFamily: 'Bricolage-B',
                      fontSize: 15.63,
                      color: primaryPinkColor,
                    ),
                  ):const Text(
                    'ဓာတ်ပုံ တင်ပါ',
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 15,
                      color: primaryPinkColor,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
