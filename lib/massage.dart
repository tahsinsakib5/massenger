import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:massenger/call_page.dart';
import 'package:massenger/template.dart';
import 'package:massenger/voicecallpage.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class Massagepage extends StatefulWidget {
  String chatID;
  String targetUserID;
  Massagepage({super.key, required this.chatID, required this.targetUserID});

  @override
  State<Massagepage> createState() => _MassagepageState();
}

final massegecontrolar = TextEditingController();



class _MassagepageState extends State<Massagepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                onUserLogout();
              },
              icon: const Icon(Icons.logout)),
              
              
          actions: [
            

             
            FittedBox(
              fit: BoxFit.fitHeight,
              child: ZegoSendCallInvitationButton(
                isVideoCall: false,
                // resourceID:
                //     "zegouikit_call", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                invitees: [
                  ZegoUIKitUser(
                    id: widget.targetUserID,
                    name: "User 2",
                  ),


                  
                ],
              ),
            ),


             FittedBox(
              fit: BoxFit.fitHeight,
              child: ZegoSendCallInvitationButton(
                isVideoCall: true,
                // resourceID:
                //     "zegouikit_call", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                invitees: [
                  ZegoUIKitUser(
                    id: widget.targetUserID,
                    name: "User 2",
                  ),


                  
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: [
            
            Expanded(
              child: FutureBuilder(
                  future: getChatList(widget.chatID),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data!.isNotEmpty) {
                        print('Chat Found');
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> chat = snapshot.data![index];

                            bool isThisUser = false;

                            if (chat['uid'] ==
                                FirebaseAuth.instance.currentUser!.uid) {
                              isThisUser = true;
                            }

                            return Template(
                                massege: chat['msg'], chenge: isThisUser);
                          },
                        );
                      } else {
                        print('No Chat Found');

                        return const Center(
                          child: Text('Start Chatting'),
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            TextField(
                controller: massegecontrolar,
                decoration: InputDecoration(
                     fillColor:Colors.grey[200],
                     filled: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          await sendMessage(widget.chatID);
                          massegecontrolar.clear();
                          setState(() {});
                          
                        },
                        icon: Icon(Icons.send))))
          ],
        ),
      ),
    );
  }

  /// on App's user logout
  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
    print('Zego Cloud removed');
  }

  Future<void> sendMessage(String chatID) async {
    final collection = FirebaseFirestore.instance.collection('massages');
    final docRef = collection.doc(chatID);

    final newMap = {
      // Add your key-value pairs for the new chat entry
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'msg': massegecontrolar.text,
      'timestamp': DateTime.now(),
      // ... add other relevant data for your chat entry
    };

// Option 2: Use arrayUnion if you're working with larger sets of data
    await docRef.update({
      'chat_list': FieldValue.arrayUnion([newMap])
    });
  }

  Future<List<Map<String, dynamic>>> getChatList(String chatID) async {
    List<Map<String, dynamic>> allChatList = [];

    final collection = FirebaseFirestore.instance.collection('massages');
    final docRef = collection.doc(chatID);

    await docRef.get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        if (data != null && data.containsKey('chat_list')) {
          // Field exists, get its value
          final chatList = data['chat_list'] as List<dynamic>;

          print('Field Found ${chatList.length}');

          for (var chat in chatList) {
            allChatList.add(chat as Map<String, dynamic>);
          }

          print('All Chat 1 : ${allChatList.length}');

          // ... process chatList
        } else {
          // Field doesn't exist, create and set it to an empty array
          docRef.update({'chat_list': []}).then((_) {
            // Access the newly created field (empty array)
            // final chatList = documentSnapshot.get('chat_list') as List<dynamic>;
            // ... process chatList
          });
        }
      } else {
        // Document not found
      }
    });

    print('All Chat 2 : ${allChatList.length}');

    return allChatList;
  }

  Stream<DocumentSnapshot> streamCallData(String chatID) {
    return FirebaseFirestore.instance
        .collection('massages')
        .doc(chatID)
        .snapshots();
  }



 


}
