import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase{
  List todos =[];
  final String email;
  TodoDatabase(this.email);
  final _box = Hive.box("box");

  void createInitialData(){
    todos = [];
    _box.put("$email-todos", todos);
  }

  void loadData(){
    final data = _box.get("$email-todos");
    todos = (data != null) ? List.from(data) : [];
  }
  void updateData(){
    _box.put("$email-todos", todos);
  }
}