import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:massenger/athintication/codepage.dart';

class Singup extends StatefulWidget {
   Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
 final phonenumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: phonenumber,)
        ],
      ),
    );
  }

    Future phonnumberathitication ()async{
      FirebaseAuth.instance.verifyPhoneNumber(phoneNumber:phonenumber.text,verificationCompleted:(_){}, verificationFailed:(e){}, codeSent:(String verificationId , int ? token ){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>Codepage(code:verificationId,),));
      }, codeAutoRetrievalTimeout:(e){});
    }
}