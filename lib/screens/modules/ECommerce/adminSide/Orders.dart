import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:womanista/screens/modules/ECommerce/adminSide/order_details.dart';
import 'package:womanista/variables/variables.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final db = FirebaseFirestore.instance.collection("E-Commerce");

  @override
  void initState() {
    loadOrders();
    super.initState();
  }

  loadOrders() {
    db.doc("Orders").collection("Orders").get().then((value) {
      for (var element in value.docs) {
        print(element.data());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: const Text("Current Orders"),
      ),
      body: FutureBuilder(
        future: db.doc("Orders").collection("Orders").get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          log("$snapshot");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return waiting();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) {
                final data = snapshot.data?.docs[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(
                      MaterialPageRoute(
                        builder: (ctx) => OrderDetails(orderData: data),
                      ),
                    )
                        .then((value) {
                      setState(() {});
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  title: Text("# ${data?.id}"),
                  subtitle: Text(
                    "Name: ${data?.data()['User']['Name']} \nPrice: \$${data?.data()['Total Price']}\nStatus: ${data?.data()['Status'] ?? 'Pending'}",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                );
              },
            );
          }
          return waiting();
        },
      ),
    );
  }

  waiting() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          //height: height * 0.3,
          //width: width,
          child: Image.asset(
            "assets/productsLoading.gif",
            fit: BoxFit.fill,
          ),
        ),
        Text(
          "Loading...",
          style: AppSettings.textStyle(size: 18),
        ),
      ],
    );
  }
}
