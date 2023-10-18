import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_sun_c9/models/todo_dm.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';

import '../../../../providers/list_provider.dart';
import '../../../edit/edit_screen.dart';


class TodoWidget extends StatefulWidget {
  final TodoDM modal;

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
                provider.deleteTodo(widget.modal);
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
                const VerticalDivider(),
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
                        style: AppTheme.taskTitleTextStyle,
                      ),
                      Text(
                        widget.modal.description,
                        style: AppTheme.taskDescriptionTextStyle,
                      )
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.white,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
