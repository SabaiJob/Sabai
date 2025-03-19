import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker picker = ImagePicker();

  // select single photo
  Future<FileImage?> pickImage(ImageSource source) async {
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      return FileImage(File(image.path));
    }
    return null;
  }

  // select multiple photos
  Future<List<XFile>> pickMultipleImage() async {
    try {
      final multipleImages = await picker.pickMultiImage();
      return multipleImages;
    } catch (e) {
      print('Error picking images: $e');
      return []; // Return an empty list on error
    }
  }

  Future<List<XFile>> takeImage() async {
    final image = await picker.pickImage(source: ImageSource.camera);
    try {
      List<XFile> images = [image!];
      return images;
    } catch (e) {
      print('Error taking images: $e');
      return []; // Return an empty list on error
    }
  }
  //
}
