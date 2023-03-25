import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/ECommerce/ProductClass.dart';
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

  @override
  void initState() {
    //loadData();
    super.initState();
  }

  Future<void> loadData() async {
    log("here");
    db.doc("Products").collection("Products").get().then((value) {
      for (var element in value.docs) {
        final data = element.data();
        context.read<ProductProvider>().add(
              Product(
                  id: element.id,
                  name: data['Name'],
                  price: double.parse(data['Price']),
                  description: data['Description'],
                  img: data['image']),
            );
      }
    });
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
