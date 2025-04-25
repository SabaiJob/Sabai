import 'package:flutter/material.dart';
import 'package:sabai_app/constants.dart';
import 'package:sabai_app/screens/auth_pages/api_service.dart';

class EditProfile extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  const EditProfile({super.key, required this.initialName, required this.initialEmail});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  bool isLoading = false;
  bool isEdited = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.initialName);
    emailController = TextEditingController(text: widget.initialEmail);
    nameController.addListener(trackChanges);
    emailController.addListener(trackChanges);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void trackChanges(){
    setState(() {
      isEdited = nameController.text != widget.initialName || emailController.text != widget.initialEmail;
    });
  }

  Future<void>  saveProfile()async{
    if(!isEdited){
      Navigator.pop(context);
      return;
    }
    
    String updatedName = nameController.text;
    String updatedEmail = emailController.text;
    if (updatedName.isEmpty || updatedEmail.isEmpty) {
    showCustomSnackBar(
      message: "Name and email cannot be empty!",
      isError: true,
    );
    return;
  }

   try{
    final response = await ApiService.put('/auth/profile-update/', {
      "username": updatedName, "email" : updatedEmail
    });
    if(response.statusCode >= 200 && response.statusCode < 300){
      showCustomSnackBar(
        message: "Profile updated successfully!",
        isError: false,
      );
      Navigator.pop(context, {"username": updatedName, "email": updatedEmail});
    }
    else{
      showCustomSnackBar(
        message: "Failed to update profile. Please try again.",
        isError: true,
      );
    }
   }catch(e){
    showCustomSnackBar(
      message: "An error occurred: $e",
      isError: true,
    );
   }
  }

  void showCustomSnackBar({required String message, required bool isError}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      //backgroundColor: isError ? Colors.redAccent : Colors.green,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      action: SnackBarAction(
        label: "Dismiss",
        textColor: Colors.white,
        onPressed: () {},
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color(0xFFFF3997),
        ),
        title: const Text('Edit Profile', style: appBarTitleStyleEng,),
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
                // Profile picture placeholder
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[200],
                        child: const Icon(Icons.person,
                            size: 60, color: Colors.grey),
                      ),
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).primaryColor,
                      //       shape: BoxShape.circle,
                      //     ),
                      //     padding: const EdgeInsets.all(8),
                      //     child: const Icon(Icons.camera_alt,
                      //         color: Colors.white, size: 20),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Name field
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
                const SizedBox(height: 20),
                // Email field
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                // Submit button
                ElevatedButton(
                  onPressed: saveProfile,
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
    );
  }
}
