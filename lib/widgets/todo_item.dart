import 'package:flutter/material.dart';
import 'package:my_todo/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final TODO todoItem;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem({
    super.key,
    required this.todoItem,
    required this.onToDoChanged,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todoItem);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.white,
        leading: Icon(
          todoItem.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blueAccent,
          size: 25,
        ),
        trailing: Container(
          height: 35,
          width: 35,
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            iconSize: 20,
            onPressed: () {
              onDeleteItem(todoItem.id);
            },
          ),
        ),
        title: Text(
          todoItem.todoText!,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            decoration: todoItem.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
