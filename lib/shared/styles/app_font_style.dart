import 'package:flutter/material.dart';

/// AppFontStyle
///
/// Kumpulan gaya teks dengan family Montserrat.
/// Setiap kategori (Light, Regular, Medium, SemiBold, Bold)
/// memiliki ukuran konsisten sesuai skala typografi desain.
class AppFontStyle {
  AppFontStyle._();

  static TextStyle montserrat(double size, FontWeight weight) {
    return TextStyle(
      fontFamily: "Montserrat",
      fontSize: size,
      fontWeight: weight,
    );
  }

  static TextStyle inter(double size, FontWeight weight) {
    return TextStyle(fontFamily: "Inter", fontSize: size, fontWeight: weight);
  }

  static TextStyle rajdhani(double size, FontWeight weight) {
    return TextStyle(
      fontFamily: "Rajdhani",
      fontSize: size,
      fontWeight: weight,
    );
  }

  // === Light (w300) ===
  static const TextStyle display2Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 28,
  );
  static const TextStyle display1Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 24,
  );
  static const TextStyle heading2Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 21,
  );
  static const TextStyle heading1Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 18,
  );
  static const TextStyle body3Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 16,
  );
  static const TextStyle body2Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 14,
  );
  static const TextStyle body1Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 12,
  );
  static const TextStyle caption2Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 11,
  );
  static const TextStyle caption1Light = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w300,
    fontSize: 9,
  );

  // === Regular (w400) ===
  static const TextStyle display2Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 28,
  );
  static const TextStyle display1Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );
  static const TextStyle heading2Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 21,
  );
  static const TextStyle heading1Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  static const TextStyle body3Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );
  static const TextStyle body2Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static const TextStyle body1Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );
  static const TextStyle caption2Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 11,
  );
  static const TextStyle caption1Regular = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 9,
  );

  // === Medium (w500) ===
  static const TextStyle display2Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 28,
  );
  static const TextStyle display1Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 24,
  );
  static const TextStyle heading2Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 21,
  );
  static const TextStyle heading1Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static const TextStyle body3Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const TextStyle body2Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
  static const TextStyle body1Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  static const TextStyle caption2Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 11,
  );
  static const TextStyle caption1Medium = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w500,
    fontSize: 9,
  );

  // === SemiBold (w600) ===
  static const TextStyle display2SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 28,
  );
  static const TextStyle display1SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 24,
  );
  static const TextStyle heading2SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 21,
  );
  static const TextStyle heading1SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static const TextStyle body3SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static const TextStyle body2SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static const TextStyle body1SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 12,
  );
  static const TextStyle caption2SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 11,
  );
  static const TextStyle caption1SemiBold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w600,
    fontSize: 9,
  );

  // === Bold (w700) ===
  static const TextStyle display2Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 28,
  );
  static const TextStyle display1Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );
  static const TextStyle heading2Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 21,
  );
  static const TextStyle heading1Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
  static const TextStyle body3Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );
  static const TextStyle body2Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );
  static const TextStyle body1Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );
  static const TextStyle caption2Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 11,
  );
  static const TextStyle caption1Bold = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w700,
    fontSize: 9,
  );

  // === Inter ===
  static const TextStyle body1RegularInter = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  // === Rajdhani ===
  static const TextStyle heading1BoldRajdhani = TextStyle(
    fontFamily: 'Rajdhani',
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );
}
