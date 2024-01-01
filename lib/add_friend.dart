import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:massenger/model.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(future:getuser(), builder: (context, snapshot){
        if(snapshot.hasData){
          return  ListView.builder(itemCount:snapshot.data.length,shrinkWrap:true,itemBuilder: (context, index) {
           alluser _allusers = snapshot.data[index];
           print({ "user"});
        return Container(
           child: Row(
            children: [
              Icon(Icons.person),
             Text(_allusers.thikana),
            ],
           ),
        );
      },);
        }else{
          return Center(child:CircularProgressIndicator(color:Colors.red,),);
        }
      },),
    );
  }

   Future getuser()async{
 
  var ColactionSnapshort=await FirebaseFirestore.instance.collection("user_data").get();

   List allusers =[];
     for(var documentSnapshot in ColactionSnapshort.docs){
        var name = documentSnapshot.get("name");
        var age = documentSnapshot.get("age");
        var  thikana = documentSnapshot.get("kihcana");

    alluser user=alluser(age: age, name: name, thikana: thikana);
     allusers.add(user);
     }

     return allusers;
    
    
   }
}