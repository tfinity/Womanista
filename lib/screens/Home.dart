import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:womanista/screens/login.dart';
import 'package:womanista/screens/modules/ECommerce/Ecommerce.dart';
import 'package:womanista/screens/modules/RideBooking/ride_booking_homepage.dart';
import 'package:womanista/screens/modules/selfeDefence/selfDefence.dart';
import 'package:womanista/screens/settings.dart';
import 'package:womanista/variables/variables.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SizedBox(
          // height: height,
          // width: width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    color: AppSettings.mainColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: SizedBox(
                  //height: height * 0.1,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.03,
                        ),
                        IconButton(
                          onPressed: () async {
                            FirebaseAuth.instance.signOut().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (ctx) => const Login(),
                                ),
                                (route) => false,
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        CircleAvatar(
                          radius: height * 0.05,
                          foregroundImage: user!.photoURL != null
                              ? NetworkImage(user!.photoURL!)
                              : null,
                          // onForegroundImageError: (exception, stackTrace) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text("$exception"),
                          //     ),
                          //   );
                          // },
                          child: Icon(
                            Icons.person,
                            size: height * 0.05,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Text(
                          "Welcome,\n     ${user?.displayName}",
                          style: AppSettings.textStyle(
                            size: 20,
                            weight: FontWeight.bold,
                            textColor: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Settings(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
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
                        color: Colors.grey,
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
                            builder: (context) => const RideBookingHome(),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.grey,
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
                        color: Colors.grey,
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
                        color: const Color.fromARGB(40, 158, 158, 158),
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
            ],
          ),
        ),
      ),
    );
  }
}
