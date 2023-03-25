import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  final db = FirebaseFirestore.instance.collection("E-Commerce");
  final storage = FirebaseStorage.instance.ref();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Product"),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      hintText: 'Product Name',
                      labelText: 'Name',
                    ),
                    validator: (s) {
                      if (s == null || s == '') {
                        return 'Field can not be Empty';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    controller: price,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Product PRice',
                      labelText: 'Price',
                    ),
                    validator: (s) {
                      if (s == null || s == '') {
                        return 'Field can not be Empty';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    controller: quantity,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Product Quantity',
                      labelText: 'Quantity',
                    ),
                    validator: (s) {
                      if (s == null || s == '') {
                        return 'Field can not be Empty';
                      }
                      if (s.contains(".")) {
                        return 'Quantity should be integer';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: TextFormField(
                    controller: description,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Product Description',
                      labelText: 'Description',
                    ),
                    validator: (s) {
                      if (s == null || s == '') {
                        return 'Field can not be Empty';
                      }
                      return null;
                    },
                  ),
                ),
                if (image != null) Text("${image?.name}"),
                ElevatedButton(
                  onPressed: () async {
                    image = await _picker.pickImage(
                      source: ImageSource.gallery,
                      maxHeight: 100,
                      maxWidth: 100,
                    );

                    if (image == null) {
                      print('null');
                      return;
                    }
                    print(image?.path);
                    setState(() {});
                  },
                  child: const Text("Add Image"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    showLoading();
                    if (_formKey.currentState!.validate()) {
                      print("Form is Valid");
                    } else {
                      print("Form is Invalid");
                      return;
                    }
                    final date = DateTime.now();
                    try {
                      await storage
                          .child("products/$date")
                          .putFile(File(image!.path));
                      await db.doc("Products").collection("Products").add({
                        'Name': name.text,
                        'Price': price.text,
                        'Quantity': quantity.text,
                        'Description': description.text,
                        'image': await storage
                            .child("products/$date")
                            .getDownloadURL(),
                      });
                    } on FirebaseException catch (e) {
                      print("erro: $e");
                    } finally {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Add Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showLoading() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return const AlertDialog(
          title: Text("Loading"),
          content: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
