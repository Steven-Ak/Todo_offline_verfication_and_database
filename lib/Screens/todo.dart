import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_5/database/database.dart';
import 'package:task_5/widgets/create_task.dart';
import 'package:task_5/widgets/todo_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.name, required this.email});
  final String name;
  final String email;
  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _box = Hive.box("box");
  late TodoDatabase db;
  final _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = TodoDatabase(widget.email);
    if (_box.get("${widget.email}-todos") == null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
  }

  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.todos[index][1] = !db.todos[index][1];
      db.updateData();
    });
  }
  void saveTask(){
    setState(() {
      if(_taskController.text != ''){
        db.todos.add([_taskController.text, false]);
        Navigator.of(context).pop();
        _taskController.clear();
        db.updateData();
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Task cant be empty!")));
      }
    });
  }
  void createTask(){
  showDialog(context: context, builder: (context) {
      return DialogBox(controller: _taskController, onSave: saveTask, onCancel: () => Navigator.of(context).pop());
  });
  }

  void deleteTask(int index){
    setState(() {
      db.todos.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Welcome, ${widget.name}", style: const TextStyle(color: Colors.white, fontSize: 30),),
        backgroundColor: const Color.fromARGB(255, 71, 24, 173),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: createTask,
      child: const Icon(Icons.add)),
      body: db.todos.isEmpty ?
      const Center(
        child: Text("There is nothing to do!", style: TextStyle(color: Color.fromARGB(255, 71, 24, 173), fontSize: 25)),
      )
      :
      ListView.separated(
        padding: const EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        itemCount: db.todos.length,
          itemBuilder: (context, index)=> TodoTile(
              taskName: db.todos[index][0],
              taskComplete: db.todos[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteTask: (BuildContext ) => deleteTask(index) ),
        separatorBuilder: (_, __) => const SizedBox(
          height: 25,
        ),
      ),
    );
  }
}
