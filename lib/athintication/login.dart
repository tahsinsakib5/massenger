


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massenger/athintication/singup.dart';

class Codepage extends StatefulWidget {

   Codepage({super.key,});

  @override
  State<Codepage> createState() => _CodepageState();
}

class _CodepageState extends State<Codepage> {
  final emailcontrilar = TextEditingController();

  final passworscontroler =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [
             TextField(controller: emailcontrilar,),
              TextField(controller:passworscontroler,),
    
            ElevatedButton(onPressed: () {
              login();
            }, child:Text("send")),
            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder:(context) =>Singup(),));
            }, child:Text("create acount"))
          ],
        ),
      ),
    );
  }

  Future login ()async{
    try{
        await  FirebaseAuth.instance.signInWithEmailAndPassword(email:emailcontrilar.text, password:passworscontroler.text);
        
    }catch(e){

    }
    
  }
}