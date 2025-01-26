import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker/image_picker.dart';
// package : image_picker: ^1.1.2
// in terminal : flutter pub add image_picker
Future PickImageFromGalary() async {
  try {
    return ImagePicker().pickImage(source: ImageSource.gallery);
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}

Future PickImageFromCamera() async {
  try {
    return ImagePicker().pickImage(source: ImageSource.camera);
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}

Future PickVideoFromCamera() async {
  try {
    return ImagePicker().pickVideo(source: ImageSource.camera);
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}

Future PickVideoFromGalary() async {
  try {
    return ImagePicker().pickVideo(source: ImageSource.gallery);
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}

Future PickMultiImageFromGalary() async {
  try {
    return ImagePicker().pickMultiImage();
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}

Future PickMediaFromGalary() async {
  try {
    return ImagePicker().pickMedia();
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}

Future PickMultiMediaFromGalary() async {
  try {
    return ImagePicker().pickMultipleMedia();
  } catch (e) {
    print("Error picking image: $e");
    return null;
  }
}
