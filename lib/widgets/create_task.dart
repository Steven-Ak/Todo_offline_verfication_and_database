import 'package:flutter/material.dart';
import 'package:task_5/widgets/task_button.dart';

class DialogBox extends StatelessWidget {
   DialogBox({super.key, required this.controller, required this.onSave, required this.onCancel});
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(height: 200,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text("New Task", style: TextStyle(color: Color.fromARGB(255, 71, 24, 173), fontWeight: FontWeight.bold, fontSize: 30),) ,
          const Divider(),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
               border: OutlineInputBorder(),
              labelText: "Task"
            ),
          ),
            Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TaskButton(title: "Cancel", onPressed: onCancel),
              TaskButton(title: "OK", onPressed: onSave)
            ],
          ),
        ],
      ))
    );
  }
}
