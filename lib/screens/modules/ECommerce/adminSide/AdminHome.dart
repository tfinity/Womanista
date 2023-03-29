import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/ECommerce/ProductClass.dart';
import 'package:womanista/screens/modules/ECommerce/adminSide/Orders.dart';
import 'package:womanista/screens/modules/ECommerce/adminSide/add_Product.dart';
import 'package:womanista/screens/modules/ECommerce/adminSide/edit_product.dart';
import 'package:womanista/variables/variables.dart';

class AdminHomeECommerce extends StatefulWidget {
  const AdminHomeECommerce({Key? key}) : super(key: key);

  @override
  State<AdminHomeECommerce> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHomeECommerce> {
  final db = FirebaseFirestore.instance.collection("E-Commerce");
  int orders = 0;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    //context.read<ProductProvider>().clear();
    log("here");
    db.doc("Orders").collection("Orders").get().then((value) {
      orders = value.docs.length;
      log("order: $orders");
      setState(() {});
    });
    // db.doc("Products").collection("Products").get().then((value) {
    //   for (var element in value.docs) {
    //     final data = element.data();
    //     context.read<ProductProvider>().add(
    //           Product(
    //             id: element.id,
    //             name: data['Name'],
    //             price: double.parse(data['Price']),
    //             description: data['Description'],
    //             img: data['image'],
    //             quantity: int.parse(data['Quantity']),
    //           ),
    //         );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: const Text("Ecommerce: Admin"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddProduct(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
            tooltip: 'Add Product',
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const Orders(),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: size.width * 0.05,
              child: Text(
                "$orders",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (ctx) => const AddProduct(),
          //       ),
          //     );
          //   },
          //   icon: Text("$orders"),
          //   tooltip: 'Current Orders',
          //   style: IconButton.styleFrom(
          //     backgroundColor: Colors.white,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(50),
          //     ),
          //     side: const BorderSide(
          //         color: Colors.white, width: 15, style: BorderStyle.solid),
          //   ),
          // ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Provider.of<ProductProvider>(context).products.isEmpty
            ? const Center(
                child: Text("No Items in Inventory"),
              )
            : ListView.builder(
                itemCount:
                    Provider.of<ProductProvider>(context).products.length,
                itemBuilder: (ctx, index) {
                  final product =
                      context.read<ProductProvider>().products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => EditProduct(product: product),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                              width: size.width * 0.15,
                              child: Image.network(
                                product.img!,
                                errorBuilder: (context, error, stackTrace) {
                                  return Column(
                                    children: [
                                      Image.asset(
                                        "assets/error-image.png",
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(product.name!),
                            const Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: AppSettings.mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
