import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/desktop/todo_edit.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/todo.edit.bloc.dart';
import 'package:oplin/bloc/todo_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/gen/S.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListSWState();
}

class _TodoListSWState extends State<TodoListWidget> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(const TodoEvent.subscriptionRequested());
  }

  Widget _buildCreateButton(BuildContext context) {
    var bloc = context.read<TodoEditBloc>();
    return ClipOval(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: IconButton(
          tooltip: "创建",
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            bloc.add(const TodoEditEvent.created());
          },
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    var bloc = context.read<TodoBloc>();
    return BlocBuilder<TodoBloc, TodoState>(
      buildWhen: (p, c) {
        return p.search != c.search;
      },
      builder: (context, state) {
        return TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            bloc.add(TodoEvent.search(value));
          },
          onChanged: (value) {
            bloc.add(TodoEvent.search(value));
          },
          decoration: InputDecoration(
            isDense: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                gapPadding: 1,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            hintText: S.of(context).hint_enter_search,
            labelText: S.of(context).search,
            prefixIcon: const Icon(
              Icons.search,
            ),
            contentPadding: const EdgeInsets.all(1),
            suffixIcon: state.search?.isNotEmpty == true
                ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                    ),
                    onPressed: () {
                      _searchController.text = "";
                      bloc.add(const TodoEvent.search(null));
                    },
                  )
                : null,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      buildWhen: (p, c) {
        var book = c.filter.notebook;
        return book != null && (book.isTodo) && p.filter.notebook != book;
      },
      builder: (context, state) {
        var book = state.filter.notebook;
        var todos = context.watch<TodoBloc>().state.filteredTodos;
        appLog.debug("刷新todos");
        if (book != null && book.isTodoAll == false) {
          todos = todos
              .where((element) =>
                  (book.isTodoCompleted == true &&
                      element.isCompleted == true) ||
                  book.isTodoCompleted == false && element.isCompleted == false)
              .toList();
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book?.isTodoCompleted == true
                          ? "已完成"
                          : book?.isTodoUnCompleted == true
                              ? "未完成"
                              : "全部",
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 240,
                            child: _buildSearch(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: _buildCreateButton(context),
                          )
                        ],
                      ),
                    ),
                    ...todos.map((e) {
                      return InkWell(
                        onTap: () {
                          var bloc = context.read<TodoEditBloc>();
                          bloc.add(const TodoEditEvent.submitted());
                          // bloc.add(const TodoEditEvent.current(null));
                          bloc.add(TodoEditEvent.current(e));
                        },
                        child: _buildTodo(context, e),
                      );
                    }).toList()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTodo(BuildContext context, Todo todo) {
    return BlocBuilder<TodoEditBloc, TodoEditState>(
      buildWhen: (p, c) => p.initialTodo?.uuid != c.initialTodo?.uuid,
      builder: (context, state) {
        return TodoEdit(
          todo: todo,
          isEditing: state.initialTodo?.uuid == todo.uuid,
        );
      },
    );
  }
}
