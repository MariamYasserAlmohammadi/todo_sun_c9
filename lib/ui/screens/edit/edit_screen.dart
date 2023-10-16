import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sun_c9/ui/common/my_text_form_field.dart';
import 'package:todo_sun_c9/ui/providers/list_provider.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';

import '../../../models/todo_dm.dart';


class EditScreen extends StatefulWidget {
  static const String routeName = "editscreen";

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  late DateTime selectedDate;

  late TodoDM modal;
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    modal = ModalRoute.of(context)!.settings.arguments as TodoDM;
    selectedDate = modal.date;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To Do List",
          style: AppTheme.appBarTextStyle,
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          Container(
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.4,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Edit task",
                      textAlign: TextAlign.center,
                      style: AppTheme.bottomSheetTitleTextStyle,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      onChanged: (newValue) {
                        modal.title = newValue;
                      },
                      initialValue: modal.title,
                      decoration: InputDecoration(
                      ),
                    ),
                    // MyTextFormField(
                    //   textOnChange: modal.title,
                    //   initialValue: modal.title,
                    //   textLabel: "Enter Task Title",
                    //
                    // ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      onChanged: (newValue) {
                        modal.description = newValue;
                      },
                      initialValue: modal.description,
                      decoration: InputDecoration(
                      ),
                    ),

                    // MyTextFormField(
                    //     textOnChange:  modal.description,
                    //     initialValue:  modal.description,
                    //   textLabel: "Enter Task description",),
                    const SizedBox(
                      height: 32,
                    ),
                    Text("Select Date",
                        // textAlign: TextAlign.start,
                        style: AppTheme.bottomSheetTitleTextStyle
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 24,
                    ),
                    InkWell(
                      onTap: () {
                        showMyDatePicker();
                      },
                      child: Text(
                          "${modal.date.day}/${modal.date.month}/${modal.date.year}",
                          textAlign: TextAlign.center,
                          style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                              fontWeight: FontWeight.normal,
                              color: AppColors.grey)),
                    ),
                    const SizedBox(
                      height: 128,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 64),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 16)),
                              backgroundColor:
                                  MaterialStateProperty.all(AppColors.primary),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ))),
                          onPressed: () {
                            editTask();
                          },
                          child: const Text("Save Changes")),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

// Future<void> deleteTask (TodoDM modal){
//
// }

  void showMyDatePicker() async {
    var newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (newSelectedDate != null) {
      modal.date = newSelectedDate;
      setState(() {});
    }
  }

  void editTask() {
    provider.editTodoDetails(modal).then((value) {
      Navigator.pop(context);
      provider.refreshTodoList();
    });
  }
}
