import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  bool checkvalue;
  final String taskName;
  void Function(bool?)? onChanged;
  void Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.checkvalue,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Checkbox(
                value: checkvalue,
                onChanged: onChanged,
              ),
              Text(
                taskName,
                style: TextStyle(
                  decoration: checkvalue
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
