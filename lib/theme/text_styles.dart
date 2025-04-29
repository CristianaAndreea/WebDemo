import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle pageContentStyle(Size size) => GoogleFonts.ubuntu(
  fontSize: size.height * 0.025,
);

class WebTextStyles {
  // Headings
  static const TextStyle heading1 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 48,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle heading4 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  // Body Text
  // XLarge
  static const TextStyle bodyXLargeBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyXLargeSemiBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyXLargeMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyXLargeRegular = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  // Large
  static const TextStyle bodyLargeBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyLargeSemiBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLargeMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyLargeRegular = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  // Medium
  static const TextStyle bodyMediumBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyMediumSemiBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyMediumRegular = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Small
  static const TextStyle bodySmallBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodySmallSemiBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodySmallMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodySmallRegular = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  // Extra Small
  static const TextStyle bodyXSmallBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyXSmallSemiBold = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyXSmallMedium = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle bodyXSmallRegular = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    fontWeight: FontWeight.normal,
  );
}