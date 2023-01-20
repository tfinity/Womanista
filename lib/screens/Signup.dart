import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  registerUser() async {
    log("${email.text}  ${password.text}");
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      log("${user.user!.email}");
    } on FirebaseAuthException catch (e) {
      log("${e.code} ${e.message}");
    }

    log("after");
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
        color: Colors.yellow,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: height * 0.15,
                ),
                radius: height * 0.1,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "Create Your Account",
                style: GoogleFonts.ptSerif(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
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
                              controller: username,
                              decoration: const InputDecoration(
                                hintText: "Username",
                                label: Text("Username"),
                                icon: Icon(Icons.person),
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
                              controller: email,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                label: Text("Email"),
                                icon: Icon(Icons.mail),
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
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "Password",
                                label: const Text("Password"),
                                icon: const Icon(Icons.key),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isPassShow = !isPassShow;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    isPassShow
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
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
                              controller: confrimPassword,
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                label: const Text("Confirm Password"),
                                icon: const Icon(Icons.key),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    isConfrimPassShow = !isConfrimPassShow;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    isConfrimPassShow
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
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
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                registerUser();
                              }
                            },
                            child: const Text("Sign up"),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Already have an account? login",
                              style: GoogleFonts.ptSerif(
                                fontSize: 14,
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
}
