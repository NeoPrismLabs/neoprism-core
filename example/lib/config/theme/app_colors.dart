import 'package:flutter/material.dart';

/// App color constants used throughout the example app
class AppColors {
  // Primary palette
  static const Color primary = Color(0xFFFFDC58);
  static const Color primaryLight = Color(0xFFFFF0B3);
  static const Color primaryDark = Color(0xFFE6C32E);
  static const Color onPrimary = Color(0xFF000000);

  // Secondary palette
  static const Color secondary = Color(0xFFFEF2E8);
  static const Color secondaryLight = Color(0xFFFFFBF7);
  static const Color secondaryDark = Color(0xFFE6D9D0);
  static const Color onSecondary = Color(0xFF000000);

  // Neutrals
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFAFAFA);
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
  static const Color info = Color(0xFF007AFF);

  // Blacks and grays
  static const Color black = Color(0xFF000000);
  static const Color gray900 = Color(0xFF212121);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);

  // Avoid instantiation
  const AppColors._();
}
