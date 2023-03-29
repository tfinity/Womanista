import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  bool isEditing = false;
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();

  @override
  void initState() {
    populateData();
    super.initState();
  }

  populateData() {
    name.text = widget.product.name!;
    price.text = widget.product.price.toString();
    description.text = widget.product.description!;
    quantity.text = widget.product.quantity.toString();
  }

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
                        onPressed: () async {
                          if (isEditing) {
                            log("now");
                            loadingIndicator();
                            FirebaseFirestore.instance
                                .collection("E-Commerce")
                                .doc("Products")
                                .collection("Products")
                                .doc(widget.product.id)
                                .update({
                              'Name': name.text,
                              'Price': price.text,
                              'Quantity': quantity.text,
                              'Description': description.text,
                            }).then((value) => Navigator.of(context).pop());
                          }
                          isEditing = !isEditing;
                          setState(() {});
                        },
                        icon: Icon(
                          !isEditing ? Icons.edit : Icons.done,
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
              child: !isEditing
                  ? Row(
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
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: width * 0.3,
                          child: TextField(
                            controller: name,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.3,
                          child: TextField(
                            controller: price,
                          ),
                        ),
                      ],
                    ),
            ),

            !isEditing
                ? Text("Quantity: ${widget.product.quantity}")
                : SizedBox(
                    width: width * 0.2,
                    child: TextField(controller: quantity),
                  ),
            !isEditing
                ? Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.product.description!,
                        style: AppSettings.textStyle(
                            size: 16, weight: FontWeight.normal),
                      ),
                    ),
                  )
                : SizedBox(
                    width: width * 0.9,
                    child: TextField(
                      controller: description,
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

  loadingIndicator() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return const SimpleDialog(
          children: [
            Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }
}
