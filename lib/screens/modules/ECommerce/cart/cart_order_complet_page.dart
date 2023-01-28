import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/ECommerce/cart/cart_provider.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/variables/variables.dart';

class OrderCompletePage extends StatefulWidget {
  const OrderCompletePage({Key? key}) : super(key: key);

  @override
  State<OrderCompletePage> createState() => _OrderCompletePageState();
}

class _OrderCompletePageState extends State<OrderCompletePage> {
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
            Text(
              "Your Order has been placed. You will receive an Email reciept shortly",
              softWrap: true,
              style: AppSettings.textStyle(),
            ),
            Image.asset("assets/ordercomplete.png"),
            SizedBox(
              height: height * 0.1,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                bottom: height * 0.05,
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false);
                  context.read<Cart>().resetPage();
                },
                child: Text(
                  "Go to Home",
                  style: AppSettings.textStyle(
                    textColor: Colors.white,
                    size: width * 0.05,
                    weight: FontWeight.bold,
                  ),
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
