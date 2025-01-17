import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/payment_verifying.dart';
import 'package:sabai_app/services/image_picker_helper.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'dart:typed_data';

class Qr extends StatefulWidget {
  const Qr({
    super.key,
    required this.isPrompt,
    required this.isKbz,
  });

  final bool isKbz;
  final bool isPrompt;

  @override
  State<Qr> createState() => _QrState();
}

class _QrState extends State<Qr> {
  final String imageUrl =
      'https://softmatic.com/images/QR%20Example%20Umlauts%20Accented.png';

  FileImage? _selectedImage;

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    ImagePickerHelper imagePickerHelper = ImagePickerHelper();
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
                      // Image.asset(
                      //   'images/qr.png',
                      //   width: 195,
                      //   height: 195,
                      // ),
                      Image.network(
                        imageUrl,
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
                            onPressed: () async {
                              try {
                                final saved =
                                    await ImageSaverUtil.saveNetworkImage(
                                        imageUrl);
                                // Show success or failure message
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(saved
                                          ? 'Image saved successfully!'
                                          : 'Failed to save image'),
                                    ),
                                  );
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error: $e'),
                                    ),
                                  );
                                }
                              }
                            },
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
                        widget.isKbz == true
                            ? 'images/kbz.png'
                            : 'images/prompt.png',
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                    child: Divider(
                      height: 10,
                    ),
                  ),
                  const Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Text(
                      'After you complete the payment,',
                      style: TextStyle(
                        fontFamily: 'Bricolage-M',
                        fontSize: 12.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  GestureDetector(
                    onTap: () async {
                      FileImage? image = await imagePickerHelper.pickImage(
                          ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          _selectedImage = image;
                        });
                      }
                    },
                    child: _selectedImage == null
                        ? Container(
                            width: double.infinity,
                            height: 113,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryPinkColor,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.folder,
                                  color: primaryPinkColor,
                                  size: 16,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Upload photo',
                                  style: TextStyle(
                                    fontFamily: 'Bricolage-R',
                                    fontSize: 10,
                                    color: primaryPinkColor,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ),
                  if (_selectedImage != null) ...[
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
                                    _selectedImage!.file,
                                    fit: BoxFit
                                        .contain, 
                                  ),
                                ),
                              );
                            });
                      },
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            child: Image.file(
                              _selectedImage!.file,
                              fit: BoxFit.fitWidth,
                              height: 113,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: GestureDetector(
                              onTap: _clearImage,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1, horizontal: 1),
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                    color: Color(0xFFF0F1F2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                child: const Icon(
                                  Icons.clear,
                                  size: 12,
                                  color: primaryPinkColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: 375,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextButton(
            onPressed: _selectedImage != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentVerifying(),
                      ),
                    );
                  }
                : null,
            style: TextButton.styleFrom(
              backgroundColor: _selectedImage != null
                  ? const Color(0xffFF3997)
                  : Colors.pink.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Set the border radius
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                languageProvider.lan == 'English'
                    ? const Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'Bricolage-B',
                          fontSize: 15.63,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        'ဆက်လက်ရန်',
                        style: TextStyle(
                          fontFamily: 'Walone-B',
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  CupertinoIcons.arrow_right,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.center,
    );
  }
}

class ImageSaverUtil {
  static Future<bool> saveNetworkImage(String imageUrl) async {
    try {
      // Request permissions first
      if (Platform.isAndroid) {
        final storageStatus = await Permission.storage.request();
        if (!storageStatus.isGranted) {
          throw Exception('Storage permission not granted');
        }
      }

      if (Platform.isIOS) {
        final photosStatus = await Permission.photos.request();
        if (!photosStatus.isGranted) {
          throw Exception('Photos permission not granted');
        }
      }

      // Download image
      var response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      // Save image
      final result = await ImageGallerySaverPlus.saveImage(
          Uint8List.fromList(response.data),
          quality: 100,
          name: "sabai_${DateTime.now().millisecondsSinceEpoch}");

      return result['isSuccess'] ?? false;
    } catch (e) {
      print('Error saving image: $e');
      return false;
    }
  }
}
