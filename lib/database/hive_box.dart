import 'package:hive/hive.dart';

class ToDODatabase {
  List toDoList = [];
  final _mybox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [
      [false, 'First item'],
      [true, 'Second item']
    ];
  }

  void loadDatabase() {
    toDoList = _mybox.get("TODOLIST");
  }

  // update database
  void updateDatabase() {
    _mybox.put("TODOLIST", toDoList);
  }
}
