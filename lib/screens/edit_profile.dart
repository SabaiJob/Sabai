import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import 'package:sabai_app/screens/auth_pages/token_service.dart';

class EditProfile extends StatefulWidget {
  final String initialName;
  //final String initialEmail;
  final String initialImageUrl;
  const EditProfile({
    super.key,
    required this.initialName,
    //required this.initialEmail,
    required this.initialImageUrl,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  //late TextEditingController emailController;
  bool isLoading = false;
  bool isUploadingImage = false;
  bool isEdited = false;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    //emailController = TextEditingController(text: widget.initialEmail);
    nameController.addListener(trackChanges);
    //emailController.addListener(trackChanges);
  }

  @override
  void dispose() {
    nameController.dispose();
    //emailController.dispose();
    super.dispose();
  }

  void trackChanges() {
    setState(() {
      isEdited = nameController.text != widget.initialName ||
          //emailController.text != widget.initialEmail ||
          _imageFile != null;
    });
  }

  Future<Map<String, dynamic>?> fetchUpdatedProfile() async {
    try {
      final response = await ApiService.get('/auth/token/verify/');
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        return {
          'username': data['username'],
          //'email': data['user_info']['email'],
          'profile_picture': data['photo'],
        };
      }
      return null;
    } catch (e) {
      showCustomSnackBar(
        message: "Failed to fetch updated profile: ${e.toString()}",
        isError: true,
      );
      return null;
    }
  }

  Future<void> saveProfile() async {
    final bool fieldsEdited = nameController.text != widget.initialName;
    // || emailController.text != widget.initialEmail;

    if (!fieldsEdited && _imageFile == null) {
      Navigator.pop(context);
      return;
    }

    setState(() => isLoading = true);

    try {
      // Upload image first if changed
      if (_imageFile != null) {
        final imageUploadSuccess = await _uploadProfilePhoto(_imageFile!);
        if (!imageUploadSuccess) {
          setState(() => isLoading = false);
          return;
        }
      }

      // Update profile if fields were edited
      if (fieldsEdited) {
        final response = await ApiService.put('/auth/profile-update/', {
          "username": nameController.text,
          //"email": emailController.text,
        });

        if (response.statusCode < 200 || response.statusCode >= 300) {
          print(response.body);
          showCustomSnackBar(
            message: "Failed to update profile. Please try again.",
            isError: true,
          );
          setState(() => isLoading = false);
          return;
        }

        // Parse the response
        final responseData = jsonDecode(response.body);
        final userData = responseData['user'];

        // Return the updated data from the response
        Navigator.pop(context, {
          "username": userData["username"],
          //"email": userData["email"],
          "profile_picture": userData["photo"],
        });

        showCustomSnackBar(
          message: responseData["message"] ?? "Profile updated successfully!",
          isError: false,
        );
      } else {
        // If only image was updated, just pop with the existing data
        Navigator.pop(context, {
          "username": nameController.text,
          //"email": emailController.text,
          "profile_picture": _imageFile != null
              ? null // You might want to handle this case differently
              : widget.initialImageUrl,
        });

        showCustomSnackBar(
          message: "Profile photo updated successfully!",
          isError: false,
        );
      }
    } catch (e) {
      showCustomSnackBar(
        message: "An error occurred: $e",
        isError: true,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<bool> _uploadProfilePhoto(File imageFile) async {
    try {
      setState(() => isUploadingImage = true);

      final Dio dio = Dio();
      const uploadUrl = "https://api.sabaijob.com/api/auth/profile-update/";
      final token = await TokenService.getToken();

      final formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
        ),
      });

      final response = await dio.put(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      showCustomSnackBar(
        message: "Failed to upload photo: ${e.toString()}",
        isError: true,
      );
      return false;
    } finally {
      setState(() => isUploadingImage = false);
    }
  }

  void showCustomSnackBar({required String message, required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: isError ? Colors.redAccent : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  Future<File?> _cropImage(File imageFile) async {
    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Profile Picture',
            toolbarColor: const Color(0xFFFF3997),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
          IOSUiSettings(
            title: 'Crop Profile Picture',
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
        ],
      );
      return croppedFile != null ? File(croppedFile.path) : null;
    } catch (e) {
      showCustomSnackBar(
        message: "Failed to crop image: $e",
        isError: true,
      );
      return null;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final croppedFile = await _cropImage(File(pickedFile.path));
        if (croppedFile != null) {
          setState(() {
            _imageFile = croppedFile;
            isEdited = true;
          });
        }
      }
    } catch (e) {
      showCustomSnackBar(
        message: "Failed to pick image: $e",
        isError: true,
      );
    }
  }

  void showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Image Source"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            ),
          ),
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Color(0xFFFF3997),
          ),
          title: const Text(
            'Edit Profile',
            style: appBarTitleStyleEng,
          ),
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[400],
                          child: ClipOval(
                            child: isUploadingImage
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : _imageFile != null
                                    ? Image.file(_imageFile!,
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 120)
                                    : widget.initialImageUrl.isNotEmpty
                                        ? Image.network(widget.initialImageUrl,
                                            fit: BoxFit.cover,
                                            width: 120,
                                            height: 120)
                                        : const Icon(Icons.person,
                                            size: 60, color: Colors.grey),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap:
                                isUploadingImage ? null : showImageSourceDialog,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF3997),
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.camera_alt,
                                  color: Colors.white, size: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  //const SizedBox(height: 20),
                  // TextFormField(
                  //   controller: emailController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Email',
                  //     prefixIcon: const Icon(Icons.email),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     filled: true,
                  //     fillColor: Colors.grey[100],
                  //   ),
                  //   keyboardType: TextInputType.emailAddress,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your email';
                  //     }
                  //     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  //         .hasMatch(value)) {
                  //       return 'Please enter a valid email address';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: isLoading ? null : saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF3997),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: textButtonTextStyleEng,
                          ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
