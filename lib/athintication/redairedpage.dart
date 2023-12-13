import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massenger/athintication/login.dart';
import 'package:massenger/massage.dart';


class Redairegpage extends StatelessWidget {
  const Redairegpage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Massagepage() ;
        } else {
          return Codepage();
        }
      },
    );
  }
}
