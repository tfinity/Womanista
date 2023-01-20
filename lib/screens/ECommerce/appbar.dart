import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Appbar extends StatelessWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back, size: height * 0.04),
        ),
        Text(
          "Buy Products",
          style: GoogleFonts.ptSerif(
            fontSize: height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(FontAwesomeIcons.cartShopping, size: height * 0.04),
        ),
      ],
    );
  }
}
