import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Recover extends StatefulWidget {
  const Recover({Key? key}) : super(key: key);

  @override
  State<Recover> createState() => _RecoverState();
}

class _RecoverState extends State<Recover> {
  bool passconfirm = false;

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
        color: Colors.yellow,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: height * 0.15,
                ),
                radius: height * 0.1,
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text(
                "Recover Password",
                style: GoogleFonts.ptSerif(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        if (!passconfirm)
                          SizedBox(
                            width: width * 0.8,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                label: Text("Email"),
                                icon: Icon(Icons.mail),
                                contentPadding: EdgeInsets.all(0),
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                        if (passconfirm)
                          SizedBox(
                            width: width * 0.8,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "New Password",
                                label: Text("New Password"),
                                icon: Icon(Icons.key),
                                contentPadding: EdgeInsets.all(0),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                        if (passconfirm)
                          SizedBox(
                            width: width * 0.8,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                label: Text("Confirm Password"),
                                icon: Icon(Icons.key),
                                contentPadding: EdgeInsets.all(0),
                              ),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        const ElevatedButton(
                          onPressed: null,
                          child: Text("Recover"),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
