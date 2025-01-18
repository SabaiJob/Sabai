import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_alertbox.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/services/image_picker_helper.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:shared_preferences/shared_preferences.dart';

class Posting extends StatefulWidget {
  const Posting({this.url, this.selectedImages, super.key});

  final String? url;
  final List<XFile>? selectedImages;

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  PreviewData? _previewData;
  final textController = TextEditingController();
  ImagePickerHelper imagePickerHelper = ImagePickerHelper();
  List<XFile>? _images = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _images = widget.selectedImages ?? [];
  }

  void _addImages(List<XFile> newImages) {
    setState(() {
      _images!.addAll(newImages);
    });
  }
  @override
  Widget build(BuildContext context) {
    final uri = widget.url != null ? Uri.tryParse(widget.url!) : null;
    //final uri = Uri.tryParse(widget.url!);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: widget.url != null
            ? LeadingIcon(url: widget.url!)
            : const BackButton(color: primaryPinkColor),
        // leading: LeadingIcon(
        //   url: widget.url!,
        // ),
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

                  // TextField
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
                        ),
                      ),
                    ),
                  ),

                  //Link Preview
                  if (uri != null) ...[
                    GestureDetector(
                      onTap: () async {
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri,
                              mode: LaunchMode.externalApplication);
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Could not launch ${widget.url}'),
                              ),
                            );
                          }
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

                  //Images Grid
                  if (_images != null) ...[
                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount:  _images!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print("Tapped on image ${index + 1}");
                            },
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              child: Image.file(
                                File(_images![index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: RowWrapper(whenOnPressedAddPhoto: _addImages,),
          )
        ],
      ),
    );
  }
}

class RowWrapper extends StatelessWidget {
  final Function(List<XFile>) whenOnPressedAddPhoto;
  const RowWrapper({super.key, required this.whenOnPressedAddPhoto});

  @override
  Widget build(BuildContext context) {
    ImagePickerHelper imagePickerHelper = ImagePickerHelper();
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
              onPressed: () async{
                final images = await imagePickerHelper.pickMultipleImage();
                if(images.isNotEmpty){
                  whenOnPressedAddPhoto(images);
                }else{
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No images selected')),
                  );
                }
              },
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
  const LeadingIcon({required this.url, super.key});

  final String url;

  @override
  State<LeadingIcon> createState() => _LeadingIconState();
}

class _LeadingIconState extends State<LeadingIcon> {
  Future<void> saveDraft(JobProvider jobProvider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('url', widget.url);
    jobProvider.setDraft(true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NavigationHomepage(),
      ),
    );
  }

  Future<void> deleteDraft(JobProvider jobProvider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('url');
    jobProvider.setDraft(false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NavigationHomepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
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
                            function: () {
                              saveDraft(jobProvider);
                            },
                            text: 'Save Draft',
                          ),
                          DraftTextButtons(
                            function: () {
                              deleteDraft(jobProvider);
                            },
                            text: 'Discard Post',
                          ),
                          DraftTextButtons(
                            function: () {
                              Navigator.pop(context);
                            },
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

 // Link Preview O
                  // GestureDetector(
                  //   onTap: () async {
                  //     if (uri != null && await canLaunchUrl(uri)) {
                  //       await launchUrl(uri,
                  //           mode: LaunchMode.externalApplication);
                  //     } else {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           content: Text('Could not launch ${widget.url}'),
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   child: Card(
                  //     color: Colors.white,
                  //     elevation: 2,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(10.0),
                  //       child: LinkPreview(
                  //         linkStyle: const TextStyle(
                  //           color: Colors.blue,
                  //           fontFamily: 'Bricolage-R',
                  //           decoration: TextDecoration.none,
                  //           fontSize: 12.5,
                  //         ),
                  //         enableAnimation: true,
                  //         onPreviewDataFetched: (data) {
                  //           setState(() {
                  //             _previewData = data;
                  //           });
                  //         },
                  //         previewData: _previewData,
                  //         text: uri.toString(),
                  //         width: MediaQuery.of(context).size.width,
                  //       ),
                  //     ),
                  //   ),
                  // ),