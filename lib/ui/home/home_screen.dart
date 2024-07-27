import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_project/ui/home/list/list_screen.dart';
import 'package:todo_app_project/ui/home/setting/setting_screen.dart';

import '../../core/provider/app_config_provider.dart';
import '../../utils/color_resource/color_resources.dart';
import 'new_task/new_task_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "Home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskSheet();
        },
        child: Icon(
          Icons.add,
          color: ColorResources.white,
          size: 25,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(2),
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: Theme(
          data: provider.isDark()
              ? Theme.of(context)
                  .copyWith(canvasColor: ColorResources.primaryDarkColor)
              : Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list_outlined), label: "List"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Setting"),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(50),
            color: ColorResources.primaryLightColor,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Text(
              AppLocalizations.of(context)!.appTitle,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: provider.isDark()
                      ? ColorResources.blackText
                      : ColorResources.white),
            ),
          ),
          Expanded(child: selectedIndex == 0 ? ListScreen() : SettingScreen()),
        ],
      ),
    );
  }

  void showAddTaskSheet() {
    showModalBottomSheet(context: context, builder: (context) => AddNewTask());
  }
}
