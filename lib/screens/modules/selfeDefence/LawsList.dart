import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:womanista/screens/modules/selfeDefence/Laws_Provider.dart';
import 'LawDescription.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var length=0;
var Heading=[];
var Subheading=[];
var Img=[];

var Desc=[];

var data;
LawsData Law= LawsData();
final collection = FirebaseFirestore.instance.collection("Woman_Protection_Laws");
class LawsList extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: LawsListApp(),
    );
  }
}
class LawsListApp extends StatefulWidget {
  const LawsListApp({Key? key}) : super(key: key);

  @override
  State<LawsListApp> createState() => _LawsListAppState();
}





LawsData lawsData= LawsData();


//List<List<Icon>>iconlist=[[Icons.star,Icons.star,Icons.star]];

class _LawsListAppState extends State<LawsListApp> {
  int id=0;
  void UpdateId(int newId)
  {
setState((){id=newId;
 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LawsDesc(id: id,)),
                    );
                    });
  }
  void initState()
  {
    loadData();
    super.initState();
  }
  loadData()async
  {
    
 
    var idx=1;
    
    Law.laws.forEach((law)
    {
     
     
     final store=  collection.doc('$idx').set({"Heading":law.heading,"Subheading":law.subHeading,"Desc":law.desc,"Img":law.img});
     idx++;
    });
     
    //data=await collection.get();
    //data=data.docs[i].data()["Name"];
    //print(data);
    if(Heading.isEmpty)
    collection.get().then((value){
      value.docs.forEach((element){
        setState(()
        {
        Desc.add(element.data()["Desc"]);
        Heading.add(element.data()["Heading"]);
        Subheading.add(element.data()["Subheading"]);
        Img.add(element.data()["Img"]);
        
        
        length++;});});
    });
 }
  @override
   Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.white,
           appBar: AppBar(
           automaticallyImplyLeading: false,
           backgroundColor:Colors.redAccent,
           title:Text('Women Protection Laws',style:TextStyle(color:Colors.white)),
           centerTitle: true,
           elevation:0,
           ),
           body:Padding(
             padding: const EdgeInsets.symmetric(vertical:40),
             child: SizedBox(
               child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => SizedBox(height:10),
        itemCount: length,
        itemBuilder: (context, index) {
          return SizedBox(height:90,
            child: Card(
            //shape:RoundedRectangleBorder(side:BorderSide(color:Color.fromARGB(255, 230, 226, 226)),borderRadius:BorderRadius.circular(10)),
                    child: Center(
                      child: ListTile(
                        title:Text(Heading[index] +""),
                        
                          subtitle:  Row(
                            children: [
                              Text(Subheading[index]),
                              SizedBox(width: 20,),
                             
                            ],
                          ),
                        
                          leading:
                       Image.network("${Img[index]}",width:57,height:57,fit:BoxFit.cover),
                        trailing: Column(
                          children: [
                            
                          SizedBox(height:20) ,
                          ElevatedButton(style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)
                
                        ),child:Text("Read More",style:TextStyle(color:Colors.white)),onPressed:()=> UpdateId(index))  
                            
                           ],
                        )),
                    )),
          );
        }),
             ),
           ));
  }
}