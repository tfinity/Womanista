import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:womanista/screens/modules/selfeDefence/Admin/SelfDefence_Admin.dart';
import 'package:womanista/screens/modules/selfeDefence/Youtube.dart';
import 'package:womanista/screens/modules/selfeDefence/YoutubePlay.dart';
import 'package:womanista/variables/variables.dart';

class SelfDefence extends StatefulWidget {
  const SelfDefence({Key? key}) : super(key: key);

  @override
  State<SelfDefence> createState() => _SelfDefenceState();
}

class _SelfDefenceState extends State<SelfDefence> {
  final db = FirebaseFirestore.instance.collection("Self Defense");
  List<Youtube> ytube = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    log("here");
    db.doc("Videos").collection("Videos").get().then(
      (value) {
        for (var element in value.docs) {
          log("${element.data()}");
          ytube.add(
              Youtube(element.data()['id'], element.data()['description']));
        }
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppSettings.mainColor,
        title: const Text(
          'Self Defence Tutorials',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const SelfDefenceAdmin(),
                ),
              );
            },
            child: const Icon(
              Icons.admin_panel_settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
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
            : SizedBox(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 12),
                  itemCount: ytube.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 100,
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
                                  Icons.play_circle,
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
    );
  }
}
