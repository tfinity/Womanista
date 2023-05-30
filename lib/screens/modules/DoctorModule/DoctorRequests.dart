import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:womanista/screens/modules/DoctorModule/DoctorRequestProvider.dart';

//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class DoctorRequestList extends StatelessWidget {
  const DoctorRequestList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoctorRequestListApp(),
    );
  }
}

class DoctorRequestListApp extends StatefulWidget {
  const DoctorRequestListApp({Key? key}) : super(key: key);

  @override
  State<DoctorRequestListApp> createState() => _DoctorRequestListAppState();
}

DoctorRequestData doctorData = DoctorRequestData();
var length = 0;
var Name = [];
var Query = [];
var Img = [];
final collection = FirebaseFirestore.instance.collection("DoctorRequests");

class _DoctorRequestListAppState extends State<DoctorRequestListApp> {
  int id = 0;
  void UpdateId(int newId) {
    setState(() {
      id = newId;
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => ChatScreen(
      //             id: id,
      //           ),),
      // );
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    var idx = 1;

    for (var doc in doctorData.doctor) {
      print(doc.userName);

      final store = collection
          .doc('$idx')
          .set({"Name": doc.userName, "Query": doc.userQuery, "Img": doc.img});
      idx++;
    }

    //data=data.docs[i].data()["Name"];
    //print(data);
    collection.get().then(
      (value) {
        for (var element in value.docs) {
          setState(
            () {
              Name.add(element.data()["Name"]);

              Img.add(element.data()["Img"]);

              Query.add(element.data()["Query"]);
              length++;
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: const Text('Customer Requests',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: SizedBox(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
            itemCount: length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 90,
                child: Card(
                  //shape:RoundedRectangleBorder(side:BorderSide(color:Color.fromARGB(255, 230, 226, 226)),borderRadius:BorderRadius.circular(10)),
                  child: Center(
                    child: ListTile(
                      title: Text(
                        Name[index] + "",
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            Query[index],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                      leading: Image.network(
                        "${Img[index]}",
                        width: 59,
                        height: 59,
                        fit: BoxFit.cover,
                      ),
                      trailing: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            child: const Text(
                              "Chat",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () => UpdateId(index),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
