import 'package:flutter/material.dart';

import 'package:womanista/screens/modules/selfeDefence/LawsList.dart';
import 'package:womanista/screens/modules/selfeDefence/selfDefence.dart';

//import 'package:womanista/chat_provider.dart';

class SelfDefenceMenu extends StatefulWidget {
  const SelfDefenceMenu({Key? key}) : super(key: key);

  @override
  State<SelfDefenceMenu> createState() => _SelfDefenceMenuState();
}

class _SelfDefenceMenuState extends State<SelfDefenceMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Menu',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text(
                  "Women Protection Laws Module",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LawsListApp(),
                  ),),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text(
                  "Self Defence Tutorials Module",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelfDefence(),
                  ),),
              ),
            ),
          
           
           
              
            
          ],
        ),
      ),
    );
  }
}
