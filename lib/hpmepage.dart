

import 'package:flutter/material.dart';
import 'package:massenger/template.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
       
       
          children: [

           
            Expanded(
              child: ListView(
                shrinkWrap:true,
                children: [
                  Text("tody"),
                  Template(massege: "sakibul", chenge: false)
                ],
              ),
            ),
           Spacer(),
            TextField(decoration:InputDecoration(border:OutlineInputBorder(),suffixIcon:Icon(Icons.send),))
          ],
        ),
      ),
    );
  }
}
