import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/ECommerce/ProductClass.dart';
import 'package:womanista/screens/modules/ECommerce/cart/cart_ItemsPage.dart';
import 'package:womanista/screens/modules/ECommerce/cart/cart_provider.dart';
import 'package:womanista/variables/variables.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          children: [
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              )),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          isFavourite = !isFavourite;
                          setState(() {});
                        },
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          color: AppSettings.mainColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.4,
                    width: width,
                    child: Image.network(
                      widget.product.img!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.name!,
                    style: AppSettings.textStyle(
                      size: 20,
                      weight: FontWeight.bold,
                      textColor: AppSettings.mainColor,
                    ),
                  ),
                  Text(
                    "\$ ${widget.product.price!}",
                    style: AppSettings.textStyle(size: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.product.description!,
                  style: AppSettings.textStyle(
                      size: 16, weight: FontWeight.normal),
                ),
              ),
            ),
            //Add to cart
            ElevatedButton(
              onPressed: () {
                context.read<Cart>().add(CartItem(
                      id: widget.product.id,
                      name: widget.product.name,
                      count: 1,
                      des: widget.product.description,
                      img: widget.product.img,
                      price: widget.product.price,
                    ));

                showModalBottomSheet(
                  context: context,
                  builder: (ctx) {
                    return  Column(
                      children: [
                        Expanded(
                          child: CartItemsPage(
                            id: 1,
                          ),
                        ),
                      ],
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const CartPage(),
                //   ),
                // );
              },
              child: const FaIcon(
                FontAwesomeIcons.cartPlus,
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppSettings.mainColor),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
              ),
            ),
            // Text(
            //   "+ Add to Cart",
            //   style: AppSettings.textStyle(size: 20),
            // ),
            SizedBox(
              height: height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
