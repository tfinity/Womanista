import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:womanista/screens/modules/DoctorModule/DoctorList.dart';





class DoctorEmailButton extends StatefulWidget{
  const DoctorEmailButton({Key? key, this.id}) : super(key: key);
  final id;
  @override
  _DoctorEmailButtonState createState() => _DoctorEmailButtonState();
}

class _DoctorEmailButtonState extends State<DoctorEmailButton> { 
@override
  void initState() {
    widget.id;

    
    super.initState();
  
  
  }
  @override
  Widget build(BuildContext context) { 
    return  Scaffold(
      backgroundColor: Colors.white,
       
          appBar: AppBar(
            title: Text("Book Your Appointment"),
            backgroundColor: Colors.redAccent,
          ),
          body: Container(
            padding: EdgeInsets.only(top:20, left:20, right:20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SizedBox(height:20),
                Text("Click on the button below to book an appointment",style:TextStyle(color:Color.fromARGB(200, 0, 0, 0))),
                SizedBox(height:15),

                 ElevatedButton(
                  style:ElevatedButton.styleFrom(backgroundColor:Colors.redAccent),
                  onPressed: ()async{
                      String email = Uri.encodeComponent(Email[widget.id]);
                      String subject = Uri.encodeComponent("Hello Doctor");
                      String body = Uri.encodeComponent("Hi! I need your help.");
                      print(subject); //output: Hello%20Flutter
                      Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                      if (await launchUrl(mail)) {
                          //email app opened
                      }else{
                          //email app is not opened
                      }
                  }, 
                  child: Text("Mail Us Now", style: TextStyle(
                            color: Colors.white),
                  ),)
            ],),
          )
       );
  }
}