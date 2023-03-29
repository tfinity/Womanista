import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/ECommerce/cart/cart_provider.dart';
import 'package:womanista/variables/variables.dart';

class CartPaymentPage extends StatefulWidget {
  const CartPaymentPage({Key? key}) : super(key: key);

  @override
  State<CartPaymentPage> createState() => _CartPaymentPageState();
}

class _CartPaymentPageState extends State<CartPaymentPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cash on Delivery",
                  style: AppSettings.textStyle(),
                ),
                CustomPaint(
                  painter: CirclePainter(1, context),
                  size: const Size(15, 15),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Card Payment (Unavailable)",
                  style: AppSettings.textStyle(),
                ),
                CustomPaint(
                  painter: CirclePainter(0, context),
                  size: const Size(15, 15),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Items: ",
                  style: AppSettings.textStyle(),
                ),
                Text(
                  "${Provider.of<Cart>(context).count}",
                  style: AppSettings.textStyle(),
                )
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total Price: ",
                  style: AppSettings.textStyle(),
                ),
                Text(
                  "\$${Provider.of<Cart>(context).totalPrice}",
                  style: AppSettings.textStyle(),
                )
              ],
            ),
            SizedBox(
              height: height * 0.2,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                bottom: height * 0.05,
              ),
              child: ElevatedButton(
                onPressed: () {
                  User user = FirebaseAuth.instance.currentUser!;
                  FirebaseFirestore.instance
                      .collection("E-Commerce")
                      .doc("Orders")
                      .collection("Orders")
                      .add(
                    {
                      "User": {
                        "id": user.uid,
                        "Name": user.displayName ?? '',
                        "Email": user.email ?? user.phoneNumber ?? '',
                      },
                      'Items': context
                          .read<Cart>()
                          .products
                          .map((e) => e.toJsonIdCount())
                          .toList(),
                      'Total Price': context.read<Cart>().totalPrice,
                    },
                  ).then(
                    (value) {
                      context.read<Cart>().products.clear();
                      context.read<Cart>().incrementPage();
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Confirm",
                      style: AppSettings.textStyle(
                        textColor: Colors.white,
                        size: width * 0.05,
                        weight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppSettings.mainColor),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(15),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
      ..color = id == 1 ? AppSettings.mainColor : Colors.grey
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
