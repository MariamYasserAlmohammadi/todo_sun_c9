import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';
import 'package:todo_sun_c9/ui/utils/app_theme.dart';
import 'package:todo_sun_c9/ui/widgets/my_text_field.dart';

class AddBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(12),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New task",
            textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,
          ),
          SizedBox(
            height: 16,
          ),
          MyTextField(hintText: "Enter task Title"),
          SizedBox(
            height: 8,
          ),
          MyTextField(hintText: "Enter task description"),
          SizedBox(
            height: 16,
          ),
          Text("Select Date",
              style: AppTheme.bottomSheetTitleTextStyle
                  .copyWith(fontWeight: FontWeight.w600)),
          Text("24/9/2023",
              textAlign: TextAlign.center,
              style: AppTheme.bottomSheetTitleTextStyle.copyWith(
                  fontWeight: FontWeight.normal, color: AppColors.grey)),
          ElevatedButton(onPressed: () {}, child: Text("Add")),
        ],
      ),
    );
  }
}
