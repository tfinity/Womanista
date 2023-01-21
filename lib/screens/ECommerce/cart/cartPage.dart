import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:womanista/screens/ECommerce/cart/address_page.dart';
import 'package:womanista/screens/ECommerce/cart/cart_ItemsPage.dart';
import 'package:womanista/screens/ECommerce/cart/cart_order_complet_page.dart';
import 'package:womanista/screens/ECommerce/cart/cart_payment_page.dart';
import 'package:womanista/variables/variables.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String pageTitle = "Cart";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    EdgeInsets padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: padding.top,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              const DotsIndicator(),
              IconButton(
                onPressed: () {
                  //Provider.of<Cart>(context, listen: false).incrementPage();
                  context.read<Cart>().incrementPage();
                  print(context.read<Cart>().cartPageIndex);
                },
                icon: const FaIcon(
                  FontAwesomeIcons.cartShopping,
                ),
              ),
            ],
          ),
          Text(
            Provider.of<Cart>(context).cartPageIndex == 0
                ? "Cart"
                : Provider.of<Cart>(context).cartPageIndex == 1
                    ? "Address"
                    : Provider.of<Cart>(context).cartPageIndex == 2
                        ? "Payment"
                        : "Thank You",
            style: AppSettings.textStyle(
              size: height * 0.03,
              weight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: Provider.of<Cart>(context).cartPageIndex,
              children: const [
                CartItemsPage(),
                CartAddressPage(),
                CartPaymentPage(),
                OrderCompletePage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DotsIndicator extends StatefulWidget {
  const DotsIndicator({Key? key}) : super(key: key);

  @override
  State<DotsIndicator> createState() => _DotsIndicatorState();
}

class _DotsIndicatorState extends State<DotsIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomPaint(
          painter: CirclePainter(1, context),
          size: const Size(15, 15),
        ),
        Container(
          height: 4,
          width: 30,
          color: Provider.of<Cart>(context).cartPageIndex >= 1
              ? AppSettings.mainColor
              : Colors.grey,
        ),
        CustomPaint(
          painter: CirclePainter(2, context),
          size: const Size(15, 15),
        ),
        Container(
          height: 4,
          width: 30,
          color: Provider.of<Cart>(context).cartPageIndex >= 2
              ? AppSettings.mainColor
              : Colors.grey,
        ),
        CustomPaint(
          painter: CirclePainter(3, context),
          size: const Size(15, 15),
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  final int id;
  final BuildContext context;

  CirclePainter(this.id, this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..color = context.read<Cart>().cartPageIndex >= id
          ? AppSettings.mainColor
          : Colors.grey
      ..strokeWidth = 10
      // Use [PaintingStyle.fill] if you want the circle to be filled.
      ..style = PaintingStyle.stroke;
    canvas.drawOval(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
