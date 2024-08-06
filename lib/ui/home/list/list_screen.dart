import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_project/core/provider/task_list_provider.dart';
import 'package:todo_app_project/core/provider/user_provider.dart';
import 'package:todo_app_project/utils/color_resource/color_resources.dart';

import 'list_item.dart';

class ListScreen extends StatefulWidget {
  ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<TaskListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getAllTasksFromFireBase(authProvider.currentUser?.id ?? "");
      // setState(() {
      //
      // });
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: listProvider.selectDate,
          onDateChange: (selectedDate) {
            listProvider.changeSelectDate(
                selectedDate, authProvider.currentUser!.id!);
          },
          headerProps: EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            monthStyle: TextStyle(color: ColorResources.blackText),
            dateFormatter: const DateFormatter.fullDateDMY(),
          ),
          dayProps: EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                color: ColorResources.primaryLightColor,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
            ),
            inactiveDayStyle: const DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: listProvider.tasksList.length,
            itemBuilder: (context, index) {
              return ListItem(task: listProvider.tasksList[index]);
            },
          ),
        ),
      ],
    );
  }
}
