import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_project/utils/color_resource/color_resources.dart';

class ListScreen extends StatefulWidget {
  ListScreen({super.key});

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final List<bool> _clickStatus = List<bool>.generate(20, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Slidable(
            key: ValueKey(index),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    setState(() {
                      _clickStatus.removeAt(index);
                    });
                  },
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(15),
                  padding: EdgeInsets.all(10),
                ),
              ],
            ),
            child: Card(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(25),
                    color: _clickStatus[index]
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
                          "Task",
                          style: _clickStatus[index]
                              ? Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: ColorResources.green)
                              : Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: ColorResources.blackText),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined),
                            Text(
                              "10:30 Am",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: ColorResources.blackText),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          _clickStatus[index] = !_clickStatus[index];
                        });
                      },
                      child: _clickStatus[index]
                          ? Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Text('Done',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: ColorResources.green)),
                            )
                          : Container(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 5, bottom: 5),
                              margin: const EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                color: ColorResources.primaryLightColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                              child: Icon(
                                Icons.check,
                                color: ColorResources.white,
                                size: 28,
                              ),
                            )),
                ],
              ),
            ));
      },
    );
  }
}
