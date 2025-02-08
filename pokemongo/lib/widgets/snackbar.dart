import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  static void showInfo(String message) {
    _showSnackbar('Info', message, Colors.blue);
  }

  static void showWarning(String message) {
    _showSnackbar('Warning', message, Colors.orange);
  }

  static void showError(String message) {
    _showSnackbar('Error', message, Colors.red);
  }

  static void showSuccess(String message) {
    _showSnackbar('Success', message, Colors.green);
  }

  static void _showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.white,
      colorText: Get.isDarkMode ? Colors.white : Colors.black,
      borderRadius: 8,
      margin: const EdgeInsets.all(10),
      icon: Icon(Icons.info, color: color),
      duration: const Duration(seconds: 1),
    );
  }
}
