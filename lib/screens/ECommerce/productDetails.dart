import 'package:flutter/material.dart';
import 'package:womanista/screens/ECommerce/ProductClass.dart';

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
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                        ),
                      ),
                    ],
                  ),
                  Image.asset("${widget.product.img!}.png"),
                ],
              ),
            ),
            Row(
              children: [
                Text(widget.product.name!),
                Text("\$ ${widget.product.price!}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
