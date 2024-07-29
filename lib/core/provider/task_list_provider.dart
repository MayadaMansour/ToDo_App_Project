import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../local/firebase_utlis.dart';
import '../model/task_model.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();

  void getAllTasksFromFireBase() async {
    QuerySnapshot<Task> querySnapshot =
        await FireBaseUtlis.getTaskCollection().get();
    tasksList = querySnapshot.docs.map((doc) => doc.data()).toList();
    tasksList = tasksList.where((task) {
      if (selectDate.day == task.dateTime.day &&
          selectDate.month == task.dateTime.month &&
          selectDate.year == task.dateTime.year) {
        return true;
      } else {
        return false;
      }
    }).toList();

    tasksList.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });
    notifyListeners();
  }

  void changeSelectDate(DateTime newSelectDate) {
    selectDate = newSelectDate;
    getAllTasksFromFireBase();
  }
}
