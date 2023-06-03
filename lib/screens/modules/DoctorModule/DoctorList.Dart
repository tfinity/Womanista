import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:womanista/screens/modules/DoctorModule/Doctor_Provider.dart';
import 'DoctorProfile.dart';

//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class DoctorList extends StatelessWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoctorListApp(),
    );
  }
}

class DoctorListApp extends StatefulWidget {
  const DoctorListApp({Key? key}) : super(key: key);

  @override
  State<DoctorListApp> createState() => _DoctorListAppState();
}

var length = 0;
var Name = [];
var ProfileDesc = [];
var Img = [];
var Rating = [];
var Desc = [];
var Email=[];

var data;
DoctorData doctorData = DoctorData();
final collection = FirebaseFirestore.instance.collection("Doctors");

//List<List<Icon>>iconlist=[[Icons.star,Icons.star,Icons.star]];

class _DoctorListAppState extends State<DoctorListApp> {
  int id = 0;

  void UpdateId(int newId) {
    setState(() {
      id = newId;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DoctorProfile(id: id)),
      );
    });
  }

  @override

  ///final collection = FirebaseFirestore.instance.collection("Doctors");

  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    var idx = 1;

    for (var doc in doctorData.doctor) {
      print(doc.Email);

      final store = collection.doc('$idx').set({
        "Name": doc.Name,
        "Desc": doc.Desc,
        "Rating": doc.Rating,
        "ProfileDesc": doc.ProfileDesc,
        "Img": doc.Img,
        "Email":doc.Email
      });
      idx++;
    }

    data = await collection.get();
    //data=data.docs[i].data()["Name"];
    //print(data);
    collection.get().then((value) {
      if (Name.isEmpty)

      for (var element in value.docs) {
         
        setState(() {
          
          {Desc.add(element.data()["Desc"]);
          Name.add(element.data()["Name"]);
          ProfileDesc.add(element.data()["ProfileDesc"]);
          Img.add(element.data()["Img"]);

          Rating.add(element.data()["Rating"]);
          Email.add(element.data()["Email"]);
          length++;}
        });
      }
    });

    //CollectionReference _collectionRef =

    // FirebaseFirestore.instance.collection('Doctors');

    // Get docs from collection reference
    //QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    //final allData = querySnapshot.docs[0].data()!["Name"];
    //print(allData.data()!["Name"]);

    print(Name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Gynecologists',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SizedBox(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height:MediaQuery.of(context).size.height*0.01) ,
                
            itemCount: length,
            itemBuilder: (context, index) {
              return SizedBox(
                  height:MediaQuery.of(context).size.height*0.17 ,
               
                     
                child: Card(
                  //shape:RoundedRectangleBorder(side:BorderSide(color:Color.fromARGB(255, 230, 226, 226)),borderRadius:BorderRadius.circular(10)),
                  child: Center(
                     
                      child: ListTile(
                        title: Text(Name[index] + ""),
                        subtitle: Row(
                          children: [
                            Text(
                              Desc[index],
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            Text(
                              "${Rating[index]}",
                            ),
                          ],
                        ),
                        leading: Image.network(
                          "${Img[index]}",
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                           // fixedSize: Size(MediaQuery.of(context).size.width*0.2,MediaQuery.of(context).size.height*0.08) ,

                          ),
                          child: const Text(
                            "View Details",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () => UpdateId(index),
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
