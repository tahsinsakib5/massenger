import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massenger/athintication/singup.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class Codepage extends StatefulWidget {
  Codepage({
    super.key,
  });

  @override
  State<Codepage> createState() => _CodepageState();
}

class _CodepageState extends State<Codepage> {
  final emailcontrilar = TextEditingController();

  final passworscontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            
              SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailcontrilar,
               
                decoration: InputDecoration(
                   hintText:"email",
                  border: OutlineInputBorder()
                  
                ),
              ),
            ),
          
           

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passworscontroler,
                 decoration: InputDecoration(
                   hintText:"password",
                  border: OutlineInputBorder()
                  
                ),
              ),
            ),
          
          SizedBox(
            height: 15,
          ),


      MaterialButton(onPressed: ()async{
        await login();
                  
      },child: Container(
        height:50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(30),
          color: Colors.blue
        ),
        child: Center(child: Text("Login",style: TextStyle(color: Colors.white),)),
      ),),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
            Text("you have "),
            
                  TextButton(
                    
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Singup(),
                            ));
                      },
                      child: Text("create acount")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontrilar.text, password: passworscontroler.text);
    } catch (e) {}
  }

  /// on App's user login

}
