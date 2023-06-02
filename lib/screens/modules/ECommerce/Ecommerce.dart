import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:womanista/screens/modules/ECommerce/Products.dart';
import 'package:womanista/screens/modules/ECommerce/adminSide/AdminHome.dart';
import 'package:womanista/screens/modules/ECommerce/appbar.dart';

class Ecommerce extends StatefulWidget {
  const Ecommerce({Key? key}) : super(key: key);

  @override
  State<Ecommerce> createState() => _EcommerceState();
}

class _EcommerceState extends State<Ecommerce> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Buy Products"),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           // Scaffold.of(context).showBottomSheet(
      //           //   (context) {
      //           //     return Container(
      //           //       color: Colors.green,
      //           //       height: height * 2,
      //           //     );
      //           //   },
      //           // );
      //           showModalBottomSheet(
      //               isScrollControlled: true,
      //               context: context,
      //               builder: (contex) {
      //                 return Container(
      //                   height: height * 0.9,
      //                 );
      //               });
      //         },
      //         icon: const FaIcon(FontAwesomeIcons.cartShopping))
      //   ],
      // ),
      backgroundColor: Colors.white,
      floatingActionButton: CircleAvatar(
        radius: 35,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AdminHomeECommerce()));
          },
          icon: FaIcon(FontAwesomeIcons.cartShopping, size: height * 0.04),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 12,
            left: 12,
            right: 12,
            bottom: 12),
        child:  Column(
          children: [
            Appbar(),
            Products(),
          ],
        ),
      ),
    );
  }
}
