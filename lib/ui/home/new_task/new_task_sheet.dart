import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_project/core/provider/user_provider.dart';

import '../../../core/local/firebase_utlis.dart';
import '../../../core/model/task_model.dart';
import '../../../core/provider/app_config_provider.dart';
import '../../../core/provider/task_list_provider.dart';
import '../../../utils/color_resource/color_resources.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var selectDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  late TaskListProvider taskListProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    taskListProvider = Provider.of<TaskListProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      color: provider.isDark()
          ? ColorResources.primaryDarkColor
          : ColorResources.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Add New Task",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: provider.isDark()
                          ? ColorResources.white
                          : ColorResources.blackText,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (text) {
                  title = text;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter The Task";
                  }
                  return null;
                },
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorResources.blackText),
                decoration: InputDecoration(
                  hintText: 'Enter Your Task',
                  hintStyle:
                      TextStyle(color: ColorResources.gray, fontSize: 16),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  description = text;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter The Description";
                  }
                  return null;
                },
                maxLines: 3,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: ColorResources.blackText),
                decoration: InputDecoration(
                  hintText: 'Description',
                  hintStyle:
                      TextStyle(color: ColorResources.gray, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Select Time",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: provider.isDark()
                          ? ColorResources.white
                          : ColorResources.blackText,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showCalender();
                },
                child: Text(
                  DateFormat('yMMMd').format(selectDate),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: ColorResources.gray),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              ElevatedButton(
                onPressed: () {
                  addTask();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(18)),
                  backgroundColor: MaterialStateProperty.all(
                      ColorResources.primaryLightColor),
                ),
                child: Icon(
                  Icons.add,
                  color: ColorResources.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 356)),
    );
    setState(() {
      selectDate = chosenDate ?? selectDate;
    });
  }

  void addTask() {
    if (_formKey.currentState!.validate()) {
      Task task = Task(
        title: title,
        description: description,
        dateTime: selectDate,
      );
      var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
      FireBaseUtlis.addTasksToFireBase(task, authProvider.currentUser!.id!)
          .then((value) {
        print("Task Added Successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Task Added Successfully',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );

        taskListProvider.getAllTasksFromFireBase(authProvider.currentUser!.id!);
      });
      Provider.of<TaskListProvider>(context, listen: false)
          .getAllTasksFromFireBase(authProvider.currentUser!.id!);

      Navigator.pop(context);
    }
  }
}
