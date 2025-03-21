import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sabai_app/components/reusable_alertbox.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:sabai_app/screens/auth_pages/token_service.dart';
import 'package:sabai_app/screens/successful_application.dart';
import 'package:sabai_app/services/payment_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CvUploadModel extends StatefulWidget {
  final int jobId;
  const CvUploadModel({super.key, required this.jobId});

  @override
  State<CvUploadModel> createState() => _CvUploadModelState();
}

class _CvUploadModelState extends State<CvUploadModel> {
  String? _fileName;
  double _uploadProgress = 0.0;
  String _uploadStatus = "no_file";
  String? _cvFileUrl; // Store the CV file URL
  bool _isLoading = true;
  bool CVFileExists = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  void applyJob() async {
    try {
      final response = await http.post(
          Uri.parse(
              'https://sabai-job-backend-k9wda.ondigitalocean.app/api/jobs/apply/'),
          headers: await ApiService.getHeaders(),
          body: jsonEncode({"job_id": widget.jobId}));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        String message = data["message"];
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) =>
                const ReusableAlertBox(text: 'Submitting'),
          );
        }
        // Use a separate context variable for the dialog
        await Future.delayed(const Duration(seconds: 3));
        // Close the dialog and navigate
        if (mounted) {
          Navigator.of(context, rootNavigator: true)
              .pop(); // This ensures the dialog is closed
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SuccessfulApplicationScreen()));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  void fetchUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final paymentProvider =
          Provider.of<PaymentProvider>(context, listen: false);
      await paymentProvider.getProfileData();

      final userData = paymentProvider.userData;
      if (userData != null &&
          userData['user_info']?['cv_file'] != null &&
          userData['user_info']['cv_file'] != '') {
        setState(() {
          _cvFileUrl = userData['user_info']['cv_file'];
          _uploadStatus = "success";
          CVFileExists = true;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
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
          CVFileExists = true;
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: Color(0xFFD3D6D8),
                  ),
                ),
                Text(
                  'Or',
                  style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 12.5,
                      color: Color(0xFF989EA4)),
                ),
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: Color(0xFFD3D6D8),
                  ),
                ),
              ],
            ),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: Color(0xFFD3D6D8),
                  ),
                ),
                Text(
                  'Or',
                  style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 12.5,
                      color: Color(0xFF989EA4)),
                ),
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: Color(0xFFD3D6D8),
                  ),
                ),
              ],
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
                onTap: () {
                  if (_cvFileUrl != null) {
                    launchUrl(Uri.parse(_cvFileUrl!),
                        mode: LaunchMode.externalApplication);
                  }
                },
              ),
            ),
          ],
        );

      case "failed":
        return Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: Color(0xFFD3D6D8),
                  ),
                ),
                Text(
                  'Or',
                  style: TextStyle(
                      fontFamily: 'Bricolage-M',
                      fontSize: 12.5,
                      color: Color(0xFF989EA4)),
                ),
                SizedBox(
                  width: 100,
                  child: Divider(
                    color: Color(0xFFD3D6D8),
                  ),
                ),
              ],
            ),
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
        return const SizedBox(
          height: 1,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xfff0f1f2),
            width: 10,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Upload your CV",
                    style:
                        TextStyle(fontFamily: 'Bricolage-M', fontSize: 15.6)),
                IconButton(
                  icon: const Icon(
                    Icons.close_outlined,
                    color: Colors.pink,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(height: 10),
            TextButton(
              onPressed: CVFileExists ? applyJob : null,
              style: TextButton.styleFrom(
                minimumSize: const Size(277, 34),
                side: const BorderSide(color: Color(0xFFfe9bcb)),
                backgroundColor:
                    CVFileExists ? primaryPinkColor : const Color(0xFFfe9bcb),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Set the border radius
                ),
              ),
              child: const SizedBox(
                width: 277,
                height: 23,
                child: Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Bricolage-SMB',
                    color: Colors.white,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ),
            _buildUploadStatus(),
          ],
        ),
      ),
    );
  }
}
