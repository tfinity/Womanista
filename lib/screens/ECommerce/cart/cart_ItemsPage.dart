import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/ECommerce/cart/cart_items_list_view.dart';
import 'package:womanista/screens/ECommerce/cart/cart_provider.dart';
import 'package:womanista/variables/variables.dart';

class CartItemsPage extends StatefulWidget {
  const CartItemsPage({Key? key}) : super(key: key);

  @override
  State<CartItemsPage> createState() => _CartItemsPageState();
}

class _CartItemsPageState extends State<CartItemsPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Expanded(child: CartItemsListView()),
        const Divider(
          thickness: 2,
        ),
        SizedBox(
          width: width,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: height * 0.04,
              left: width * 0.03,
              right: width * 0.03,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: ",
                  style: AppSettings.textStyle(size: width * 0.06),
                ),
                Text(
                  "\$${Provider.of<Cart>(context).totalPrice}",
                  style: AppSettings.textStyle(size: width * 0.06),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: width * 0.1,
            right: width * 0.1,
            bottom: height * 0.05,
          ),
          child: ElevatedButton(
            onPressed: () {
              context.read<Cart>().incrementPage();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address",
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
              backgroundColor: MaterialStateProperty.all(AppSettings.mainColor),
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
    );
  }
}
