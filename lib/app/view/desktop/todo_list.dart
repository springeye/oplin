import 'package:flutter/material.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListSWState();
}

class _TodoListSWState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: double.infinity,
        child: Text("this is todo list"),
      ),
    );
  }
}
