import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:womanista/screens/Admin/AdminHome.dart';
import 'package:womanista/screens/login.dart';
import 'package:womanista/screens/modules/RideBooking/Driver_Registration.dart';
import 'package:womanista/variables/variables.dart';

class Appdrawer extends StatefulWidget {
  const Appdrawer({Key? key}) : super(key: key);

  @override
  State<Appdrawer> createState() => _AppdrawerState();
}

class _AppdrawerState extends State<Appdrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: AppSettings.mainColor,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "WOMANISTA",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          buttons(
              "Register as Driver",
              Icon(
                Icons.drive_eta_outlined,
                color: AppSettings.mainColor,
              ), () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const DriverRegistration(),
              ),
            );
          }),
          buttons(
              "Admin Side",
              Icon(
                Icons.admin_panel_settings_outlined,
                color: AppSettings.mainColor,
              ), () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AdminHome(),
              ),
            );
          }),
          const Spacer(),
          buttons(
              "Logout",
              Icon(
                Icons.logout,
                color: AppSettings.mainColor,
              ), () async {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (ctx) => const Login(),
                ),
                (route) => false,
              );
            });
          }),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget buttons(String text, Icon icon, VoidCallback ontap) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              color: AppSettings.mainColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
