import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/local/firebase_utlis.dart';
import '../../../core/model/task_model.dart';
import '../../../core/provider/app_config_provider.dart';
import '../../../core/provider/task_list_provider.dart';
import '../../../utils/color_resource/color_resources.dart';

class EditScreen extends StatefulWidget {
  final Task task;

  const EditScreen({super.key, required this.task});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late DateTime selectDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late TaskListProvider taskListProvider;

  @override
  void initState() {
    super.initState();
    selectDate = widget.task.dateTime;
    title = widget.task.title;
    description = widget.task.description;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    taskListProvider = Provider.of<TaskListProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorResources.primaryLightColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_sharp,
                        color: provider.isDark()
                            ? ColorResources.blackText
                            : ColorResources.white)),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: provider.isDark()
                            ? ColorResources.blackText
                            : ColorResources.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: provider.isDark()
                      ? ColorResources.primaryDarkColor
                      : ColorResources.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Edit Task",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                          initialValue: title,
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
                            hintStyle: TextStyle(
                                color: ColorResources.gray, fontSize: 16),
                          ),
                        ),
                        TextFormField(
                          initialValue: description,
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
                            hintStyle: TextStyle(
                                color: ColorResources.gray, fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Select Time",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
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
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            updateTask();
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(CircleBorder()),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(18)),
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
              ),
            ),
          )
        ],
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 356)),
    );
    setState(() {
      selectDate = chosenDate ?? selectDate;
    });
  }

  void updateTask() {
    if (_formKey.currentState!.validate()) {
      Task updatedTask = Task(
        id: widget.task.id,
        title: title,
        description: description,
        dateTime: selectDate,
      );
      FireBaseUtlis.updateTaskInFireBase(updatedTask).timeout(
        const Duration(seconds: 1),
        onTimeout: () {
          print("Task Updated Successfully");
          taskListProvider.getAllTasksFromFireBase();
        },
      );
      Navigator.pop(context);
    }
  }
}
