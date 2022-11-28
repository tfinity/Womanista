import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassShow = true;
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
                "Sign In",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: const TextField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              label: Text("Email"),
                              icon: Icon(Icons.mail),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: TextField(
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
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Forgot Password?",
                              style: GoogleFonts.ptSerif(
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.1,
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const ElevatedButton(
                          onPressed: null,
                          child: Text("Sign in"),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            log("HO gya tap");
                          },
                          child: Text(
                            "Create New Account?",
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
            ],
          ),
        ),
      ),
    );
  }
}
