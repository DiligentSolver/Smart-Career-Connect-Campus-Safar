import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CSTextTheme {
  CSTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.openSans(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: GoogleFonts.openSans(
        fontSize: 26.0, fontWeight: FontWeight.w500, color: Colors.black),
    displaySmall: GoogleFonts.openSans(
        fontSize: 24.0, fontWeight: FontWeight.w300, color: Colors.black),
    headlineLarge: GoogleFonts.openSans(
        fontSize: 22.0, fontWeight: FontWeight.w800, color: Colors.black),
    headlineMedium: GoogleFonts.openSans(
        fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.black),
    headlineSmall: GoogleFonts.openSans(
        fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.black),
    titleLarge: GoogleFonts.openSans(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black),
    titleMedium: GoogleFonts.openSans(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.black.withOpacity(0.8)),
    titleSmall: GoogleFonts.openSans(fontSize: 14.0, color: Colors.black),
    bodyLarge: GoogleFonts.openSans(
        fontSize: 14.0, color: Colors.black.withOpacity(0.8)),
    bodyMedium: GoogleFonts.openSans(
        fontSize: 12.0, color: Colors.black.withOpacity(0.8)),
    bodySmall: GoogleFonts.openSans(fontSize: 12.0, color: Colors.grey),
  );
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.openSans(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: GoogleFonts.openSans(
        fontSize: 26.0, fontWeight: FontWeight.w500, color: Colors.white),
    displaySmall: GoogleFonts.openSans(
        fontSize: 24.0, fontWeight: FontWeight.w300, color: Colors.white),
    headlineLarge: GoogleFonts.openSans(
        fontSize: 22.0, fontWeight: FontWeight.w800, color: Colors.white),
    headlineMedium: GoogleFonts.openSans(
        fontSize: 20.0, fontWeight: FontWeight.w700, color: Colors.white),
    headlineSmall: GoogleFonts.openSans(
        fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white),
    titleLarge: GoogleFonts.openSans(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleMedium: GoogleFonts.openSans(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withOpacity(0.8)),
    titleSmall: GoogleFonts.openSans(fontSize: 14.0, color: Colors.white),
    bodyLarge: GoogleFonts.openSans(
        fontSize: 14.0, color: Colors.white.withOpacity(0.8)),
    bodyMedium: GoogleFonts.openSans(
        fontSize: 12.0, color: Colors.white.withOpacity(0.8)),
    bodySmall: GoogleFonts.openSans(fontSize: 12.0, color: Colors.grey),
  );
}
