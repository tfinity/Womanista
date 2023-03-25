import 'package:flutter/material.dart';
import 'package:womanista/screens/modules/ECommerce/ProductClass.dart';
import 'package:womanista/variables/variables.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
            const Text("Quantity"),
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

            SizedBox(
              height: height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
