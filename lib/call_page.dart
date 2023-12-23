import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          92035656, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign:
          '6fdd400e6246b5540ebfd9747a21168cc0b5dbc44cc0278b20397e0a6357bed3', // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: '11111',
      userName: 'User 1',
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()..onOnlySelfInRoom,
    );
  }
}
