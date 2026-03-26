import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Learn Arabic in English';
  static const String appLogo = 'assets/app_logo.png';
  static const String appVersion = '1.0.0';
  static const String developer = 'Divine Technology';
  static const String supportEmail = 'support.learnarabic.eng@gmail.com';

  // Colors
  static const Color primaryColor = Color(0xFF075E54); // Dark Green
  static const Color secondaryColor = Color(0xFF128C7E); // Green
  static const Color accentColor = Color(0xFF25D366); // Light Green
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF333333);
  static const Color lightTextColor = Color(0xFF666666);
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
  static const Color warningColor = Color(0xFFFFA000);

  // Font Sizes
  static const double headingSize = 24.0;
  static const double subheadingSize = 20.0;
  static const double bodySize = 16.0;
  static const double smallSize = 14.0;

  // Splash Screen Text
  static const List<String> splashQuotes = [
    'Language is the road map of a culture',
    'Learn a new language, discover a new world',
    'Arabic is the language of poetry and science',
    'Every word you learn opens a new door',
    'Speak Arabic, connect with millions',
  ];
  // Padding
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 800);
}
