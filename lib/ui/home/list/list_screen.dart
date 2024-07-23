import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return const Card(
            child: ListTile(
              title: Text('Task'),
              subtitle: Text('Description for task '),
            ),
          );
        },
      ),
    );
  }
}
