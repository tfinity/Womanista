import 'package:flutter/material.dart';
import 'package:womanista/screens/modules/selfeDefence/Youtube.dart';
import 'package:womanista/screens/modules/selfeDefence/YoutubePlay.dart';

class SelfDefence extends StatefulWidget {
  const SelfDefence({Key? key}) : super(key: key);

  @override
  State<SelfDefence> createState() => _SelfDefenceState();
}

class _SelfDefenceState extends State<SelfDefence> {
  List<Youtube> ytube = [
    Youtube("k9Jn0eP-ZVg", "3 Simple Self Defence moves you must know"),
    Youtube("KVpxP3ZZtAc", "3 Simple Self Defence moves you must know"),
    Youtube("T7aNSRoDCmg", "3 Simple Self Defence moves you must know"),
    Youtube("jAh0cU1J5zk", "3 Simple Self Defence moves you must know"),
    Youtube("UV78YzM-gGQ", "3 Simple Self Defence moves you must know"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: const Text('Self Defence Tutorials',
              style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            child: ListView.separated(
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
                              title:
                                  Text("${index + 1}: Self Defence Tutorial"),
                              subtitle: Text(ytube[index].Desc),
                              leading: Image.network(
                                "https://img.youtube.com/vi/${ytube[index].LinkId}/0.jpg",
                                fit: BoxFit.fill,
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.play_circle_rounded,
                                  size: 35,
                                  color: Color.fromARGB(255, 58, 73, 80),
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
                        )),
                  );
                }),
          ),
        ));
  }
}
