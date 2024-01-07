import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    db.updateDatabase();
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
      backgroundColor: Color.fromARGB(255, 244, 246, 253),
      //! app bar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 244, 246, 253),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          shape: CircleBorder(),
          tooltip: 'Add Notes',
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            createNewTask();
          },
        ),
      ),

      //! body ...

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'What\'s up, Sid!',
              style: GoogleFonts.poppins(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(195, 0, 0, 0),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 20, left: 20),
            child: Text(
              'T O D A Y \' S   T A S K S',
              style: TextStyle(color: Colors.black45),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
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
          ),
        ],
      ),
    );
  }
}
