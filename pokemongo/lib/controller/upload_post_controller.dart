import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pokemongo/constants.dart';
import 'package:pokemongo/controller/community_service_controller.dart';
import 'package:pokemongo/controller/lost_and_found_controller.dart';
import 'package:pokemongo/controller/map_controller.dart';
import 'package:pokemongo/controller/problem_post_controller.dart';
import 'package:pokemongo/models/lost_and_found_model.dart';
import 'dart:io';

import 'package:pokemongo/models/problems_post_model.dart';
import 'package:pokemongo/service/api_service.dart';
import 'package:pokemongo/service/shared_preferences_service.dart';
import 'package:pokemongo/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadPostController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  Rx<Position?> position = Rx<Position?>(null);
  RxString address = ''.obs;
  Rx<Uint8List?> watermarkedImgBytes = Rx<Uint8List?>(null);
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  RxInt coins = 0.obs;

  // Text Editing Controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController tagsController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  MapController mapController = Get.put(MapController());
  MumbaiMapController mumbaiMapController = Get.put(MumbaiMapController());
  // Dropdown categories
  RxString selectedCategory = 'Regular Post'.obs;
  final List<String> categories = [
    'Regular Post',
    'Community Service Post',
    'Lost & Found Post'
  ];

  final String profilePic = 'assets/images/profile.png';

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
    latitude.value = pos.latitude;
    longitude.value = pos.longitude;
    getAddressFromCoordinates(pos.latitude, pos.longitude);
  }

  Future<void> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        address.value = "${place.street}, ${place.locality}, ${place.country}";
        addressController.text = address.value;
      }
    } catch (e) {
      print("Error retrieving address: $e");
    }
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    dio.FormData formData = dio.FormData.fromMap({
      "image": await dio.MultipartFile.fromFile(file.path, filename: fileName),
    });

    final response = await Dio().post(
        "https://pleasant-nearby-hermit.ngrok-free.app/pokemon_images/upload.php",
        data: formData);
    String url = response.data['imageUrl'].toString().replaceAll(
        "http://localhost", "https://pleasant-nearby-hermit.ngrok-free.app");
    return url;
  }

  void uploadPost() async {
    if (selectedCategory.value == 'Regular Post') {
      if (descriptionController.text.isEmpty || image.value == null) {
        Get.snackbar("Error", "Description and image are required!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        return;
      }

      // Generate a unique post I

      String imageUrl = await uploadImage(image.value!);
      print(imageUrl);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;
      print(token);

      final response = await apiService.post("/post", body: {
        "imgUrl": imageUrl.toString(),
        "description": descriptionController.text,
        "latitude": latitude.value,
        "longitude": longitude.value,
        "token": SharedPreferencesService.getString('token'),
        "tags": tagsController.text.split(","),
        "address": address.value,
      });
      print(response);
      // Add marker to the map
      if (latitude.value != 0.0 && longitude.value != 0.0) {
        mumbaiMapController.addMarker(latitude.value, longitude.value);
      }

      Get.snackbar("Success", "Post uploaded successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);

      // Clear the form after successful upload
      descriptionController.clear();
      image.value = null;
      position.value = null;
      address.value = "";
      latitude.value = 0;
      longitude.value = 0;

      Get.back();
      ProblemPostController problemPostController =
          Get.find<ProblemPostController>();
      problemPostController.fetchPosts();
    } else if (selectedCategory.value == 'Community Service Post') {
      String imageUrl = await uploadImage(image.value!);
      print(imageUrl);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;
      print(descriptionController.text);
      final response = await apiService.post("/event", body: {
        "imgUrl": imageUrl,
        "description": titleController.text,
        "token": token,
        "tags": tagsController.text.split(","),
        "eventDate": dateController.text,
        "address": address.value,
        "latitude": latitude.value,
        "longitude": longitude.value,
      });
      print(response);

      // Clear form
      descriptionController.clear();
      image.value = null;
      address.value = "";

      CommunityServiceController communityServiceController =
          Get.find<CommunityServiceController>();

      communityServiceController.fetchAllEvents();

      Get.back();
      SnackbarService.showSuccess("Social Event Created Successfully!");
      coins.value += 10;

      // Handle Community Service Post
    } else if (selectedCategory.value == 'Lost & Found Post') {
      String imageUrl = await uploadImage(image.value!);
      print(imageUrl);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token')!;

      final response = await apiService.post("/lostandfound/createPost", body: {
        "imgUrl": imageUrl,
        "description": descriptionController.text,
        "token": token,
        "tags": tagsController.text.split(","),
        "address": address.value,
        "latitude": latitude.value,
        "longitude": longitude.value,
      });
      coins.value += 10;
      print(132948723);
      print(response);
      Get.back();
      Get.back();
      SnackbarService.showSuccess("Lost and Found Post Created Successfully!");
      LostAndFoundController problemPostController =
          Get.find<LostAndFoundController>();
      problemPostController.fetchAllLostAndFound();
    } else {
      return;
    }
  }
}
