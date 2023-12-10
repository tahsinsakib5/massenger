import 'package:flutter/material.dart';

class Template extends StatelessWidget {
   final bool  chenge; 
 final String massege;

  Template({super.key, required this.massege, required this.chenge,});

  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
            alignment:chenge ? Alignment.centerRight : Alignment.centerLeft ,
          child:   Container(
          
              width:MediaQuery.of(context).size.width * 0.56,
              
              padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
            borderRadius:chenge
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topRight: Radius.circular(12)),
            color: chenge ? Colors.blue : const Color.fromARGB(255, 240, 212, 212),
                ),
                child: Text(
            massege,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: chenge ? Colors.white : Colors.black),
            textAlign: TextAlign.start,
                ),
              ),
          ),
      );
  }
}
