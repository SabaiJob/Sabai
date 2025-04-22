import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/contribution_pages/posting.dart';
import 'package:sabai_app/services/image_picker_helper.dart';
import 'package:sabai_app/services/language_provider.dart';

class UploadPhotoPage extends StatelessWidget {
  final Function()? whenCameraIsCalled;
  const UploadPhotoPage({super.key, required this.whenCameraIsCalled});

  @override
  Widget build(BuildContext context) {
    ImagePickerHelper imagePickerHelper = ImagePickerHelper();
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
              'images/upload_photo.png',
              width: 328,
              height: 208,
            ),
            const SizedBox(
              height: 25,
            ),
            languageProvider.lan == 'English'?
            const Text(
              'Upload Photo',
              style: TextStyle(
                fontFamily: 'Bricolage-SMB',
                fontSize: 24.41,
              ),
            ):const Text(
              'ဓာတ်ပုံ တင်ပါ',
              style: TextStyle(
                fontFamily: 'Walone-B',
                fontSize: 24.41,
              ),
            ) ,
            const SizedBox(
              height: 15,
            ),
            languageProvider.lan == 'English'?
            const Text(
              'capture and share job posts',
              style: TextStyle(
                fontFamily: 'Walone-B',
                fontSize: 15.63,
                color: Color(0xff6C757D),
              ),
            ): const Text(
              'အလုပ် ပိုစ့်တွေကိုဓာတ်ပုံရိုက်တင်မယ်',
              style: TextStyle(
                fontFamily: 'Walone-B',
                fontSize: 14,
                color: Color(0xff6C757D),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                final images = await imagePickerHelper.takeImage();
                if (images != null && images.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Posting(
                                selectedImages: images,
                              )));
                }
              },
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
                    'Take Photo',
                    style: TextStyle(
                      fontFamily: 'Bricolage-B',
                      fontSize: 15.63,
                      color: primaryPinkColor,
                    ),
                  ): const Text(
                    'ဓာတ်ပုံရိုက်မယ်',
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 14,
                      color: primaryPinkColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                final images = await imagePickerHelper.pickMultipleImage();
                if (images != null && images.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Posting(
                                selectedImages: images,
                              )));
                }
              },
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
                  const  Text(
                    'Upload From Gallery',
                    style: TextStyle(
                      fontFamily: 'Bricolage-B',
                      fontSize: 15.63,
                      color: primaryPinkColor,
                    ),
                  ): const Text(
                    'ဂါလရီကနေတင်မယ်',
                    style: TextStyle(
                      fontFamily: 'Walone-B',
                      fontSize: 14,
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
