import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_sun_c9/ui/providers/list_provider.dart';
import 'package:todo_sun_c9/ui/screens/home/tabs/list_tab/todo_widget.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
late ListProvider provider;
@override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refreshTodoList();
    });
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    // if (provider.todos.isEmpty) {
    //  provider.refreshTodoList();
    // }

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: AppColors.primiary,
                      )),
                  Expanded(
                      flex: 7,
                      child: Container(
                        color: AppColors.accent,
                      )),
                ],
              ),
              CalendarTimeline(
                initialDate: provider.selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (date) {
                  provider.selectedDate = date;
                  provider.refreshTodoList();
                },
                leftMargin: 20,
                monthColor: AppColors.white,
                dayColor: AppColors.primiary,
                activeDayColor: AppColors.primiary,
                activeBackgroundDayColor: AppColors.white,
                dotsColor: AppColors.transparent,
                // selectableDayPredicate: (date) => date.day != 23,
                locale: 'en_ISO',
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: provider.todos.length,
            itemBuilder: (context, index) => TodoWidget(
              modal: provider.todos[index],
            ),
          ),
        ),
      ],
    );
  }


}
