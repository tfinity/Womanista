import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSettings {
  static Color mainColor = const Color.fromARGB(255, 235, 95, 88);
  static Color mainColorLignt = const Color.fromARGB(255, 199, 81, 75);
  static bool isDriverMode = false;
  static TextStyle textStyle({
    double size = 16,
    FontWeight weight = FontWeight.normal,
    Color textColor = Colors.black,
  }) {
    return GoogleFonts.ptSerif(
      fontSize: size,
      fontWeight: weight,
      color: textColor,
    );
  }
}
