import 'package:flutter/material.dart';
import 'package:todo_list_project/constants/colors.dart';
import '../model/Todo.dart';

class ToDoItem extends StatelessWidget {
  final Todo obj;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {super.key,
      required this.obj,
      required this.onToDoChanged,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        onTap: () {
          onToDoChanged(this.obj);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            onToDoChanged(this.obj);
          },
          icon: Icon((obj.isDone != null && obj.isDone == true)
              ? Icons.check_box
              : Icons.check_box_outline_blank),
          color: tdBlue,
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          width: 35,
          height: 35,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: tdRed),
          child: IconButton(
            iconSize: 18,
            icon: Icon(Icons.delete),
            color: Colors.white,
            onPressed: () {
              onDeleteItem(obj.id);
            },
          ),
        ),
        title: Text(
          obj.task.toString(),
          style: TextStyle(
              fontSize: 20,
              color: tdBlack,
              decoration: obj.isDone!
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
      ),
    );
  }
}
