import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:womanista/variables/variables.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({Key? key}) : super(key: key);

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {
  String applicationStatus = '';
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullName = TextEditingController();
  TextEditingController cnic = TextEditingController();
  TextEditingController carLicence = TextEditingController();
  XFile? licenseFront;
  XFile? licenseBack;
  XFile? cnicFront;
  XFile? cnicBack;
  XFile? vehicleImage;
  final ImagePicker picker = ImagePicker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkStatus();
  }

  checkStatus() {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((value) {
      final data = value.data();
      applicationStatus = data!["Driver Application"];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: const Text(
          "Driver Registration",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Content(),
    );
  }

  Widget Content() {
    if (applicationStatus == '') {
      return Center(
        child: CircularProgressIndicator(
          color: AppSettings.mainColor,
          strokeWidth: 5,
        ),
      );
    } else if (applicationStatus == "Rejected") {
      return const Text("Your Application has been rejected");
    } else if (applicationStatus == "Approved") {
      return const Text("Your Application has Been Approved");
    } else if (applicationStatus == "Under Review") {
      return const Text("Your Application is Under Review");
    }
    return mainContent();
  }

  Widget mainContent() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                input(
                  size,
                  'Full Name',
                  'John Doe',
                  Icon(
                    Icons.person,
                    color: AppSettings.mainColor,
                  ),
                  fullName,
                ),
                const SizedBox(
                  height: 5,
                ),
                input(
                  size,
                  'CNIC',
                  '3520-010962224-8',
                  Icon(
                    Icons.credit_card_rounded,
                    color: AppSettings.mainColor,
                  ),
                  cnic,
                ),
                const SizedBox(
                  height: 5,
                ),
                input(
                  size,
                  'Vehicle License',
                  'LEK-2964',
                  Icon(
                    FontAwesomeIcons.car,
                    color: AppSettings.mainColor,
                  ),
                  carLicence,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Uploads: ",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                cnicFront == null
                    ? ElevatedButton(
                        onPressed: () async {
                          cnicFront = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppSettings.mainColor,
                        ),
                        child: const Text(
                          "CNIC Front",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(
                        width: size.width * 0.9,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                cnicFront!.name,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                cnicFront = null;
                                setState(() {});
                              },
                              child: const Text(
                                "change",
                              ),
                            ),
                          ],
                        ),
                      ),
                cnicBack == null
                    ? ElevatedButton(
                        onPressed: () async {
                          cnicBack = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppSettings.mainColor,
                        ),
                        child: const Text(
                          "CNIC Back",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(
                        width: size.width * 0.9,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                cnicBack!.name,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                cnicBack = null;
                                setState(() {});
                              },
                              child: const Text(
                                "change",
                              ),
                            ),
                          ],
                        ),
                      ),
                licenseFront == null
                    ? ElevatedButton(
                        onPressed: () async {
                          licenseFront = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppSettings.mainColor,
                        ),
                        child: const Text(
                          "License Front",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(
                        width: size.width * 0.9,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                licenseFront!.name,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                licenseFront = null;
                                setState(() {});
                              },
                              child: const Text(
                                "change",
                              ),
                            ),
                          ],
                        ),
                      ),
                licenseBack == null
                    ? ElevatedButton(
                        onPressed: () async {
                          licenseBack = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppSettings.mainColor,
                        ),
                        child: const Text(
                          "License Back",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(
                        width: size.width * 0.9,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                licenseBack!.name,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                licenseBack = null;
                                setState(() {});
                              },
                              child: const Text(
                                "change",
                              ),
                            ),
                          ],
                        ),
                      ),
                vehicleImage == null
                    ? ElevatedButton(
                        onPressed: () async {
                          vehicleImage = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppSettings.mainColor,
                        ),
                        child: const Text(
                          "Vehicle Image",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : SizedBox(
                        width: size.width * 0.9,
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                vehicleImage!.name,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                licenseBack = null;
                                setState(() {});
                              },
                              child: const Text(
                                "change",
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      if (cnicBack == null ||
                          cnicFront == null ||
                          licenseBack == null ||
                          licenseFront == null ||
                          vehicleImage == null) {
                        showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text("Error!"),
                              content: const Text("Upload All Required Files"),
                              actions: [
                                ElevatedButton(
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppSettings.mainColor,
                                  ),
                                  child: const Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                      uploadData().then((value) async {
                        if (value) {
                          await FirebaseFirestore.instance
                              .collection("Users")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .update({'Driver Application': "Under Review"});
                          applicationStatus = "Under Review";
                          setState(() {});
                        } else {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: const Text("Error!"),
                                  content: const Text(
                                      "There was an error uploading your data to server. try Again"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppSettings.mainColor,
                                      ),
                                      child: const Text(
                                        "OK",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                        Navigator.of(context).pop();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppSettings.mainColor,
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget input(Size size, String lable, String hintText, Icon icon,
      TextEditingController controller) {
    return SizedBox(
      width: size.width * 0.9,
      child: TextFormField(
        controller: controller,
        validator: (s) {
          if (s == null) return 'This field is Required';
          if (s.isEmpty || s == '' || s == ' ') {
            return 'This field is Required';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          label: Text(lable),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppSettings.mainColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppSettings.mainColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppSettings.mainColor,
            ),
          ),
        ),
      ),
    );
  }

  Future uploadData() async {
    loadingIndicator();
    final storageRef = FirebaseStorage.instance.ref();
    final user = FirebaseAuth.instance.currentUser!;
    try {
      Future.wait([
        storageRef
            .child("Verification/CNIC/${user.email}_cnic_front.png")
            .putFile(
              File(cnicFront!.path),
            ),
        storageRef
            .child("Verification/CNIC/${user.email}_cnic_back.png")
            .putFile(
              File(cnicFront!.path),
            ),
        storageRef
            .child("Verification/LICENSE/${user.email}_license_front.png")
            .putFile(
              File(cnicFront!.path),
            ),
        storageRef
            .child("Verification/LICENSE/${user.email}_lisence_front.png")
            .putFile(
              File(cnicFront!.path),
            ),
        storageRef
            .child("Verification/Vehicles/${user.email}_vehicle_image.png")
            .putFile(
              File(vehicleImage!.path),
            ),
      ]).then((value) async {
        FirebaseFirestore.instance
            .collection("DriverRegistration")
            .doc(user.email)
            .set({
          'email': user.email,
          'Full Name': fullName.text,
          'cnic': cnic.text,
          'Vehicle License': carLicence.text,
          'CNIC front': await value[0].ref.getDownloadURL(),
          'CNIC Back': await value[1].ref.getDownloadURL(),
          'Licnese front': await value[2].ref.getDownloadURL(),
          'Licnese Back': await value[3].ref.getDownloadURL(),
          'Vehicle Image': await value[4].ref.getDownloadURL(),
        });
      });
    } catch (e) {
      return false;
    }
    return true;
  }

  loadingIndicator() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return const AlertDialog(
            title: Text("Loading"),
            content: SizedBox(
              height: 50,
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
