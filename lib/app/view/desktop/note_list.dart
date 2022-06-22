import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/repository/view_sort_type.dart';
import 'package:uuid/uuid.dart';

import '../../../bloc/app_cubit.dart';
import '../../../bloc/show_node_cubit.dart';
import '../../../db/models.dart';

class NoteListWidget extends StatefulWidget {
  const NoteListWidget({Key? key}) : super(key: key);

  @override
  State<NoteListWidget> createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteListWidget> {
  final _searchController = TextEditingController();

  _clickNote(BuildContext context, ShowNodeCubit showLogic, Note note) {
    var oldNote = showLogic.state;
    if (showLogic.changed) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("提示"),
              content: const Text("文件已修改，是否保存?"),
              actions: [
                TextButton(
                  child: const Text("取消"),
                  onPressed: () {
                    showLogic.setNewNote(note);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("确定"),
                  onPressed: () async {
                    var id = oldNote?.uuid;
                    var title = showLogic.title!;
                    var content = showLogic.content!;
                    var bloc = context.read<NoteBloc>();
                    id ??= const Uuid().v4();
                    bloc.add(NotesUpdated(id, title: title, content: content));
                    var note = oldNote ??= Note.create();
                    showLogic.setNewNote(note!
                      ..uuid = id
                      ..title = title
                      ..content = content);
                    Navigator.of(context).pop();
                    bloc.refresh();
                  },
                ),
              ],
            );
          });
    } else {
      showLogic.setNewNote(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = context.watch<AppCubit>().state.primarySwatch;
    var selectedColor = primaryColor.shade300;
    var normalColor = primaryColor.shade50;
    var titleStyle = Theme.of(context).textTheme.titleMedium;
    var bodyStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontSize: 14, color: Colors.grey);
    var selectNote = context.watch<ShowNodeCubit>().state;
    var state = context.watch<NoteBloc>().state;
    appLog.debug("build note list");
    var login = context.read<ShowNodeCubit>();
    var notes = state.filteredTodos.toList();
    var book = "ALL";
    if (state.filter.notebook != null) {
      if (state.filter.notebook!.isOther) {
        book = "未分类";
      } else {
        book = state.filter.notebook!.name;
      }
    }
    return Container(
      color: normalColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //folder name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          //op toolbar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildSearch(context),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _buildCreateButton(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Total ${notes.length}"),
                const Spacer(),
                DropdownButton<ViewSortType>(
                  value: state.filter.sort,
                  onChanged: (v) {
                    context.read<NoteBloc>().add(
                          NotesFilterChanged(
                            state.filter.copyWith(sort: () => v!),
                          ),
                        );
                  },
                  underline: Container(),
                  items: <ViewSortType>[
                    ViewSortType.updatedDesc,
                    ViewSortType.updated,
                    ViewSortType.createdDesc,
                    ViewSortType.created,
                    ViewSortType.titleDesc,
                    ViewSortType.title
                  ]
                      .map<DropdownMenuItem<ViewSortType>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.getTitle(context)),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          const Divider(),
          //notes list
          notes.isEmpty
              ? const Expanded(
                  child: Center(
                    child: Text("No Notes"),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        indent: 10.0,
                        thickness: 0.0,
                        endIndent: 10.0,
                        height: 0.0,
                        color: Colors.grey.withAlpha(200),
                      );
                    },
                    controller: ScrollController(),
                    scrollDirection: Axis.vertical,
                    itemCount: notes.length,
                    itemBuilder: (ctx, index) {
                      var selected = selectNote?.uuid == notes[index].uuid;
                      return Material(
                        child: ListTile(
                          tileColor: normalColor,
                          selectedTileColor: selectedColor,
                          hoverColor: selectedColor.withAlpha(50),
                          selected: selected,
                          onTap: () {
                            _clickNote(context, login, notes[index]);
                          },
                          iconColor: titleStyle?.color,
                          leading: selected
                              ? const Icon(Icons.edit_note)
                              : const Icon(Icons.note),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                notes[index].title,
                                style: !selected
                                    ? titleStyle
                                    : titleStyle?.copyWith(
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .headline6
                                            ?.color),
                              ),
                              Text(
                                Document.fromJson(
                                  jsonDecode(notes[index].content),
                                ).toPlainText(),
                                maxLines: 3,
                                style: bodyStyle,
                              ),
                              Text(
                                "2019-08-02 11:22:03",
                                style: bodyStyle,
                              ),
                              const Divider(
                                height: 10,
                                color: Colors.transparent,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    var cubit = context.read<ShowNodeCubit>();
    return ClipOval(
      child: Material(
        color: Theme.of(context).primaryColor, // Button color
        child: InkWell(
          onTap: () {
            cubit.setNewNote(null);
          },
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
    var noteBloc = context.read<NoteBloc>();
    return BlocBuilder<NoteBloc, NotesState>(
      buildWhen: (p, c) {
        return p.filter.search != c.filter.search;
      },
      builder: (context, state) {
        return Expanded(
          child: TextField(
            controller: _searchController,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              noteBloc.setSearch(value);
            },
            onChanged: (value) {
              noteBloc.setSearch(value);
            },
            decoration: InputDecoration(
                isDense: true,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    gapPadding: 1,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                hintText: 'Input keyword to search',
                labelText: 'Search',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                prefixText: ' ',
                contentPadding: const EdgeInsets.all(1),
                suffixIcon: state.filter.search?.isNotEmpty == true
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                        ),
                        onPressed: () {
                          _searchController.text = "";
                          noteBloc.setSearch("");
                        },
                      )
                    : null),
          ),
        );
      },
    );
  }
}
