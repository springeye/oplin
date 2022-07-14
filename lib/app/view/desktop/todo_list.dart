import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/todos_overview_bloc.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/gen/S.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListSWState();
}

class _TodoListSWState extends State<TodoListWidget> {
  final _searchController = TextEditingController();

  Widget _buildSearch(BuildContext context) {
    var bloc = context.read<TodosOverviewBloc>();
    return BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
      buildWhen: (p, c) {
        return p.search != c.search;
      },
      builder: (context, state) {
        return TextField(
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            bloc.add(TodosOverviewSearch(value));
          },
          onChanged: (value) {
            bloc.add(TodosOverviewSearch(value));
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
                        bloc.add(TodosOverviewSearch(null));
                      },
                    )
                  : null),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      buildWhen: (p, c) {
        var book = c.filter.notebook;
        return book != null &&
            (book.isTodoUnCompleted || book.isTodoCompleted) &&
            p.filter.notebook != book;
      },
      builder: (context, state) {
        var book = state.filter.notebook;
        return Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: SizedBox(
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: ListView(
                children: [
                  Text(book?.isTodoCompleted == true ? "已完成" : "为完成"),
                  SizedBox(
                    width: 100,
                    child: _buildSearch(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
