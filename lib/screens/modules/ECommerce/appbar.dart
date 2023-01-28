import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:womanista/screens/modules/ECommerce/cart/cartPage.dart';
import 'package:womanista/variables/variables.dart';

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
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, size: height * 0.04),
        ),
        Text(
          "Buy Products",
          style: AppSettings.textStyle(
              size: height * 0.03,
              weight: FontWeight.bold,
              textColor: AppSettings.mainColor),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const CartPage()));
          },
          icon: FaIcon(FontAwesomeIcons.cartShopping, size: height * 0.04),
        ),
      ],
    );
  }
}
