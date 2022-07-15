import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/bloc/todo.edit.bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';

class TodoEdit extends StatefulWidget {
  final Todo todo;

  const TodoEdit({Key? key, required this.todo}) : super(key: key);

  @override
  State<TodoEdit> createState() => _TodoEditState();
}

class _TodoEditState extends State<TodoEdit> {
  Widget _buildNormalTodo(BuildContext context) {
    var bloc = context.watch<TodoEditBloc>();
    var state = bloc.state;
    var isEdited = state.initialTodo == widget.todo;
    return Container(
      color: Colors.red,
      child: GestureDetector(
        onTap: () {
          if (!isEdited) {
            bloc.add(TodoEditEvent.current(widget.todo));
          }
        },
        child: Text(widget.todo.uuid),
      ),
    );
  }

  Widget _buildEditTodo(BuildContext context) {
    final titleController = TextEditingController(text: widget.todo.title);
    return Focus(
      onFocusChange: (hasFocus) {
        if (!hasFocus) {
          context
              .read<TodoEditBloc>()
              .add(TodoEditEvent.titleChanged(titleController.text));
          context.read<TodoEditBloc>().add(const TodoEditEvent.submitted());
        }
      },
      child: TextField(
        controller: titleController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var isEdited =
        context.watch<TodoEditBloc>().state.initialTodo == widget.todo;
    if (isEdited) {
      return _buildEditTodo(context);
    } else {
      return _buildNormalTodo(context);
    }
  }
}
