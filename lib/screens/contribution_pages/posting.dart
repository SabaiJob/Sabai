import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_alertbox.dart';
import 'package:sabai_app/components/unsuccessful_dialouge.dart';
import 'package:sabai_app/constants.dart';
//import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/screens/auth_pages/token_service.dart';
import 'package:sabai_app/screens/contribution_pages/add_location.dart';
import 'package:sabai_app/screens/navigation_homepage.dart';
import 'package:sabai_app/services/image_picker_helper.dart';
import 'package:sabai_app/services/job_provider.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Posting extends StatefulWidget {
  Posting(
      {this.location,
      this.isLocated,
      this.url,
      this.selectedImages,
      this.draftText,
      super.key});

  String? url;
  List<XFile>? selectedImages;
  late String? location;
  late bool? isLocated = false;
  final String? draftText;
  // Add this to track the current URL

  @override
  State<Posting> createState() => _PostingState();
}

class _PostingState extends State<Posting> {
  PreviewData? _previewData;
  final TextEditingController textController = TextEditingController();
  ImagePickerHelper imagePickerHelper = ImagePickerHelper();
  List<XFile>? _images = [];
  String? _currentUrl;
  String? userProfileUrl;
  String? userName;
  String? text;
  bool _hasShownImageErrorThisSession = false;

  //bool? isLoading;

  Future<void> contribute({
    required String text,
    required String link,
    required Map<String, dynamic> location,
    required List<String> imagePaths,
    required LanguageProvider languageProvider,
  }) async {
    final token = await TokenService.getToken();
    //print('it is not in the try');
    try {
      //print('it is in thr try');
      // setState(() {
      //   isLoading = true;
      // });

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return const ReusableAlertBox(
            text: 'Loading...',
          );
        },
      );

      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'text': text,
        'link': link,
        // Convert location map to a JSON string
        'location': jsonEncode(location),
        // Add multiple image files
        'images': [
          for (String path in imagePaths)
            await MultipartFile.fromFile(path, filename: path.split('/').last),
        ],
      });

      final response = await dio.post(
        // 'https://sabai-job-backend-k9wda.ondigitalocean.app/api/contributions/',
        'https://api.sabaijob.com/api/contributions/',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print('success');
        Navigator.pop(context);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                    height: 340,
                    width: 324,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'images/contribute_success.png',
                          width: 140,
                          height: 140,
                        ),
                        languageProvider.lan == 'English'
                            ? const Text(
                                '🎉 Woohoo! Thank You!',
                                style: TextStyle(
                                  fontFamily: 'Bricolage-SMB',
                                  fontSize: 19.53,
                                ),
                              )
                            : const Text(
                                '🎉 ကျေးဇူးတင်ပါသည်!',
                                style: TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 19.53,
                                ),
                              ),
                        languageProvider.lan == 'English'
                            ? const Text(
                                textAlign: TextAlign.center,
                                'We’ll review your contribution and let\nyou know when it’s ready!',
                                style: TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 15.63,
                                  color: Color(0xff6C757D),
                                ),
                              )
                            : const Text(
                                textAlign: TextAlign.center,
                                'ကျွန်ုပ်တို့သည် သင်အလုပ်တင်ပေးမှုကို\nပြန်လည်သုံးသပ်ပြီး ပြီးဆုံးသွားသည့်အခါ\nသတင်းပို့ပါမည်',
                                style: TextStyle(
                                  fontFamily: 'Walone-B',
                                  fontSize: 14,
                                  color: Color(0xff6C757D),
                                ),
                              ),
                        SizedBox(
                          width: 292,
                          height: 29,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: primaryPinkColor,
                            ),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NavigationHomepage(),
                                ),
                                (route) => false,
                              );
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: languageProvider.lan == 'English'
                                  ? const Text(
                                      'Done',
                                      style: TextStyle(
                                        fontFamily: 'Bricolage-R',
                                        fontSize: 12.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'ပြီးဆုံးပြီ',
                                      style: TextStyle(
                                        fontFamily: 'Walone-B',
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      } else {
        print('error for ${response.statusCode}');
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return const UnsuccessfulDialouge(
              dialougeText: 'Sorry! The request is unsuccessful',
            );
          },
        );
      }
    } catch (e) {
      print('Error $e');
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return const UnsuccessfulDialouge(
            dialougeText: 'Sorry! The request is unsuccessful',
          );
        },
      );
      //Navigator.pop;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentUrl = widget.url; // Store initial URL
    _initializeImages();
    // _restoreDraftImages();
    //fetching user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileData = Provider.of<PaymentProvider>(context, listen: false);
      _restoreDraftImages(profileData);
      profileData.getProfileData(context);
      setState(() {
        userName = profileData.userData!['username'];
        userProfileUrl = profileData.userData!['photo'];
      });
    });
    // Initialize text controller with draft text
    if (widget.draftText != null) {
      textController.text = widget.draftText!;
    }
  }

  void _initializeImages() {
    if (widget.selectedImages != null && widget.selectedImages!.isNotEmpty) {
      _images = widget.selectedImages;
    } else if (widget.url != null) {
      if (!widget.url!.startsWith('http') && !widget.url!.startsWith('https')) {
        final file = File(widget.url!);
        if (file.existsSync()) {
          _images = [XFile(widget.url!)];
        }
      }
    } else {
      _images = []; // Ensure it’s initialized
    }
  }

  Future<void> _restoreDraftImages(PaymentProvider paymentProvider) async {
    final prefs = await SharedPreferences.getInstance();
    String phone = paymentProvider.userPhNo;
    final imagePaths = prefs.getStringList('draft_images_$phone');
    if (imagePaths != null && imagePaths.isNotEmpty) {
      final validPaths =
          imagePaths.where((path) => File(path).existsSync()).toList();
      debugPrint('Restored paths: $validPaths'); // Debugging
      if (validPaths.isNotEmpty) {
        setState(() {
          _images = validPaths.map((path) => XFile(path)).toList();
        });
      }
    }
  }

  void _addImages(List<XFile> newImages) {
    setState(() {
      _images!.addAll(newImages);
    });
  }

  Widget _buildImageGrid() {
    if (_images == null || _images!.isEmpty) return const SizedBox();

    return SizedBox(
      height: 600,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _images!.length,
        itemBuilder: (context, index) {
          final imagePath = _images![index].path;
          if (!File(imagePath).existsSync()) {
            debugPrint('Invalid file: $imagePath');
            // Skip invalid files
            return const SizedBox();
          }
          return Stack(
            fit: StackFit.expand,
            alignment: Alignment.topRight,
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        insetPadding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_images![index].path),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Image.file(
                    File(_images![index].path),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                  ),
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      // If this image was from camera (matches the URL), clear the URL
                      if (_images![index].path == _currentUrl) {
                        _currentUrl = null;
                        widget.url = null;
                      }
                      _images!.removeAt(index);
                    });
                  },
                  child: const Icon(
                    CupertinoIcons.xmark_circle_fill,
                    size: 25,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    final uri = widget.url != null &&
            (widget.url!.startsWith('http') || widget.url!.startsWith('https'))
        ? Uri.tryParse(widget.url!)
        : null;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: (widget.url != null ||
                  widget.location != null ||
                  widget.isLocated != null ||
                  textController.text.trim().isNotEmpty ||
                  (_images != null && _images!.isNotEmpty))
              ? LeadingIcon(
                  url: widget.url ?? '',
                  location: widget.location ?? '',
                  isLocated: widget.isLocated ?? false,
                  draftText: widget.draftText ?? '',
                )
              : const BackButton(color: primaryPinkColor),
          iconTheme: const IconThemeData(
            color: primaryPinkColor,
          ),
          backgroundColor: backgroundColor,
          title: languageProvider.lan == 'English'
              ? const Text(
                  'Post',
                  style: appBarTitleStyleEng,
                )
              : const Text(
                  'အလုပ်ပိုစ့်',
                  style: appBarTitleStyleMn,
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
                  onPressed: text == null && _images!.isEmpty
                      ? () {
                          showDialog(
                              context: context,
                              builder: (context) => const UnsuccessfulDialouge(
                                  dialougeText:
                                      'Please fill in the valid information to make a job post!'));
                        }
                      : () async {
                          await contribute(
                            text: text ?? "none",
                            link: widget.url != null ? widget.url! : "",
                            location: {"location": widget.location},
                            imagePaths:
                                _images!.map((image) => image.path).toList(),
                            languageProvider: languageProvider,
                          );
                          setState(() {
                            print('Text: ${text ?? "none"}');
                            print('Link: ${widget.url ?? ""}');
                            print('Location: ${widget.location}');
                            print(
                                'Image Paths: ${_images!.map((image) => image.path).toList()}');
                            print(jsonEncode(widget.location));
                          });
                          jobProvider.setDraft(false);
                        },
                  child: languageProvider.lan == 'English'
                      ? const Text(
                          'Contribute',
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: 'Bricolage-B',
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'တင်မည်',
                          style: TextStyle(
                            fontFamily: 'Walone-B',
                            fontSize: 11,
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
                    // User info section
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          userProfileUrl != null
                              ? ClipOval(
                                  child: Image.network(
                                    userProfileUrl!,
                                    loadingBuilder: (
                                      BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress,
                                    ) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stactTrack) {
                                      if (!_hasShownImageErrorThisSession) {
                                        _hasShownImageErrorThisSession = true;
                                        Future.microtask(() {
                                          if (context.mounted) {
                                            // Check if context is still valid
                                            ScaffoldMessenger.of(context)
                                              ..hideCurrentSnackBar() // Hide any existing snackbar
                                              ..showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Failed to load image',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Bricolage-M',
                                                          fontSize: 12.5,
                                                          color: Color(
                                                              0xFF616971))),
                                                  backgroundColor: Colors.white,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                ),
                                              );
                                          }
                                        });
                                      }
                                      return const Icon(Icons.error);
                                    },
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.asset(
                                  'images/avatar2.png',
                                  width: 40,
                                  height: 40,
                                ),
                          const SizedBox(
                            width: 5,
                          ),
                          userName != null
                              ? Text(
                                  userName!,
                                  style: const TextStyle(
                                    fontSize: 15.63,
                                    fontFamily: 'Bricolage-SMB',
                                  ),
                                )
                              : const Text(
                                  'Cameron Williamson',
                                  style: TextStyle(
                                    fontSize: 15.63,
                                    fontFamily: 'Bricolage-SMB',
                                  ),
                                ),
                          if (widget.isLocated == true)
                            RichText(
                              text: TextSpan(
                                text: ' is at ',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.63,
                                  fontFamily: 'Bricolage-R',
                                ),
                                children: [
                                  TextSpan(
                                    text: '${widget.location}',
                                    style: const TextStyle(
                                      fontFamily: 'Bricolage-SMB',
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Text input field
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
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
                        onChanged: (value) {
                          setState(() {
                            text = value;
                          });
                          print(text);
                        },
                      ),
                    ),

                    // Link preview if URL is provided
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
                                  content: Text(
                                      'Could not launch ${widget.url}',
                                      style: const TextStyle(
                                          fontFamily: 'Bricolage-M',
                                          fontSize: 12.5,
                                          color: Color(0xFF616971))),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.white,
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
                                  print("url : ${widget.url}");
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
                    const SizedBox(height: 20),

                    // Images grid
                    _buildImageGrid(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: RowWrapper(
                whenOnPressedAddPhoto: _addImages,
                onLocationSelected: (location, isLocated) {
                  setState(() {
                    widget.location = location;
                    widget.isLocated = isLocated;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowWrapper extends StatelessWidget {
  final Function(List<XFile>) whenOnPressedAddPhoto;
  final Function(String location, bool isLocated) onLocationSelected;
  const RowWrapper(
      {super.key,
      required this.onLocationSelected,
      required this.whenOnPressedAddPhoto});

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
              onPressed: () async {
                final images = await imagePickerHelper.pickMultipleImage();
                if (images.isNotEmpty) {
                  whenOnPressedAddPhoto(images);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No images selected',
                          style: TextStyle(
                              fontFamily: 'Bricolage-M',
                              fontSize: 12.5,
                              color: Color(0xFF616971))),
                      behavior: SnackBarBehavior.fixed,
                      backgroundColor: Colors.white,
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.broken_image_outlined,
                color: primaryPinkColor,
              ),
            ),
            IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocation(),
                  ),
                );

                if (result != null) {
                  // Call the callback with the selected location
                  onLocationSelected(
                    result['location'],
                    result['isLocated'],
                  );
                }
              },
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
  const LeadingIcon({
    required this.url,
    required this.location,
    required this.isLocated,
    required this.draftText,
    super.key,
  });

  final String url;
  final String location;
  final bool isLocated;
  final String draftText;

  @override
  State<LeadingIcon> createState() => _LeadingIconState();
}

class _LeadingIconState extends State<LeadingIcon> {
  Future<void> saveDraft(
      JobProvider jobProvider, PaymentProvider paymentProvider) async {
    String phone = paymentProvider.userPhNo;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('url_$phone', widget.url);
    await prefs.setString('location_$phone', widget.location);
    await prefs.setBool('isLocated_$phone', widget.isLocated);
    // Get the current images from the Posting widget
    final postingState = context.findAncestorStateOfType<_PostingState>();
    if (postingState != null) {
      await prefs.setString(
          'draftText_$phone', postingState.textController.text);
    }
    if (postingState != null && postingState._images != null) {
      // Convert XFile paths to list of strings
      final imagePaths =
          postingState._images!.map((image) => image.path).toList();
      // Save image paths as string list
      await prefs.setStringList('draft_images_$phone', imagePaths);
    }
    jobProvider.setDraft(true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NavigationHomepage(),
      ),
    );
  }

  Future<void> deleteDraft(
      JobProvider jobProvider, PaymentProvider paymentProvider) async {
    String phone = paymentProvider.userPhNo;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('url_$phone');
    await prefs.remove('location_$phone');
    await prefs.remove('isLocated_$phone');
    await prefs.remove('draft_images_$phone');
    await prefs.remove('draftText_$phone');
    jobProvider.setDraft(false);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const NavigationHomepage(),
      ),
      (route) => false,
    );
  }

  bool _isPageEmpty() {
    final postingState = context.findAncestorStateOfType<_PostingState>();

    // Check for images
    final hasImages = postingState?._images?.isNotEmpty ?? false;

    // Check URL - now using the tracked URL from PostingState
    final hasUrl = postingState?._currentUrl?.isNotEmpty ?? false;

    // Check location
    final hasLocation = widget.location.isNotEmpty;

    // Check text content
    final hasText =
        postingState?.textController.text.trim().isNotEmpty ?? false;

    debugPrint(
        'Empty Check - Images: $hasImages, URL: $hasUrl, Location: $hasLocation, Text: $hasText');

    return !(hasImages || hasUrl || hasLocation || hasText);
  }

  @override
  Widget build(BuildContext context) {
    var jobProvider = Provider.of<JobProvider>(context);
    var paymentProvider = Provider.of<PaymentProvider>(context);
    return IconButton(
      onPressed: () {
        if (_isPageEmpty()) {
          deleteDraft(jobProvider, paymentProvider);
          Navigator.pop(context);
        } else {
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
                                saveDraft(jobProvider, paymentProvider);
                              },
                              text: 'Save Draft',
                            ),
                            DraftTextButtons(
                              function: () {
                                deleteDraft(jobProvider, paymentProvider);
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
        }
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
