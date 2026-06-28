import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hash_micro_presence_test/shared/styles/app_font_style.dart';
import 'package:hash_micro_presence_test/shared/styles/color_style.dart';

class AppTheme {
  AppTheme._();

  static ThemeData light() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: ColorStyle.primary500,
      primary: ColorStyle.primary500,
      secondary: ColorStyle.secondary500,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Montserrat',
      colorScheme: colorScheme,
      // Soft neutral canvas so white cards/app bar read as crisp surfaces —
      // the clean, layered look common in modern ERP dashboards.
      scaffoldBackgroundColor: ColorStyle.neutral20,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorStyle.neutral0,
        foregroundColor: ColorStyle.neutral900,
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // Clear, clean title — controlled size, not the oversized M3 default.
        titleTextStyle: AppFontStyle.heading1SemiBold.copyWith(
          color: ColorStyle.neutral900,
          letterSpacing: -0.2,
        ),
        iconTheme: const IconThemeData(color: ColorStyle.neutral700),
        shape: const Border(
          bottom: BorderSide(color: ColorStyle.neutral40),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: ColorStyle.neutral0,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: ColorStyle.neutral40),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: ColorStyle.neutral40,
        thickness: 1,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorStyle.primary500,
          foregroundColor: ColorStyle.white,
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppFontStyle.body2SemiBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorStyle.primary500,
        foregroundColor: ColorStyle.white,
        elevation: 2,
        highlightElevation: 4,
        extendedTextStyle: AppFontStyle.body2SemiBold,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorStyle.neutral10,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        prefixIconColor: ColorStyle.neutral200,
        labelStyle: AppFontStyle.body2Regular.copyWith(
          color: ColorStyle.neutral300,
        ),
        hintStyle: AppFontStyle.body2Regular.copyWith(
          color: ColorStyle.neutral100,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorStyle.neutral40),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorStyle.neutral40),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorStyle.primary500,
            width: 1.5,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
