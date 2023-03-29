import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:womanista/screens/modules/selfeDefence/Youtube.dart';
import 'package:womanista/screens/modules/selfeDefence/YoutubePlay.dart';
import 'package:womanista/variables/variables.dart';

class SelfDefenceAdmin extends StatefulWidget {
  const SelfDefenceAdmin({Key? key}) : super(key: key);

  @override
  State<SelfDefenceAdmin> createState() => _SelfDefenceAdminState();
}

class _SelfDefenceAdminState extends State<SelfDefenceAdmin> {
  final db = FirebaseFirestore.instance.collection("Self Defense");
  TextEditingController vidiId = TextEditingController();
  TextEditingController vidiDesc = TextEditingController();
  List<Youtube> ytube = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    db.doc("Videos").collection("Videos").get().then(
      (value) {
        for (var element in value.docs) {
          ytube.add(
              Youtube(element.data()['id'], element.data()['description']));
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: const Text("Admin: Selfe Defence"),
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) {
                  return SimpleDialog(
                    title: const Text("Add Data"),
                    contentPadding: const EdgeInsets.all(8),
                    children: [
                      SizedBox(
                        child: TextField(
                          controller: vidiId,
                          decoration: const InputDecoration(
                            hintText: 'abcd-xyz',
                          ),
                        ),
                      ),
                      SizedBox(
                        child: TextField(
                          controller: vidiDesc,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          db.doc("Videos").collection("Videos").add({
                            'id': vidiId.text,
                            'description': vidiDesc.text,
                          }).then((value) {
                            ytube.add(Youtube(vidiId.text, vidiDesc.text));
                            setState(() {});
                            Navigator.of(context).pop();
                          });
                        },
                        child: const Text(
                          "Add",
                          style: TextStyle(fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppSettings.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(15),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            child: ytube.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        //height: height * 0.3,
                        //width: width,
                        child: Image.asset(
                          "assets/productsLoading.gif",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        "No Data Yet",
                        style: AppSettings.textStyle(size: 18),
                      ),
                    ],
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10),
                    itemCount: ytube.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 90,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 230, 226, 226)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: ListTile(
                                title: const Text("Self Defence Tutorial"),
                                subtitle: Text(ytube[index].Desc),
                                leading: Image.network(
                                  "https://img.youtube.com/vi/${ytube[index].LinkId}/0.jpg",
                                  fit: BoxFit.fill,
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.play_circle_rounded,
                                    size: 35,
                                    color: AppSettings.mainColorLignt,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => YoutubePlay(
                                                id: ytube[index].LinkId,
                                              )),
                                    );
                                  },
                                )),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
