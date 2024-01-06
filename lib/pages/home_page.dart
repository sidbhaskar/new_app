import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_app/database/hive_box.dart';
import 'package:new_app/widgets/dialog_box.dart';
import 'package:new_app/widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');
  final _controller = TextEditingController();
  ToDODatabase db = ToDODatabase();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadDatabase();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][0] = !db.toDoList[index][0];
    });
    db.loadDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([false, _controller.text]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: () {
            saveNewTask();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ek or TODO LIST wala app :)'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNewTask();
          },
        ),
        body: Center(
          child: ListView.builder(
            itemCount: db.toDoList.length,
            itemBuilder: (context, index) {
              return ToDoTile(
                checkvalue: db.toDoList[index][0],
                taskName: db.toDoList[index][1],
                onChanged: (value) {
                  checkBoxChanged(value, index);
                },
                deleteFunction: (context) {
                  deleteTask(index);
                },
              );
            },
          ),
        ));
  }
}
