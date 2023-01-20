import 'package:flutter/material.dart';
import 'package:womanista/screens/ECommerce/ProductClass.dart';
import 'package:womanista/screens/ECommerce/productDetails.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<Product> products = [
    Product(
      name: "Product 1",
      price: "46.2\$",
      img: "assets/img",
    ),
    Product(
      name: "Product 2",
      price: "94.2\$",
      img: "assets/img",
    ),
    Product(
      name: "Product 3",
      price: "85.2\$",
      img: "assets/img",
    ),
    Product(
      name: "Product 4",
      price: "35.2\$",
      img: "assets/img",
    ),
    Product(
      name: "Product 5",
      price: "40\$",
      img: "assets/img",
    ),
    Product(
      name: "Product 6",
      price: "102.2\$",
      img: "assets/img",
    ),
    Product(
      name: "Product 7",
      price: "55.2\$",
      img: "assets/img",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Expanded(
        child: GridView.builder(
      itemCount: products.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetails(
                      product: products[index],
                    )));
          },
          child: Card(
              child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Image.asset("${products[index].img!}.png"),
                Text(products[index].name!),
                Text(products[index].price!),
              ],
            ),
          )),
        );
      },
    ));
  }
}
