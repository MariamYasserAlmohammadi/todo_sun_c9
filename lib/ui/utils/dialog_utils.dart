import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showLoading(BuildContext context){
  showDialog(
      context: context,
      // click out the screen
      barrierDismissible: false,
      builder: (_){
          return const AlertDialog(
            content: Row(
              children: [
                Text('Loading...'),
                Spacer(),
                CircularProgressIndicator(),
              ],
            ) ,

          );
      });
}

void hideLoading(BuildContext context){
  Navigator.pop(context);
}

void showErrorDialog(BuildContext context , String message){
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_){
        return CupertinoAlertDialog(
          title: const Text("Error!"),
          content: Text(message) ,
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Ok"),)
          ],

        );
      });
}

