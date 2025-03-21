import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:sabai_app/screens/contribution_pages/posting.dart';

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
            const Text(
              'Contribute to community',
              style: TextStyle(
                fontFamily: 'Bricolage-SMB',
                fontSize: 24.41,
              ),
            ),
            const Text(
              'help others to find jobs',
              style: TextStyle(
                fontFamily: 'Bricolage-R',
                fontSize: 15.63,
                color: Color(0xff6C757D),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Paste Job Post Link',
                style: TextStyle(
                  fontFamily: 'Bricolage-M',
                  fontSize: 15.63,
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
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: 'Bricolage-R',
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        hintText: 'Paste here',
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
                          return const ReusableAlertBox(text: 'Loading...',);
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
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'or',
                    style: TextStyle(
                      fontFamily: 'Bricolage-R',
                      fontSize: 15.63,
                      color: Color(0xff6C757D),
                    ),
                  ),
                ),
                Expanded(
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
                child: const Center(
                  child: Text(
                    'Upload Photo',
                    style: TextStyle(
                      fontFamily: 'Bricolage-B',
                      fontSize: 15.63,
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
