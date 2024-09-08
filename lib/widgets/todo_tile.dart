import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
   TodoTile({super.key, required this.taskName, required this.taskComplete, required this.onChanged, required this.deleteTask});
   final String taskName;
   final bool taskComplete;
   Function(bool?)? onChanged;
   Function(BuildContext)? deleteTask;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:  Slidable(
        endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(onPressed: deleteTask,
                icon: Icons.delete_outline_outlined,backgroundColor: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),)
            ]),
        child: ListTile(
          tileColor: const Color.fromARGB(50, 71, 24, 173),
          shape: RoundedRectangleBorder(
            borderRadius:BorderRadius.circular(12),
          ),
          title: Text(taskName, style:  TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold,
              decoration: taskComplete ? TextDecoration.lineThrough : TextDecoration.none),),
          trailing: Checkbox(value: taskComplete, onChanged: onChanged),
        ),
      ),
    );
  }
}
