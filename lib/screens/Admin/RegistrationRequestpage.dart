import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:womanista/variables/variables.dart';

class RegistrationrequestPage extends StatefulWidget {
  const RegistrationrequestPage(
      {Key? key, required this.data, required this.id})
      : super(key: key);
  final Map<String, dynamic> data;
  final String id;

  @override
  State<RegistrationrequestPage> createState() =>
      _RegistrationrequestPageState();
}

class _RegistrationrequestPageState extends State<RegistrationrequestPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: const Text("Registration Request"),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name: ${widget.data['Full Name']}"),
              Text("email: ${widget.data['email']}"),
              Text("CNIC: ${widget.data['cnic']}"),
              Text("Vehicle License: ${widget.data['Vehicle License']}"),
              Row(
                children: [
                  const Text("CNIC Front: "),
                  TextButton(
                    onPressed: () {
                      showImage(
                        "CNIC Front",
                        widget.data['CNIC front'],
                      );
                    },
                    child: const Text("View"),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("CNIC Back: "),
                  TextButton(
                    onPressed: () {
                      showImage(
                        "CNIC Back",
                        widget.data['CNIC Back'],
                      );
                    },
                    child: const Text("View"),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("License front: "),
                  TextButton(
                    onPressed: () {
                      showImage(
                        "License Front",
                        widget.data['CNIC front'],
                      );
                    },
                    child: const Text("View"),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("License Back: "),
                  TextButton(
                    onPressed: () {
                      showImage(
                        "License back",
                        widget.data['CNIC front'],
                      );
                    },
                    child: const Text("View"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Future.wait([
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(widget.id)
                            .update({
                          'Driver Application': "Approved",
                          'Driver': true
                        }),
                        FirebaseFirestore.instance
                            .collection("DriverRegistration")
                            .doc(widget.id)
                            .get()
                            .then((value) async {
                          await FirebaseFirestore.instance
                              .collection("Drivers")
                              .doc(widget.id)
                              .set({
                            'email': widget.id,
                            'status': "approved",
                            'Full Name': value.data()!['Full Name'],
                            'cnic': value.data()!['cnic'],
                            'Vehicle License': value.data()!['Vehicle License'],
                            'CNIC front': value.data()!['CNIC front'],
                            'CNIC Back': value.data()!['CNIC Back'],
                            'Licnese front': value.data()!['Licnese front'],
                            'Licnese Back': value.data()!['Licnese Back'],
                            'Vehicle Image': value.data()!['Vehicle Image'],
                          }).then((value) async {
                            await FirebaseFirestore.instance
                                .collection("DriverRegistration")
                                .doc(widget.id)
                                .delete();
                          });
                        }),
                      ]).then((value) {
                        Navigator.of(context).pop();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Approve"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(widget.id)
                          .update({'Driver Application': "Rejected"}).then(
                              (value) {
                        FirebaseFirestore.instance
                            .collection("DriverRegistration")
                            .doc(widget.id)
                            .delete()
                            .then((value) {
                          Navigator.of(context).pop();
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text("Reject"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  showImage(String title, String url) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(title),
            content: Image.network(
              url,
              // loadingBuilder: (context, child, loadingProgress) {
              //   return SizedBox(
              //     height: 70,
              //     child: Column(
              //       children: [
              //         CircularProgressIndicator(
              //           color: AppSettings.mainColor,
              //           strokeWidth: 2,
              //         ),
              //         // Text(
              //         //     "${(loadingProgress!.expectedTotalBytes! * loadingProgress.cumulativeBytesLoaded) / 100}}"),
              //       ],
              //     ),
              //   );
              // },
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppSettings.mainColor,
                ),
                child: const Text("Close"),
              ),
            ],
          );
        });
  }
}
