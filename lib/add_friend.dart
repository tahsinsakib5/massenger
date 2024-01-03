import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:massenger/massage.dart';
import 'package:massenger/model.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class addfriends extends StatelessWidget {
  const addfriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder(future: getdata(), builder: (context, snapshot) {
        if(snapshot.hasData){
        
          return ListView.builder(itemCount:snapshot.data.length,itemBuilder: (context, index) {
              alluser users = snapshot.data[index];
            return InkWell(
              onTap: ()async{
             String? docchat= await newchatducoment();

              Map <String,dynamic>allfiend ={
     "chat_id":docchat,
     "name":users.name,
     "uid":users.d_id,
   };

            createnewfried(allfiend);


              Map <String,dynamic>allfiendtow ={
     "chat_id":docchat,
     "name":users.name,
     "uid":FirebaseAuth.instance.currentUser!.uid,
   };


            createnewfriedtow(users.d_id.toString(), allfiendtow);

           
  
           await Navigator.push(context, MaterialPageRoute(builder: (context) => Massagepage(chatID:docchat!, targetUserID:users.d_id!),));
              

             print(docchat);
              },
              child: Card(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        Text(users.name)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },)
    );
  }


  Future getdata ()async{
  var  colactiois =await FirebaseFirestore.instance.collection("user_data").get();
       
       List allfiend =[];

       for(var colactionsnsapshort in colactiois.docs){
          String name = colactionsnsapshort.get("name");
          String age =colactionsnsapshort.get("age");
          String location = colactionsnsapshort.get("kihcana");
          var docid = colactionsnsapshort.reference.id;

          alluser user = alluser(d_id:docid,age: age, name: name, thikana:location);
          allfiend.add(user);
       }

       return allfiend;
     
  }


  Future createnewfried(Map<String,dynamic>allfiend)async{
    var docid =FirebaseAuth.instance.currentUser!.uid;
  final setfriend= await FirebaseFirestore.instance.collection("user_data").doc(docid);

   setfriend.update({
    "friends":FieldValue.arrayUnion([allfiend])
   });

  }


  Future createnewfriedtow(String docid,Map<String,dynamic>allfiend)async{
  
  final setfriend= await FirebaseFirestore.instance.collection("user_data").doc(docid);

   setfriend.update({
    "friends":FieldValue.arrayUnion([allfiend])
   });

  }


  Future newchatducoment()async{
 var documents= await  FirebaseFirestore.instance.collection("massages");

 final newMap = {
      // Add your key-value pairs for the new chat entry
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'msg':"hi",
      'timestamp': DateTime.now(),
      // ... add other relevant data for your chat entry
    };

 DocumentReference documentReference =await documents.add({
    'chat_list': FieldValue.arrayUnion([newMap])
 });

 
   return documentReference.id;
  }
}