import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPostController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  Rx<Position?> position = Rx<Position?>(null);
  RxString address = ''.obs;
  Rx<Uint8List?> watermarkedImgBytes = Rx<Uint8List?>(null);

  // Text Editing Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Dropdown categories
  RxString selectedCategory = 'Regular Post'.obs;
  final List<String> categories = [
    'Regular Post',
    'Community Service Post',
    'Lost & Found Post'
  ];

  Future<void> captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File originalImage = File(pickedFile.path);
      Uint8List imgBytes = await originalImage.readAsBytes();
      image.value = originalImage;
      getCurrentLocation();
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );
    position.value = pos;
    getAddressFromCoordinates(pos.latitude, pos.longitude);
  }

  Future<void> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        address.value = "${place.street}, ${place.locality}, ${place.country}";
        addressController.text = address.value;
      }
    } catch (e) {
      print("Error retrieving address: $e");
    }
  }
}
