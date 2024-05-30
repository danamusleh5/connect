import 'package:flutter/material.dart';
import 'ToDo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onToDoChanged;
  final Function(String) onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: todo.isDone ? Colors.deepPurple : Colors.grey,
            ),
            onPressed: () {
              onToDoChanged(todo);
            },
          ),
          SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: todo.isDone ? Colors.grey.shade300 : Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.todoText,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: todo.isDone ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      Text(
                        'Priority: ${todo.priority}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.deepPurple),
                    onPressed: () {
                      onDeleteItem(todo.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
