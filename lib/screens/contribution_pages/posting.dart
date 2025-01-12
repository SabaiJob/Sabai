import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:sabai_app/components/reusable_alertbox.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'dart:ui' show Size;

class Posting extends StatefulWidget {
  Posting({this.url, this.img, super.key});

  String? url = '';
  String? img = '';

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  PreviewData? _previewData;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(widget.url!);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: LeadingIcon(),
        iconTheme: const IconThemeData(
          color: primaryPinkColor,
        ),
        backgroundColor: backgroundColor,
        title: const Text(
          'Post',
          style: appBarTitleStyleEng,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: SizedBox(
              width: 78,
              height: 35,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primaryPinkColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const ReusableAlertBox();
                    },
                  );

                  Future.delayed(const Duration(seconds: 3), () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            backgroundColor: Colors.white,
                            child: SizedBox(
                              height: 340,
                              width: 324,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'images/contribute_success.png',
                                    width: 140,
                                    height: 140,
                                  ),
                                  const Text(
                                    '🎉 Woohoo! Thank You!',
                                    style: TextStyle(
                                      fontFamily: 'Bricolage-SMB',
                                      fontSize: 19.53,
                                    ),
                                  ),
                                  const Text(
                                    textAlign: TextAlign.center,
                                    'We’ll review your contribution and let\nyou know when it’s ready!',
                                    style: TextStyle(
                                      fontFamily: 'Bricolage-R',
                                      fontSize: 15.63,
                                      color: Color(0xff6C757D),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 292,
                                    height: 35,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        backgroundColor: primaryPinkColor,
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const NavigationHomepage(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Done',
                                        style: TextStyle(
                                          fontFamily: 'Bricolage-R',
                                          fontSize: 12.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  });
                },
                child: const Text(
                  'Contribute',
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Bricolage-B',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Image.asset(
                          'images/avatar2.png',
                          width: 40,
                          height: 40,
                        ),
                        const Text(
                          'Cameron Williamson',
                          style: TextStyle(
                            fontSize: 15.63,
                            fontFamily: 'Bricolage-SMB',
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Say something',
                        hintStyle: TextStyle(
                          fontFamily: 'Bricolage-R',
                          fontSize: 14,
                          color: Colors.grey,
                        ), // Remove the default underline
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (uri != null && await canLaunchUrl(uri)) {
                        await launchUrl(uri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Could not launch ${widget.url}'),
                          ),
                        );
                      }
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: LinkPreview(
                          linkStyle: const TextStyle(
                            color: Colors.blue,
                            fontFamily: 'Bricolage-R',
                            decoration: TextDecoration.none,
                            fontSize: 12.5,
                          ),
                          enableAnimation: true,
                          onPreviewDataFetched: (data) {
                            setState(() {
                              _previewData = data;
                            });
                          },
                          previewData: _previewData,
                          text: uri.toString(),
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child: RowWrapper(),
          )
        ],
      ),
    );
  }
}

class RowWrapper extends StatelessWidget {
  const RowWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      curve: Curves.easeOut,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      duration: const Duration(milliseconds: 100),
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          color: backgroundColor,
          border: Border(
            top: BorderSide(
              width: 0.9,
              color: Colors.grey,
            ),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.broken_image_outlined,
                color: primaryPinkColor,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.location_on_outlined,
                color: primaryPinkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeadingIcon extends StatefulWidget {
  const LeadingIcon({super.key});

  @override
  State<LeadingIcon> createState() => _LeadingIconState();
}

class _LeadingIconState extends State<LeadingIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              child: SizedBox(
                width: 320,
                height: 323,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'images/draft.png',
                            width: 140,
                            height: 75.06,
                          ),
                          const Text(
                            'Save this post as a draft',
                            style: TextStyle(
                              fontFamily: 'Bricolage-M',
                              fontSize: 19.53,
                            ),
                          ),
                          const Text(
                            'If you discard now, you’ll lose this post.',
                            style: TextStyle(
                              fontFamily: 'Bricolage-R',
                              fontSize: 12.5,
                              color: Color(0xff6C757D),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          DraftTextButtons(
                            function: () {},
                            text: 'Save Draft',
                          ),
                          DraftTextButtons(
                            function: () {},
                            text: 'Discard Post',
                          ),
                          DraftTextButtons(
                            function: () {},
                            text: 'Keep Editing',
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.xmark_circle,
                        size: 28,
                        color: primaryPinkColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      icon: const Icon(
        Icons.arrow_back,
        color: primaryPinkColor,
      ),
    );
  }
}

class DraftTextButtons extends StatelessWidget {
  const DraftTextButtons(
      {required this.function, required this.text, super.key});

  final Function() function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 288,
      height: 30,
      child: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color(0xffF0F1F2),
            ),
          ),
        ),
        onPressed: function,
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: TextStyle(
            fontFamily: 'Bricolage-R',
            fontSize: 12.5,
            color: text.contains('Discard') ? Colors.red : primaryPinkColor,
          ),
        ),
      ),
    );
  }
}
