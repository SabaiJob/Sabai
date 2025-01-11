import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;

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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NavigationHomepage(),
                    ),
                  );
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
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
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
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
    );
  }
}
