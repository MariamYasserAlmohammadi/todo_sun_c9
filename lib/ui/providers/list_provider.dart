
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  List<TodoDM> todos = [];
  DateTime selectedDate = DateTime.now();

  void refreshTodoList() async {
    CollectionReference<TodoDM> todosCollection = FirebaseFirestore.instance
        .collection(TodoDM.collectionName)
        .withConverter<TodoDM>(fromFirestore: (docSnapShot, _) {
      Map json = docSnapShot.data() as Map;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }, toFirestore: (todoDm, _) {
      return todoDm.toJson();
    });
    //snapshot لقطه من الداتا في وقت معين
    QuerySnapshot<TodoDM> todoSnapshot = await todosCollection
        .orderBy("date", descending: true)
        .get();

    List<QueryDocumentSnapshot<TodoDM>> docs = todoSnapshot.docs;
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();

   todos =  todos.where((todo) {
         if (todo.date.day != selectedDate.day ||
             todo.date.month != selectedDate.month ||
             todo.date.year != selectedDate.year){
           return false;
         }else{
           return true;
         }
    }).toList();

    notifyListeners();
  }
}
