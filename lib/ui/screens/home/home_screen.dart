import 'package:flutter/material.dart';
import 'package:todo_sun_c9/ui/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:todo_sun_c9/ui/utils/app_colors.dart';

import '../../bottom_sheets/add_bottom_sheet.dart';
import 'tabs/list_tab/list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSelectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: currentSelectedTabIndex == 0 ? ListTab() : SettingsTab(),
      bottomNavigationBar: buildBottomNav(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: Text("To Do List"),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      );

  Widget buildBottomNav() => BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
            onTap: (index) {
              currentSelectedTabIndex = index;
              // print(index);
              setState(() {});
            },
            currentIndex: currentSelectedTabIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ]),
      );

  Widget buildFab() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: AddBottomSheet(),
                  ));
        },
        child: Icon(Icons.add),
      );
}
