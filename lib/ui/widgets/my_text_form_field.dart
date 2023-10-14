import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
String? hintText;
TextEditingController controller;
String initialValue;
// String text ;
MyTextFormField({super.key, this.hintText,
 required this.controller,
  // required this.text  ,
   this.initialValue =" "});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // onChanged: (newValue){
      //   text = newValue;
      // },
      initialValue: initialValue,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
