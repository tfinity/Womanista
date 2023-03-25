import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/ECommerce/cart/cart_provider.dart';
import 'package:womanista/variables/variables.dart';

class CartItemsListView extends StatefulWidget {
  const CartItemsListView({Key? key}) : super(key: key);

  @override
  State<CartItemsListView> createState() => _CartItemsListViewState();
}

class _CartItemsListViewState extends State<CartItemsListView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final cart = Provider.of<Cart>(context);
    return ListView.builder(
      itemCount: cart.count,
      itemBuilder: (context, index) {
        cart.cartProducts[index];
        return SizedBox(
          height: height * 0.2,
          width: width,
          child: Stack(
            children: [
              Row(
                children: [
                  Image.network("${cart.cartProducts[index].img}"),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cart.cartProducts[index].name!,
                              style: AppSettings.textStyle(size: 20),
                            ),
                            Text(
                              ("\$${(cart.cartProducts[index].price! * cart.cartProducts[index].count).round()}"),
                              style: AppSettings.textStyle(
                                  weight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              context
                                  .read<Cart>()
                                  .incrementQuantity(cart.cartProducts[index]);
                            },
                            child: Text(
                              "+",
                              style: AppSettings.textStyle(size: width * 0.1),
                            ),
                          ),
                          Text(
                            "${cart.cartProducts[index].count}",
                            style: AppSettings.textStyle(
                              size: width * 0.1,
                              weight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<Cart>()
                                  .decrementQuantity(cart.cartProducts[index]);
                            },
                            child: Text(
                              "-",
                              style: AppSettings.textStyle(size: width * 0.1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    context.read<Cart>().remove(cart.cartProducts[index]);
                  },
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
