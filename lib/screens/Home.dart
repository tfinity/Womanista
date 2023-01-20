import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:womanista/screens/ECommerce/Ecommerce.dart';
import 'package:womanista/screens/modules/selfeDefence/selfDefence.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          // height: height,
          // width: width,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            shrinkWrap: true,
            children: [
              //self Defence
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SelfDefence(),
                    ),
                  );
                },
                child: Card(
                  color: const Color.fromARGB(255, 235, 229, 229),
                  elevation: 2,
                  child: SizedBox(
                    height: height * 0.2,
                    width: width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.shield,
                          size: height * 0.1,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          "Self Defense",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Ride Book
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SelfDefence(),
                    ),
                  );
                },
                child: Card(
                  color: const Color.fromARGB(255, 235, 229, 229),
                  elevation: 2,
                  child: SizedBox(
                    height: height * 0.2,
                    width: width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.car,
                          size: height * 0.1,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          "Book Ride",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //Doctor Appointment
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SelfDefence(),
                    ),
                  );
                },
                child: Card(
                  color: const Color.fromARGB(255, 235, 229, 229),
                  elevation: 2,
                  child: SizedBox(
                    height: height * 0.2,
                    width: width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.userDoctor,
                          size: height * 0.1,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          "Doctor Appointment",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // E-Commerce
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Ecommerce(),
                    ),
                  );
                },
                child: Card(
                  color: const Color.fromARGB(255, 235, 229, 229),
                  elevation: 2,
                  child: SizedBox(
                    height: height * 0.2,
                    width: width * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.basketShopping,
                          size: height * 0.1,
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const Text(
                          "Buy Products",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
