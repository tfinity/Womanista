import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:womanista/screens/Home.dart';
import 'package:womanista/variables/variables.dart';
import 'package:image_picker/image_picker.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool isPassShow = true;
  bool isConfrimPassShow = true;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  final storageRef = FirebaseStorage.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;

  fetchData() {
    userName.text = user!.displayName != null ? user!.displayName! : '';
    email.text = user!.displayName != null ? user!.email! : '';
  }

  uploadImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {});
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
                "User Settings",
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
                          height: height * 0.03,
                        ),
                        InkWell(
                          onTap: uploadImage,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: const Center(child: Text("Pick Image")),
                            radius: height * 0.07,
                            foregroundImage: image == null
                                ? user!.photoURL == null
                                    ? null
                                    : NetworkImage(user!.photoURL!)
                                        as ImageProvider
                                : FileImage(
                                    File(image!.path),
                                  ),
                          ),
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
                            style: const TextStyle(color: Colors.white),
                            controller: userName,
                            decoration: const InputDecoration(
                              hintText: "UserName",
                              label: Text("UserName"),
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
                              contentPadding: EdgeInsets.all(0),
                            ),
                            keyboardType: TextInputType.text,
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
                                Icons.person,
                                color: Colors.white,
                              ),
                              contentPadding: EdgeInsets.all(0),
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: TextFormField(
                            validator: (value) {
                              // if (value!.isEmpty || value == "") {
                              //   return "Please Enter a Valid Password";
                              // }
                              if (value != confirmPassword.text) {
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
                              // if (value!.isEmpty || value == "") {
                              //   return "Please Enter a Valid Confirm password";
                              // }
                              if (value != password.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            controller: confirmPassword,
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
                              setData().then(
                                (value) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                onError: (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Error Occured... Try Again"),
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(color: AppSettings.mainColor),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setData() async {
    if (image != null) {
      storageRef
          .child("ProfilePictures/${user?.uid}.png")
          .putFile(
            File(image!.path),
          )
          .then((p0) async {
        await user?.updatePhotoURL(await p0.ref.getDownloadURL());
      });
    }
    if (userName.text != '' || userName.text != user!.displayName) {
      await user?.updateDisplayName(userName.text);
    }
    if (email.text != '' || email.text != user!.displayName) {
      await user?.updateEmail(password.text);
    }
    if (password.text != '' || confirmPassword.text != '') {
      final credentials = EmailAuthProvider.credential(
          email: user!.email!, password: password.text);
      try {
        await user?.linkWithCredential(credentials);
      } on FirebaseAuthException catch (e) {
        log("${e.code}: ${e.message}");
      }
    }

    storageRef
        .child("ProfilePictures/${user?.uid}.png")
        .putFile(
          File(image!.path),
        )
        .then((p0) async {
      await user?.updatePhotoURL(await p0.ref.getDownloadURL());
      await user?.updateDisplayName(userName.text);
      await user?.updatePassword(password.text);
    });
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
