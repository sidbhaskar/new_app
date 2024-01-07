import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

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
      padding: EdgeInsets.all(4),
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Checkbox(
                  activeColor: Color.fromARGB(225, 173, 186, 235),
                  shape: CircleBorder(),
                  value: checkvalue,
                  onChanged: onChanged,
                ),
                Text(taskName,
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      decoration: checkvalue
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
