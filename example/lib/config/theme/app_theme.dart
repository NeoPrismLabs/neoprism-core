import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoprism_core/neoprism_core.dart';
import 'app_colors.dart';

/// Theme configuration for the example app
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
      ),

      // Set primary color
      primaryColor: AppColors.primary,

      // Button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          textStyle: _buttonTextStyle,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: _headingTextStyle.copyWith(fontSize: 32, height: 1.2),
        displayMedium: _headingTextStyle.copyWith(fontSize: 28, height: 1.2),
        displaySmall: _headingTextStyle.copyWith(fontSize: 24, height: 1.3),
        headlineLarge: _headingTextStyle.copyWith(fontSize: 20, height: 1.4),
        headlineMedium: _headingTextStyle.copyWith(fontSize: 18, height: 1.4),
        bodyLarge: _bodyTextStyle.copyWith(fontSize: 16, height: 1.5),
        bodyMedium: _bodyTextStyle.copyWith(fontSize: 14, height: 1.5),
        labelLarge: _buttonTextStyle,
      ),

      // Scaffold background color
      scaffoldBackgroundColor: AppColors.background,

      // App bar theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        titleTextStyle: _headingTextStyle.copyWith(
          fontSize: 20,
          color: AppColors.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),

      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: AppColors.white,
      ),

      // Extensions
      extensions: [
        // NeoPrism custom theme
        NeoPrismThemeData(
          borderWidth: 1.5,
          borderRadius: 4.0,
          shadowOffset: const Offset(4, 4),
          // buttonTextStyle: _buttonTextStyle,
          // labelTextStyle: _bodyTextStyle.copyWith(fontSize: 14),
          // headlineTextStyle: _headingTextStyle,
        ),
      ],
    );
  }

  /// Get the dark theme for the app
  static ThemeData get darkTheme {
    // For now, we'll use the same theme
    // In a real app, you'd define dark mode colors
    return lightTheme;
  }

  // Text styles
  static final TextStyle _headingTextStyle = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.bold,
    color: AppColors.gray900,
    letterSpacing: -0.5,
  );

  static final TextStyle _bodyTextStyle = GoogleFonts.inter(
    fontWeight: FontWeight.normal,
    color: AppColors.gray800,
  );

  static final TextStyle _buttonTextStyle = GoogleFonts.spaceGrotesk(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  // Private constructor to prevent instantiation
  const AppTheme._();
}
