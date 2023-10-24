import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_sun_c9/models/todo_dm.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';
import 'package:todo_sun_c9/ui/utils/dialog_utils.dart';

import '../../../../../models/app_user.dart';
import '../../../../providers/list_provider.dart';
import '../../../edit/edit_screen.dart';


class TodoWidget extends StatefulWidget {
  late TodoDM modal;

  TodoWidget({super.key, required this.modal});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late ListProvider provider;


  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 22, horizontal: 30),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                deleteTodoFromFireStore(widget.modal);
              },
              backgroundColor: Colors.red,
              foregroundColor: AppColors.white,
              icon: Icons.delete,
              label: "Delete",

            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, EditScreen.routeName,
                arguments: widget.modal);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            height: MediaQuery.of(context).size.height * 0.13,
            child: Row(
              children: [
                widget.modal.isDone? const VerticalDivider(
                  color:  AppColors.done  ,
                )
                    :const VerticalDivider(),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.modal.title,
                        style:  widget.modal.isDone ? AppTheme.taskTitleDoneTextStyle :AppTheme.taskTitleTextStyle,
                      ),
                      Text(
                        widget.modal.description,
                        style: widget.modal.isDone ? AppTheme.taskDescriptionDoneTextStyle :AppTheme.taskDescriptionTextStyle,
                      )
                    ],
                  ),
                ),
                widget.modal.isDone ?
                const Text("Is Done",style: TextStyle(
                  color: AppColors.done,
                  fontSize: 22,

                ),)
                : InkWell(
                  onTap: (){
                    CollectionReference<TodoDM> todosCollection =
                    AppUser.collection().doc(AppUser.currentUser!.id)
                        .collection(TodoDM.collectionName)
                        .withConverter<TodoDM>(fromFirestore: (docSnapShot, _) {
                      Map json = docSnapShot.data() as Map;
                      TodoDM todo = TodoDM.fromJson(json);
                      return todo;
                    }, toFirestore: (todoDm, _) {
                      return todoDm.toJson();
                    });
                    todosCollection.doc(widget.modal.id).update(
                        {
                            'isDone': true,
                          }).then((value){
                            provider.refreshTodoList();
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.white,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void deleteTodoFromFireStore(TodoDM todoDm) {
    showLoading(context);
    CollectionReference<TodoDM> todosCollection =
    AppUser.collection().doc(AppUser.currentUser!.id)
        .collection(TodoDM.collectionName)
        .withConverter<TodoDM>(fromFirestore: (docSnapShot, _) {
      Map json = docSnapShot.data() as Map;
      TodoDM todo = TodoDM.fromJson(json);
      return todo;
    }, toFirestore: (todoDm, _) {
      return todoDm.toJson();
    });
    DocumentReference<TodoDM> itemDoc = todosCollection.doc(todoDm.id);
    itemDoc.delete().then((value) {
      provider.refreshTodoList();
    });
    hideLoading(context);


  }
}
