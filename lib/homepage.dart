import 'package:flutter/material.dart';

class homepages extends StatelessWidget {
  const homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
      
        Row(
          children: [
            CircleAvatar(radius:29,),

            Column(
              children: [
                Text("skib")
              ],
            )
          ],
        )
      ]),
    );
  }
}
