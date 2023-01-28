import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSettings {
  static Color mainColor = const Color.fromARGB(255, 255, 83, 83);
  static Color mainColorLignt = const Color.fromARGB(167, 255, 83, 83);
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
