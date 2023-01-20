import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:womanista/firebase_options.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  User? user = FirebaseAuth.instance.currentUser;

  initState() {
    log("username: ${user!.displayName}");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Womanista',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user != null ? const Home() : const Login(),
    );
  }
}
