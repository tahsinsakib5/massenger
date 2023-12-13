import 'package:flutter/material.dart';

class homepages extends StatelessWidget {
  const homepages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
         ListView.builder(itemCount:2,shrinkWrap:true,scrollDirection: Axis.horizontal,itemBuilder: (context, index) => CircleAvatar(radius:29,child:Icon(Icons.person),),)
        ]
      ),
    );
  }
}