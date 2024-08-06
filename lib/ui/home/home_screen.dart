import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_project/core/provider/user_provider.dart';
import 'package:todo_app_project/ui/home/list/list_screen.dart';
import 'package:todo_app_project/ui/home/setting/setting_screen.dart';
import 'package:todo_app_project/ui/register_login/login_screen.dart';

import '../../core/provider/app_config_provider.dart';
import '../../core/provider/task_list_provider.dart';
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
    var authProvider = Provider.of<AuthUserProvider>(context);
    var listProvider = Provider.of<TaskListProvider>(context);

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
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: ColorResources.primaryLightColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: CircleAvatar(
                    radius: 25,
                    child: Image.asset("assets/images/profile.png"),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        authProvider.currentUser?.name ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: provider.isDark()
                                  ? ColorResources.blackText
                                  : ColorResources.white,
                            ),
                      ),
                      Text(
                        authProvider.currentUser?.email ?? "",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: provider.isDark()
                                  ? ColorResources.blackText
                                  : ColorResources.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: selectedIndex == 0 ? ListScreen() : SettingScreen(),
          ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              listProvider.tasksList = [];
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginScreen()),
              // );
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            icon: Icon(
              Icons.logout_outlined,
              color: ColorResources.white,
            ),
          ),
        ],
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: provider.isDark()
                    ? ColorResources.blackText
                    : ColorResources.white,
              ),
        ),
      ),
    );
  }

  void showAddTaskSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => const AddNewTask());
  }
}
