import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:oplin/bloc/app_cubit.dart';
import 'package:oplin/bloc/todo.edit.bloc.dart';
import 'package:oplin/bloc/todo_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';

class TodoEdit extends StatefulWidget {
  final Todo todo;
  final bool isEditing;

  const TodoEdit({Key? key, required this.todo, required this.isEditing})
      : super(key: key);

  @override
  State<TodoEdit> createState() => _TodoEditState();
}

class _TodoEditState extends State<TodoEdit> {
  final _titleController = TextEditingController();
  final _focusNode = FocusNode();

  Widget _buildNormalTodo(BuildContext context) {
    var todo = widget.todo;
    return Container(
      child: Text(
        todo.title.isEmpty ? "请输入标题" : todo.title,
        style: TextStyle(
          color: todo.isCompleted ? Colors.grey : null,
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          decorationColor: Colors.grey,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    var bloc = context.read<TodoEditBloc>();
    _titleController.addListener(() {
      appLog.debug("titleController.text: ${_titleController.text}");
      bloc.add(TodoEditEvent.titleChanged(_titleController.text));
    });
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        var bloc = context.read<TodoEditBloc>();
        bloc.add(const TodoEditEvent.submitted());
        bloc.add(const TodoEditEvent.current(null));
      }
    });
  }

  @override
  dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Widget _buildEditTodo(BuildContext context) {
    // var bloc = context.read<TodoEditBloc>();
    // var state = bloc.state;
    var text = widget.todo.title;
    appLog.debug("_buildEditTodo: title=> $text");
    _titleController.text = text;
    _focusNode.requestFocus();
    return FocusScope(
      onFocusChange: (has) {
        appLog.debug("_buildEditTodo: onFocusChange: $has");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            focusNode: _focusNode,
            controller: _titleController,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.symmetric(vertical: 6.0),
              border: InputBorder.none,
              hintText: "请输入标题",
            ),
          ),
          TextButton.icon(
              style:
                  TextButton.styleFrom(primary: Colors.black.withOpacity(0.65)),
              onPressed: () {
                DatePicker.showDateTimePicker(context);
              },
              icon: const Icon(Icons.alarm),
              label: const Text("设置提醒"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MaterialColor primarySwatch = context.select<AppCubit, MaterialColor>(
        (config) => config.state.primarySwatch);
    var todo = widget.todo;
    var isEditing = widget.isEditing;
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isEditing ? primarySwatch : Colors.grey.withAlpha(100),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment:
              isEditing ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Checkbox(
                value: todo.isCompleted,
                fillColor: MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.orange.withOpacity(.32);
                  }
                  if (states.contains(MaterialState.selected)) {
                    return Colors.grey;
                  }
                  return null;
                }),
                onChanged: (v) {
                  context
                      .read<TodoBloc>()
                      .add(TodoEvent.completionToggled(todo, v == true));
                }),
            Expanded(
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    var isEditing = widget.isEditing;
    if (isEditing) {
      return _buildEditTodo(context);
    }
    return _buildNormalTodo(context);
  }
}
