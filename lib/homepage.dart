import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massenger/add_friend.dart';
import 'package:massenger/massage.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class homepages extends StatefulWidget {
  const homepages({super.key});

  @override
  State<homepages> createState() => _homepagesState();
}

 

class _homepagesState extends State<homepages> {

 var userName = "loading..";





  @override

   
  Widget build(BuildContext context) {

 
    return Scaffold(
      appBar: AppBar(title:FutureBuilder(
        future:curentuser(),
        builder: (context, snapshot) {
          return Text(snapshot.data??"loading..");
        }
      ),),
           floatingActionButton:FloatingActionButton(onPressed: () {
             Navigator.push(context,MaterialPageRoute(builder: (context)=>addfriends(),));
           },child:Icon(Icons.message),),

      body: Column(children: [
        FutureBuilder(
          future: allfiend(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data != []) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var friendMap = snapshot.data![index];

                    return InkWell(
                      onTap: () {
                        onUserLogin();
                        String? chatID = friendMap['chat_id'];

                        String? targetUserID = friendMap['uid'];

                        if (chatID != null && targetUserID != null) {
                          print('Chat ID: $chatID');
                          print('Target UserID: $targetUserID');

                          //Create a new Chat on Messege collection

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Massagepage(
                                    chatID: chatID, targetUserID: targetUserID),
                              ));

                          print('Chat id not found, create Chat ID');
                        } else {}
                      },
                      child: Card(
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 29,
                              child: Icon(Icons.person),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(friendMap['name'])
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Text("no");
              }
            } else {
              return const Text("no data");
            }
          },
        )
      ]),
    );
  }

  // Future<void> createChat() async {
  Future<List<Map<String, dynamic>>> allfiend() async {
    List<Map<String, dynamic>> friendList = [];

    var uid = FirebaseAuth.instance.currentUser!.uid;
    var docSnap =
        await FirebaseFirestore.instance.collection("user_data").doc(uid).get();

    if (docSnap.exists) {
      try {
        var allFriend = await docSnap.get("friends") as List;

        for (var friend in allFriend) {
          friendList.add(friend as Map<String, dynamic>);
        }
        print(allFriend);
      } catch (e) {
        print(e);
      }
    }

    return friendList;
  }

  void getcall() {
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: 92035656,
      appSign:
          '6fdd400e6246b5540ebfd9747a21168cc0b5dbc44cc0278b20397e0a6357bed3',
      userID: FirebaseAuth.instance.currentUser!.uid,
      userName: "user 1",
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

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

    Future curentuser() async {
    

    var uid = FirebaseAuth.instance.currentUser!.uid;
    var docSnap =
        await FirebaseFirestore.instance.collection("user_data").doc(uid).get();

    // if (docSnap.exists) {
      
      var name = docSnap.get("name"); 
      print(name);
    
    return name;

  
  }
}
