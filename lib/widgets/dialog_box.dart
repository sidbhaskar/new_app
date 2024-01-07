import 'package:flutter/material.dart';
import 'package:new_app/widgets/buttons.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close, size: 50),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: TextField(
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                  autofocus: true,
                  controller: controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter new task',
                    hintStyle: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
          TextButton(onPressed: onSave, child: Text('New Task'))
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: 150,
          child: FloatingActionButton(
            onPressed: onSave,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New Task',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_up_outlined,
                  size: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
