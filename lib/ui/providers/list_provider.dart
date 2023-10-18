import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/todo_dm.dart';

// extension MyDateExtension on DateTime{
//   DateTime getDateOnly (){
//     return DateTime(this.year ,this.month ,this.day);
//   }
// }

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
    QuerySnapshot<TodoDM> todosSnapshot =
        await todosCollection.orderBy("date", ).get();
    // list of documents
    List<QueryDocumentSnapshot<TodoDM>> docs = todosSnapshot.docs;
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();

    todos = todos.where((todo) {
      if (todo.date.day != selectedDate.day ||
          todo.date.month != selectedDate.month ||
          todo.date.year != selectedDate.year) {
        // todo remove from list
        return false;
      } else {
        return true;
      }
    }).toList();

    notifyListeners();
  }

  Future<void> editTodoDetails(TodoDM todoDm) {
    CollectionReference<TodoDM> todosCollection = FirebaseFirestore.instance
        .collection(TodoDM.collectionName)
        .withConverter<TodoDM>(fromFirestore: (docSnapShot, _) {
      Map json = docSnapShot.data() as Map;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }, toFirestore: (todoDm, _) {
      return todoDm.toJson();
    });
    return todosCollection.doc(todoDm.id).update({
      'title': todoDm.title,
      'description': todoDm.description,
      'date': todoDm.date
    });
  }

  Future<void> deleteTodo(TodoDM todoDm) {
    CollectionReference<TodoDM> todosCollectionRef = FirebaseFirestore.instance
        .collection(TodoDM.collectionName)
        .withConverter<TodoDM>(fromFirestore: (docSnapShot, _) {
      Map json = docSnapShot.data() as Map;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }, toFirestore: (todoDm, _) {
      return todoDm.toJson();
    });
    DocumentReference<TodoDM> itemDoc = todosCollectionRef.doc(todoDm.id);
    return itemDoc.delete();

  }

//   void setNewSelectedDay(DateTime selectedDay){
//     selectedDate =selectedDay;
// notifyListeners();
//   }
}
