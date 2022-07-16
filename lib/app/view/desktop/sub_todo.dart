import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/bloc/todo_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';

class SubTodoWidget extends StatefulWidget {
  final Todo parent;

  const SubTodoWidget({Key? key, required this.parent}) : super(key: key);

  @override
  State<SubTodoWidget> createState() => _SubTodoWidgetState();
}

class _SubTodoWidgetState extends State<SubTodoWidget> {
  final _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (v) {}),
        Expanded(
          child: FocusScope(
            onFocusChange: (hasFocus) {
              appLog.debug("子todo焦点改变 $hasFocus");
              if (!hasFocus) {
                var text = _titleController.text;
                if (text.isNotEmpty) {
                  context.read<TodoBloc>().add(
                      TodoEvent.addSubTodo(widget.parent, Todo(title: text)));
                }
              }
            },
            child: TextField(
              controller: _titleController,
            ),
          ),
        ),
      ],
    );
  }
}
