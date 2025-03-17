import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/auth_pages/token_service.dart';
import 'package:sabai_app/services/language_provider.dart';
import 'package:sabai_app/services/payment_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCVScreen extends StatefulWidget {
  const MyCVScreen({super.key});

  @override
  State<MyCVScreen> createState() => _MyCVScreenState();
}

class _MyCVScreenState extends State<MyCVScreen> {
  String? _fileName;
  double _uploadProgress = 0.0;
  String _uploadStatus = "no_file";
  String? _cvFileUrl; // Store the CV file URL
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    try{
      final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getProfileData();

    final userData = paymentProvider.userData;
    if (userData != null && userData['user_info']?['cv_file'] != null) {
      setState(() {
        _cvFileUrl = userData['user_info']['cv_file'];
        _uploadStatus = "success";
      });
    }
    }catch(e){
      print("Error fetching user data: $e");
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        // Always get bytes for all platforms to avoid iOS-specific issues
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        _fileName = result.files.single.name;
        int fileSizeInBytes = result.files.single.size;
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

        // File Size Validation
        if (fileSizeInMB > 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("File size exceeds 10MB. Please select a smaller file."),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        setState(() {
          _uploadStatus = "uploading";
          _uploadProgress = 0.0;
        });

        // Use bytes approach for both iOS and Android
        Uint8List? fileBytes = result.files.single.bytes;
        if (fileBytes != null) {
          await uploadFile(fileBytes, _fileName!);
        } else {
          // This is a fallback, but should rarely happen with withData: true
          setState(() {
            _uploadStatus = "failed";
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to read file. Please try again."),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _uploadStatus = "failed";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error picking file: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> uploadFile(Uint8List fileBytes, String fileName) async {
    final Dio dio = Dio();
    String uploadUrl =
        "https://sabai-job-backend-k9wda.ondigitalocean.app/api/auth/userinfo/";

    final token = await TokenService.getToken();

    FormData formData = FormData.fromMap({
      "cv_file": MultipartFile.fromBytes(
        fileBytes,
        filename: fileName,
      ),
    });

    try {
      setState(() {
        _uploadStatus = "uploading";
        _uploadProgress = 0.0;
      });

    await dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $token",
          },
        ),
        onSendProgress: (sent, total) {
          if (total <= 0) return;
          setState(() {
            _uploadProgress = (sent / total) * 100;
          });
        },
      );

      // After successful upload, fetch the updated profile data
      final paymentProvider =
          Provider.of<PaymentProvider>(context, listen: false);
      await paymentProvider.getProfileData();

      final userData = paymentProvider.userData;
      if (userData != null && userData['user_info']?['cv_file'] != null) {
        setState(() {
          _cvFileUrl = userData['user_info']['cv_file'];
          _fileName = fileName; // Store the filename
          _uploadStatus = "success";
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("CV uploaded successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        throw Exception("Failed to get CV URL after upload");
      }
    } catch (e) {
      setState(() {
        _uploadStatus = "failed";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              "Upload Failed: ${e.toString().length > 100 ? e.toString().substring(0, 100) + '...' : e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildUploadStatus() {
    switch (_uploadStatus) {
      case "uploading":
        return Column(
          children: [
            const Text(
              "Uploading...",
              style: TextStyle(fontSize: 15.63, fontFamily: 'Bricolage-M'),
            ),
            const SizedBox(height: 15),
            LinearProgressIndicator(
              value: _uploadProgress / 100,
              backgroundColor: const Color(0xFFE2E3E5),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFFFF3997)),
            ),
            const SizedBox(height: 8),
            Text(
              "${_uploadProgress.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 12.5, fontFamily: 'Bricolage-R'),
            ),
          ],
        );

      case "success":
        return Column(
          children: [
            const Text(
              'Your uploaded CV',
              style: TextStyle(fontSize: 15.63, fontFamily: 'Bricolage-M'),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E3E5)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.picture_as_pdf,
                    color: Colors.red, size: 35),
                title: Text(
                  overflow: TextOverflow.ellipsis,
                  _fileName ?? "Resume.pdf",
                  style: const TextStyle(
                      fontFamily: 'Bricolage-SMB', fontSize: 12.5),
                ),
                // subtitle: const Text(
                //   "Uploaded Successfully",
                //   style: TextStyle(
                //       color: Color(0xFF616971), fontFamily: 'Bricolage-R'),
                // ),
                trailing: GestureDetector(
                  onTap: pickFile,
                  child:  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFF0F1F2)),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: const Text(
                      "Update Here",
                      style: TextStyle(
                        color: Color(0xFFFF3997),
                        fontFamily: 'Bricolage-R',
                        fontSize: 12.5,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  if (_cvFileUrl != null) {
                    launchUrl(Uri.parse(_cvFileUrl!), mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ),
          ],
        );

      case "failed":
        return Column(
          children: [
            const Text(
              "Upload failed. Please try again.",
              style: TextStyle(
                  fontSize: 15.63,
                  fontFamily: 'Bricolage-M',
                  color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3997),
                foregroundColor: Colors.white,
              ),
              child: const Text("Try Again"),
            ),
          ],
        );

      default: // "no_file"
        return Column(
          children: [
            const Text(
              "You haven't uploaded any CV yet.",
              style: TextStyle(fontSize: 15.63, fontFamily: 'Bricolage-M'),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: pickFile,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(8),
                color: const Color(0xFFE2E3E5),
                strokeWidth: 1,
                child: const SizedBox(
                  width: 343,
                  height: 141,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.cloud_upload,
                        size: 35,
                        color: Color(0xFFFF3997),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Upload a file less than 10 MB',
                        style: TextStyle(
                            fontSize: 12.5, fontFamily: 'Bricolage-M'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F7F7),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: languageProvider.lan == 'English'
            ? const Text("My CV", style: appBarTitleStyleEng)
            : const Text("My CV", style: appBarTitleStyleMn),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFFF3997)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: _isLoading ? const CircularProgressIndicator(color: primaryPinkColor,) : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 113,
                    height: 114,
                    decoration: BoxDecoration(
                      color: const Color(0xFFf9edc2),
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xFFFFC107), width: 2),
                    ),
                  ),
                  Positioned(
                    child: Image.asset(
                      'images/mycv.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              _buildUploadStatus(),
            ],
          ),
        ),
      ),
    );
  }
}
