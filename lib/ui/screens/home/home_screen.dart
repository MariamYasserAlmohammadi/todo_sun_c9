import 'package:flutter/material.dart';
import 'package:todo_sun_c9/ui/screens/home/tabs/settings_tab/settings_tab.dart';
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
      body: currentSelectedTabIndex == 0 ? const ListTab() : const SettingsTab(),
      bottomNavigationBar: buildBottomNav(),
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget buildAppBar() => AppBar(
        title: const Text("To Do List"),
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
    elevation: 0,
      );

  Widget buildBottomNav() => BottomAppBar(
    notchMargin: 8,
    clipBehavior: Clip.hardEdge,
    shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
            onTap: (index) {
              currentSelectedTabIndex = index;
              // print(index);
              setState(() {});
            },
            currentIndex: currentSelectedTabIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
            ]),
      );

  Widget buildFAB() => FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              //Bug (KeyBoard)
              builder: (_) => Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: const AddBottomSheet(),
                  ));
        },
        child: const Icon(Icons.add),
      );
}
