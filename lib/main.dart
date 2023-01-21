import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:womanista/firebase_options.dart';
import 'package:womanista/screens/ECommerce/cart/cart_provider.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Cart()),
        //ChangeNotifierProvider(create: (_) => CartItem()),
      ],
      child: MyApp(),
    ),
  );
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
