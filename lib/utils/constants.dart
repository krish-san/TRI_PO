import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppConstants {
  // Colors
  static const Color primaryColor = Color(0xFF1A237E);
  static const Color secondaryColor = Color(0xFF304FFE);
  static const Color accentColor = Color(0xFFFFC107);
  
  // Text Styles
  static TextStyle get headingStyle => const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );
  
  static TextStyle get subheadingStyle => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
  
  // Input Decorations
  static InputDecoration get inputDecoration => InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade400),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: primaryColor, width: 2),
    ),
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  );
  
  // Button Styles
  static ButtonStyle get primaryButtonStyle => ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
  
  // Validation
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
  
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    return null;
  }
  
  // Date Formatting
  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }
  
  // Image Picker Options
  static const double maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png'];
  
  // App Text
  static const String appName = 'Trichy Police Department';
  static const String appSubtitle = 'Crime Management System';
  
  // Error Messages
  static const String networkError = 'Please check your internet connection';
  static const String serverError = 'Server error occurred. Please try again later';
  static const String unknownError = 'An unexpected error occurred';
  
  // Success Messages
  static const String saveSuccess = 'Data saved successfully';
  static const String updateSuccess = 'Data updated successfully';
  static const String deleteSuccess = 'Data deleted successfully';
}
