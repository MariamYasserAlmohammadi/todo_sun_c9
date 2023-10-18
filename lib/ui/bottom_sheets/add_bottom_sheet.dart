import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sun_c9/models/app_user.dart';
import 'package:todo_sun_c9/models/todo_dm.dart';
import 'package:todo_sun_c9/ui/providers/list_provider.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';
import '../common/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late ListProvider provider;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Form(
        key: formKey,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add New task",
              textAlign: TextAlign.center,
              style: AppTheme.bottomSheetTitleTextStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            MyTextField(
              hintText: "Enter task Title",
              controller: titleController,
            ),
            const SizedBox(
              height: 8,
            ),
            MyTextField(
              hintText: "Enter task description",
              controller: descriptionController,
            ),
            const SizedBox(
              height: 16,
            ),
            Text("Select Date",
                style: AppTheme.bottomSheetTitleTextStyle
                    .copyWith(fontWeight: FontWeight.w600)),
            InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                  textAlign: TextAlign.center,
                  style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                      fontWeight: FontWeight.normal, color: AppColors.grey)),
            ),
            ElevatedButton(
                onPressed: () {
                  addTodoFireStore();
                },
                child: const Text("Add")),
          ],
        ),
      ),
    );
  }
  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }

  void addTodoFireStore() async{
    CollectionReference todosCollectionRef =
    AppUser.collection().doc(AppUser.currentUser!.id).collection(TodoDM.collectionName);
    DocumentReference newEmptyDoc = todosCollectionRef.doc();
     await newEmptyDoc.set({
      "id": newEmptyDoc.id,
      "title": titleController.text,
      "description": descriptionController.text,
      "date": selectedDate,
      "isDone": false,
    });
    provider.refreshTodoList();
    Navigator.pop(context);
    // .timeout(Duration(milliseconds: 300), onTimeout: () {
    //   provider.refreshTodoList();
    //   Navigator.pop(context);
    // });


// todosCollectionRef.add({
//   "title" :titleController.text ,
//   "description": descriptionController.text,
//   "date": selectedDate,
//   "id": ,
//   "isDone": false ,
//
// });
  }
}
///طريقة عرض للداتا
///  Json -> java script object notation
///  {key : value}
///  key -> string
///  value -> String , number , null ,timestamp , json , List<Json>
