import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/dialog.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/repository/view_sort_type.dart';

import '../../../bloc/app_cubit.dart';
import '../../../db/models.dart';
import 'package:oplin/gen/S.dart';

class NoteListWidget extends StatefulWidget {
  const NoteListWidget({Key? key}) : super(key: key);

  @override
  State<NoteListWidget> createState() => _NoteListWidgetState();
}

class _NoteListWidgetState extends State<NoteListWidget> {
  final _searchController = TextEditingController();

  void _clickNote(BuildContext context, EditNoteBloc showLogic, Note note) {
    var state = showLogic.state;
    var noteLogic = context.read<NoteBloc>();
    var oldNote = noteLogic.state.note;
    if (state.changed) {
      showDialog<AlertDialog>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(S.of(context).tips),
              content: Text(S.of(context).save_message),
              actions: [
                TextButton(
                  child: Text(S.of(context).cancel),
                  onPressed: () {
                    noteLogic.add(ShowNewNoteEvent(note));
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(S.of(context).ok),
                  onPressed: () async {
                    var id = oldNote?.uuid;
                    var title = showLogic.state.editTitle;
                    var content = showLogic.state.editDocument;
                    context.read<NoteBloc>().add(
                        NotesUpdated(uuid: id, title: title, content: content));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } else {
      noteLogic.add(ShowNewNoteEvent(note));
    }
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = context.watch<AppCubit>().state.primarySwatch;
    var selectedColor = primaryColor.shade50;
    var titleStyle = Theme.of(context).textTheme.titleMedium;
    var bodyStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(fontSize: 14, color: Colors.grey);
    var state = context.watch<NoteBloc>().state;
    var selectNote = state.note;
    var logic = context.read<EditNoteBloc>();
    var notes = state.filteredTodos.toList();
    var book = S.of(context).all;
    if (state.filter.notebook != null) {
      if (state.filter.notebook!.isOther) {
        book = S.of(context).other;
      } else {
        book = state.filter.notebook!.name;
      }
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: Colors.white,
          // padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //folder name
              Container(
                padding: const EdgeInsets.all(8.0),
                height: 40,
                alignment: Alignment.center,
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
                    Text(S.of(context).total_notes(notes.length)),
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
              const Divider(
                height: 1,
              ),
              //notes list
              notes.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(S.of(context).empty_notes),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            indent: 0.0,
                            thickness: 0.0,
                            endIndent: 0.0,
                            height: 0.0,
                            color: Colors.grey.withAlpha(200),
                          );
                        },
                        controller: ScrollController(),
                        scrollDirection: Axis.vertical,
                        itemCount: notes.length,
                        itemBuilder: (ctx, index) {
                          var selected = selectNote?.uuid == notes[index].uuid;
                          return GestureDetector(
                            onSecondaryTapDown: (details) {
                              var note = notes[index];
                              showContextMenu(context, details.globalPosition, [
                                ListTile(
                                  title: Text("Delete"),
                                  onTap: () {
                                    context
                                        .read<NoteBloc>()
                                        .add(NoteDeleted([note.uuid]));
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: Text("Move"),
                                  onTap: () {
                                    Navigator.pop(context);
                                    var notebookLogic =
                                        context.read<BookBloc>();
                                    var noteLogic = context.read<NoteBloc>();
                                    showMoveToFolderDialog(context,
                                        onCreatePressed: () {
                                      showCreateNotebookDialog(context, (name) {
                                        notebookLogic
                                            .add(BookAdded(name: name));
                                        Navigator.pop(context);
                                      });
                                    }, onNotebookPressed: (Book? notebook) {
                                      noteLogic.add(NotesMoved(
                                          [notes[index].uuid], notebook?.uuid));
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ]);
                            },
                            child: Material(
                              child: ListTile(
                                selectedTileColor: selectedColor,
                                hoverColor: selectedColor.withAlpha(50),
                                selected: selected,
                                onTap: () {
                                  _clickNote(context, logic, notes[index]);
                                },
                                iconColor: titleStyle?.color,
                                trailing:
                                    selected ? Icon(Icons.more_vert) : null,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      notes[index].title,
                                      style:
                                          !selected ? titleStyle : titleStyle,
                                    ),
                                    Text(
                                      notes[index].content.toPlainText(),
                                      maxLines: 3,
                                      style: bodyStyle,
                                    ),
                                    Text(
                                      S.of(context).datetime_format(
                                          notes[index].updateTime),
                                      style: bodyStyle,
                                    ),
                                    const Divider(
                                      height: 10,
                                      color: Colors.transparent,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    var bloc = context.read<NoteBloc>();
    return ClipOval(
      child: Material(
        color: Theme.of(context).primaryColor, // Button color
        child: InkWell(
          onTap: () {
            bloc.add(const ShowNewNoteEvent(null));
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
    return BlocBuilder<NoteBloc, NoteState>(
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
                hintText: S.of(context).hint_enter_search,
                labelText: S.of(context).search,
                prefixIcon: const Icon(
                  Icons.search,
                ),
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
