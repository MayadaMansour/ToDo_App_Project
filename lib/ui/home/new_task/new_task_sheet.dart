import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_project/utils/color_resource/color_resources.dart';

import '../../../core/provider/app_config_provider.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  var selectDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = " ";
  String description = " ";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

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
                  DateFormat.yMMMd().format(selectDate),
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
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context, {
                      'title': title,
                      'description': description,
                      'date': selectDate,
                    });
                  }
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
        lastDate: DateTime.now().add(const Duration(days: 356)));
    setState(() {
      selectDate = chosenDate ?? selectDate;
    });
  }
}
