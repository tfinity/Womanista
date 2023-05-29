import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/screens/Signup.dart';
import 'package:womanista/screens/forgotpassword.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:womanista/variables/variables.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassShow = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  userLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    log("${email.text}  ${password.text}");
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      log("${user.user!.email}");
      for (var x in user.user!.providerData) {
        log("user: ${x.providerId}");
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      log("${e.code} ${e.message}");
      String value = "";
      if (e.code == "invalid-email" || e.code == "wrong-password") {
        value = "You Have Entered Wrong Credentials";
      } else if (e.code == "user-disabled") {
        value = "Your Account is Disabled.";
      } else if (e.code == "user-not-found") {
        value = "Your Account is not Created";
      }

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(value),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
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
              SizedBox(
                height: height * 0.04,
              ),
              Text(
                "Sign In",
                style: GoogleFonts.ptSerif(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppSettings.mainColor),
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
                            height: height * 0.1,
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
                              style: const TextStyle(color: Colors.white),
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
                                contentPadding: EdgeInsets.all(0),
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
                                return null;
                              },
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "Password",
                                label: const Text("Password"),
                                icon: const Icon(
                                  Icons.key,
                                  color: Colors.white,
                                ),
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                labelStyle: const TextStyle(
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
                            height: height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Recover(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.ptSerif(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
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
                          ElevatedButton(
                            onPressed: userLogin,
                            child: Text(
                              "Sign in",
                              style: TextStyle(color: AppSettings.mainColor),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Signup(),
                                ),
                              );
                            },
                            child: Text(
                              "Create New Account?",
                              style: GoogleFonts.ptSerif(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              loadingIndicator(context);
                              await signInWithGoogle().then(
                                (value) {
                                  Navigator.of(context).pop();
                                  log("${value.user!.displayName}");
                                  log("length: ${value.user!.providerData.length}");
                                  try {
                                    FirebaseFirestore.instance
                                        .collection("Users")
                                        .doc(value.user!.email)
                                        .set({
                                      "uid": value.user!.uid,
                                      "email": value.user!.email,
                                      "displayName": value.user!.displayName,
                                      "Driver": false,
                                      "Driver Application": "Not Submitted",
                                    }).then(
                                      (value) {
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => const Home(),
                                          ),
                                          (route) => false,
                                        );
                                      },
                                    );
                                  } on FirebaseException catch (e) {
                                    log("${e.code} ${e.message}");
                                    Navigator.of(context).pop();
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: const Text("Error"),
                                            content: const Text(
                                                "Play Try Again Later"),
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
                                  }

                                  // bool password = false;
                                  // for (var x in value.user!.providerData) {
                                  //   log("user: ${x.providerId}");
                                  //   if (x.providerId == "password" &&
                                  //       x.photoURL == null) {
                                  //     password = true;
                                  //     break;
                                  //   }
                                  // }
                                  // if (password) {
                                  //   Navigator.of(context).pushAndRemoveUntil(
                                  //     MaterialPageRoute(
                                  //       builder: (context) => const Home(),
                                  //     ),
                                  //     (route) => false,
                                  //   );
                                  // } else {
                                  //   Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const SetPassword(),
                                  //     ),
                                  //   );
                                  // }
                                },
                                onError: (e) {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Signin Failed... Try Again Later"),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: AppSettings.mainColor,
                            ),
                            label: Text(
                              "Signin with google",
                              style: GoogleFonts.ptSerif(
                                fontSize: 14,
                                color: AppSettings.mainColor,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
