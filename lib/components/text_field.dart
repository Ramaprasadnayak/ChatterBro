import 'package:flutter/material.dart';

class TextFields extends StatelessWidget{
  final bool visibility;
  final TextEditingController control;
  final String myhinttext;
  final double textwidth,textheight;
  const TextFields({super.key,required this.textheight,required this.textwidth,required this.visibility,required this.control,required this.myhinttext});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: textwidth,
      height: textheight,
      child:
        TextField(
          controller: control,
          obscureText: visibility,
          decoration: InputDecoration(
            hintText: myhinttext,
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            hintStyle: TextStyle(color: Colors.grey)
          ),
        ),
    );
  }
}