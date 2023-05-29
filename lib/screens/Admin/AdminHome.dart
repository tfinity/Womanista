import 'package:flutter/material.dart';
import 'package:womanista/screens/Admin/DriverRegistrationRequests.dart';

import '../../variables/variables.dart';
import '../settings.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset(
            "assets/logo.png",
            fit: BoxFit.contain,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
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
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              width: size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppSettings.mainColor),
              child: const Center(
                child: Text(
                  "Admin Dashboard",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const DriverRegistrationRequests(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppSettings.mainColor,
              ),
              child: const Text(
                "Driver Registration Requests",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
