

import 'package:flutter/material.dart';
import 'package:massenger/template.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

 List <bool> value = [false,true,false,true,true,false,true];
 List masseges = ["hi" , " kemon aso balalo nak", "balo","tumi"," allahor rhmotebalo asi","akhon ki kortaso kalke amader barite aso"];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
       
       
          children: [

           
            ListView.builder(shrinkWrap: true,itemCount:masseges.length,itemBuilder: (context, index) =>Template(massege: masseges[index], chenge: value[index]),),
           Spacer(),
            TextField(decoration:InputDecoration(border:OutlineInputBorder(),suffixIcon:Icon(Icons.send),))
          ],
        ),
      ),
    );
  }
}
