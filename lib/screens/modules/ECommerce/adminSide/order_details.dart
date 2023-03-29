import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:womanista/screens/modules/ECommerce/ProductClass.dart';
import 'package:womanista/variables/variables.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key, required this.orderData}) : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>>? orderData;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  QueryDocumentSnapshot<Map<String, dynamic>>? data;
  final db = FirebaseFirestore.instance.collection("E-Commerce");

  @override
  void initState() {
    data = widget.orderData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: Text("${data?.id}"),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            orderBy(),
            itemsList(),
            const Divider(),
            confirmOrder(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  orderBy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Order By:",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "User id: ${data?.data()['User']['id']} \nName: ${data?.data()['User']['Name']} \nEmail: ${data?.data()['User']['Email']}",
        ),
      ],
    );
  }

  itemsList() {
    log("length: ${data?.data()['Items'].length}");
    return Expanded(
      child: ListView.builder(
        itemCount: data?.data()['Items'].length,
        itemBuilder: (ctx, index) {
          final item = data?.data()['Items'][index];
          Product p = context
              .read<ProductProvider>()
              .products
              .firstWhere((element) => element.id == item['id']);
          return ListTile(
            leading: Image.network(
              p.img!,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("assets/productsLoading.gif");
              },
            ),
            title: Text(p.name!),
            subtitle: Text("x${item['count']}"),
          );
        },
      ),
    );
  }

  confirmOrder() {
    return ElevatedButton(
      onPressed: () {
        db.doc("Orders").collection("Orders").doc(data?.id).update(
          {'Status': "Confirmed"},
        ).then((value) {
          setState(() {});
          Navigator.of(context).pop();
        });
      },
      child: const Text("Confirm Order"),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppSettings.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(15),
      ),
    );
  }
}
