import 'package:flutter/material.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';

class MyTextFormField extends StatelessWidget {
  String initialValue;
  String textOnChange ;
  String textLabel;
  MyTextFormField({super.key,
    required this.textOnChange,
    required this.textLabel,
    this.initialValue = " "});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (newValue){
        textOnChange = newValue;
      },
      initialValue: initialValue,

      decoration: InputDecoration(
        label: Text(textLabel,style: TextStyle(
        ),),
      ),
    );
  }
}
