import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Singup extends StatefulWidget {
   Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
 final emailcontroler = TextEditingController();
  final paswordcotroler = TextEditingController();

  final namecotroler = TextEditingController();
  final agecotroler = TextEditingController();
  final thikanacotroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: emailcontroler,decoration: InputDecoration(hintText: "email")),
                TextField(controller: paswordcotroler,decoration: InputDecoration(hintText: "passwword")),
                  TextField(controller: namecotroler,decoration: InputDecoration(hintText: "name")),
                    TextField(controller: agecotroler,decoration: InputDecoration(hintText: "age")),
                      TextField(controller: thikanacotroler,decoration: InputDecoration(hintText: "city")),
              
                 ElevatedButton(onPressed: ()async{
            
            
                   
                   String? userid = await Singup();
            
                        if (userid != null) {
                          Map<String, dynamic> data = {
                            'name':
                                   namecotroler.text,
                            'age': agecotroler.text,
                             'kihcana': thikanacotroler.text,
                          };
            
                           await userdata (userid, data);
            
                        
                        }
                 }, child: Text("singin"))
              ],
            ),
          ),
        ),
      ),
    );
  }

    // Future phonnumberathitication ()async{
    //   FirebaseAuth.instance.verifyPhoneNumber(phoneNumber:phonenumber.text,verificationCompleted:(_){}, verificationFailed:(e){}, codeSent:(String verificationId , int ? token ){
    //       Navigator.push(context, MaterialPageRoute(builder: (context) =>Codepage(code:verificationId,),));
    //   }, codeAutoRetrievalTimeout:(e){});
    // }


    Future Singup ()async{
  var userinfo  = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:emailcontroler.text, password:paswordcotroler.text);

   return userinfo.user!.uid;
    }


    Future userdata ( String uid , Map<String,dynamic> data)async{
    await  FirebaseFirestore.instance.collection("user_data").doc(uid).set(data);
    }

   
}