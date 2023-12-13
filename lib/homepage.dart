import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massenger/massage.dart';

class homepages extends StatelessWidget {
  const homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ,

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
                        String? chatID = friendMap['chat_id'];

                        if (chatID == null) {
                          //Create a new Chat on Messege collection
                          print('Chat id not found, create Chat ID');
                        } else {
                          print(chatID);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Massagepage(chatID: chatID),
                              ));
                        }
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
  //   await FirebaseFirestore.instance.collection('massages').add({});
  // }

  // Future<void> addChatIDinFriend(String friendID) async {
  //   //Adding chatID to to friend in user_data collection
  //   var uid = FirebaseAuth.instance.currentUser!.uid;
  //   var docRef = FirebaseFirestore.instance.collection("user_data").doc(uid);

  // }

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
}
