

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massenger/massage.dart';


class homepages extends StatelessWidget {
  const homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [


       FutureBuilder(future:allfiend(), builder: (context, snapshot) {
         if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.data!= []){
            return  ListView.builder(itemCount:2,shrinkWrap:true,itemBuilder: (context, index) => InkWell(onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:(context) =>Massagepage(),));
        },
          child: Card(child:
          Row(
            children: [
              CircleAvatar(radius:29,child:Icon(Icons.person),),
                  SizedBox(
                    width: 20,
                  ),
              Column(
                children: [
                  Text("kkk"),
                  Text("sakib")
                ],
              )
            ],
          ) ,),
        ),);
          }else{
            return Text("no");
          }
         }else{
          return Text("no data");
         }
       },)
      
      ]),
    );
  }

  Future  allfiend ()async{
   
  String uid=  FirebaseAuth.instance.currentUser!.uid;
 var docSnap= await FirebaseFirestore.instance.collection("user_data").doc(uid).get();

  var friend_list = docSnap.get("friends");
  print(friend_list);
   return friend_list;
   
  }
}
