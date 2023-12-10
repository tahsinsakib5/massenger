import 'package:flutter/material.dart';

class Codepage extends StatelessWidget {
  final String code;
  const Codepage({super.key, required this.code});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
           TextField(),

          ElevatedButton(onPressed: () {
            
          }, child:Text("send"))
        ],
      ),
    );
  }
}