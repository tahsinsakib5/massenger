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
          children: [
            TextField(
              controller: emailcontrilar,
            ),
            TextField(
              controller: passworscontroler,
            ),
            ElevatedButton(
                onPressed: () async {
                  await login();
                  onUserLogin();
                },
                child: Text("login")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Singup(),
                      ));
                },
                child: Text("create acount"))
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
  void onUserLogin() {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 92035656,
      appSign:
          '6fdd400e6246b5540ebfd9747a21168cc0b5dbc44cc0278b20397e0a6357bed3',
      userID: FirebaseAuth.instance.currentUser!.uid,
      userName: "user 1",
      plugins: [ZegoUIKitSignalingPlugin()],
    );

    print('Zego initialized');
  }
}
