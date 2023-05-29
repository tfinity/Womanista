import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/variables/variables.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isPassShow = true;
  bool isConfrimPassShow = true;
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confrimPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<bool> registerUser() async {
    log("${email.text}  ${password.text}");
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      log("${user.user!.email}");
      await user.user!.updateDisplayName(username.text);
      try {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(user.user!.email)
            .set({
          "uid": user.user!.uid,
          "email": user.user!.email,
          "displayName": user.user!.displayName,
          "Driver": false,
          "Driver Application": "Not Submitted",
        });
      } on FirebaseException catch (e) {
        log("${e.code} ${e.message}");
        Navigator.of(context).pop();
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Play Try Again Later"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            });
        return false;
      }
      return true;
    } on FirebaseAuthException catch (e) {
      log("${e.code} ${e.message}");
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Play Try Again Later"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        color: Colors.white,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              SizedBox(
                height: height * 0.15,
                child: Image.asset("assets/logo.png"),
              ),
              // CircleAvatar(
              //   child: Icon(
              //     Icons.person,
              //     size: height * 0.15,
              //   ),
              //   radius: height * 0.1,
              // ),
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                "Create Your Account",
                style: GoogleFonts.ptSerif(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppSettings.mainColor,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppSettings.mainColorLignt,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  width: width,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: height * 0.05,
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please Enter a Valid UserName";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: username,
                              decoration: const InputDecoration(
                                hintText: "Username",
                                label: Text("Username"),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please Enter a Valid Email";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: email,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                label: Text("Email"),
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                icon: Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please Enter a Valid Password";
                                }
                                if (value != confrimPassword.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "Password",
                                label: const Text("Password"),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                icon: const Icon(
                                  Icons.key,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isPassShow = !isPassShow;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    isPassShow
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              obscureText: isPassShow,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty || value == "") {
                                  return "Please Enter a Valid Confirm password";
                                }
                                if (value != password.text) {
                                  return "Passwords do not match";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: confrimPassword,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                label: const Text("Confirm Password"),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                icon: const Icon(
                                  Icons.key,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isConfrimPassShow = !isConfrimPassShow;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    isConfrimPassShow
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              obscureText: isConfrimPassShow,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                loadingIndicator(context);
                                registerUser().then(
                                  (value) {
                                    if (value) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const Home(),
                                        ),
                                      );
                                    }
                                  },
                                  onError: (e) {
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Registration Failed... Try Again Later"),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(color: AppSettings.mainColor),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Already have an account? login",
                              style: GoogleFonts.ptSerif(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  void loadingIndicator(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
