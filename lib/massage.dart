

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massenger/template.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

 List <bool> value = [false,true,false,true,true,false,true];
 List masseges = ["hi" , " kemon aso balalo nak", "balo","tumi"," allahor rhmotebalo asi","akhon ki kortaso kalke amader barite aso"];
 final massegecontrolar = TextEditingController();
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
       
       
          children: [

           
            ListView.builder(shrinkWrap: true,itemCount:masseges.length,itemBuilder: (context, index) =>Template(massege: masseges[index], chenge: value[index]),),
           Spacer(),
            TextField(controller:massegecontrolar,decoration:InputDecoration(border:OutlineInputBorder(),suffixIcon:IconButton(onPressed: () {
              massege();
            }, icon:Icon(Icons.send))))
          ],
        ),
      ),
    );
  }

Future massege ()async{
 var time = DateTime.now();
String userid=await  FirebaseAuth.instance.currentUser!.uid;

print ("userid $userid");

var colaction = await  FirebaseFirestore.instance.collection("user_data").doc(userid).collection("massage");

Map <String,dynamic> massage ={
"massage":massegecontrolar.text,
"time":time,
};
colaction.add(massage);
}

}
