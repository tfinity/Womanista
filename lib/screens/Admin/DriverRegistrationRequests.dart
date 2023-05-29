import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:womanista/screens/Admin/RegistrationRequestpage.dart';
import 'package:womanista/variables/variables.dart';

class DriverRegistrationRequests extends StatefulWidget {
  const DriverRegistrationRequests({Key? key}) : super(key: key);

  @override
  State<DriverRegistrationRequests> createState() =>
      _DriverRegistrationRequestsState();
}

class _DriverRegistrationRequestsState
    extends State<DriverRegistrationRequests> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> requests = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadRequests();
  }

  loadRequests() {
    FirebaseFirestore.instance
        .collection("DriverRegistration")
        .get()
        .then((value) {
      requests = value.docs;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: Text("Registration requests (${requests.length})"),
        centerTitle: true,
      ),
      body: requests.isEmpty
          ? const Center(
              child: Text("No New Requests"),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RegistrationrequestPage(
                          data: requests[index].data(),
                          id: requests[index].id,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppSettings.mainColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Text("Request by: ${requests[index].id}"),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: requests.length,
            ),
    );
  }
}
