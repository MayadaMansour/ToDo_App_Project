import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_project/core/local/firebase_utlis.dart';
import 'package:todo_app_project/core/model/task_model.dart';

import '../../../core/provider/task_list_provider.dart';
import '../../../utils/color_resource/color_resources.dart';
import '../edit_task/edit_task_screen.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.task});

  final Task task;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<TaskListProvider>(context);

    return Container(
      margin: const EdgeInsets.all(12),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (context) {
                FireBaseUtlis.deleteTasksToFireBase(widget.task)
                    .timeout(const Duration(milliseconds: 500), onTimeout: () {
                  print("Task Deleted");
                  listProvider.getAllTasksFromFireBase();
                });
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(15),
              padding: const EdgeInsets.all(10),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditScreen()),
            );
          },
          child: Card(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(25),
                  color: isClick
                      ? ColorResources.green
                      : ColorResources.primaryLightColor,
                  height: 60,
                  width: 3,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.task.title,
                        style: isClick
                            ? Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.green)
                            : Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.black),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined),
                          Text(
                            DateFormat('yMMMd').format(widget.task.dateTime),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isClick = !isClick;
                    });
                  },
                  child: isClick
                      ? Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Text('Done',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.green)),
                        )
                      : Container(
                          padding: const EdgeInsets.only(
                              left: 18, right: 18, top: 5, bottom: 5),
                          margin: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: ColorResources.primaryLightColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
