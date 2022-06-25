import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/mobile/edit.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/common/AssetGenImage.dart';
import 'package:oplin/gen/assets.gen.dart';

import '../../../common/utils.dart';
import '../../../db/models.dart';
import 'package:oplin/gen/S.dart';
import 'build_note.dart';
import 'card_item_draggable.dart';
import 'card_item_target.dart';
import 'dialog.dart';
import 'folder_screen.dart';

class NoteList extends StatefulWidget {
  final Notebook? notebook;
  final Function(EditType editType)? modelCallback;
  final Function(List<String> selected)? selectedCallback;
  final bool showFolder;

  const NoteList({
    required this.showFolder,
    Key? key,
    this.modelCallback,
    this.selectedCallback,
    this.notebook,
  }) : super(key: key);

  @override
  State<NoteList> createState() => NoteListState();
}

enum EditType {
  note,
  folder,
  none,
}

class NoteListState extends State<NoteList> {
  EditType editType = EditType.none;
  List<String> selected = [];

  Future<void> addFolder(String name) async {
    BookBloc read = context.read<BookBloc>();
    read.add(BookAdded(name: name));
  }

  Future<void> _refresh() async {
    // context.read<BookBloc>().add(const BookSubscriptionRequested());
    context.read<NoteBloc>().add(const NotesSubscriptionRequested());
  }

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = buildListView(context);
    listView = RefreshIndicator(
        child: listView,
        onRefresh: () async {
          _refresh();
          // await Future.delayed(const Duration(seconds: 3), () {});
        });
    return WillPopScope(
      onWillPop: () {
        if (editType != EditType.none) {
          exitEditModel();
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: editType == EditType.none ? listView : _buildBottomBar(listView),
    );
  }

  ListView buildListView(BuildContext context) {
    var notes = context.watch<NoteBloc>().state.filteredTodos.toList();
    List<Notebook> books = widget.showFolder
        ? context.watch<BookBloc>().state.filteredTodos.toList()
        : [];
    List<dynamic> items = <dynamic>[...books];
    items.addAll(notes);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        dynamic e = items[index];
        Widget item;
        if (e is Note) {
          //笔记
          item = GestureDetector(
            onTap: () async {
              if (editType == EditType.note) {
                setState(() {
                  if (selected.contains(e.uuid)) {
                    selected.remove(e.uuid);
                  } else {
                    selected.add(e.uuid);
                  }
                });
                widget.selectedCallback?.call(selected);
              } else if (editType == EditType.none) {
                await Navigator.push(
                  context,
                  AppPageRoute<EditNoteWidget>(
                    builder: (context) {
                      return EditNoteWidget(
                        note: e,
                      );
                    },
                  ),
                );

                exitEditModel();
              }
            },
            child: DraggableCard(
              color: e.sticky
                  ? getSwatch(Theme.of(context).cardColor)
                      .shade600
                      .withAlpha(40)
                  : null,
              enabled: true,
              data: e,
              child: Row(
                children: [
                  Expanded(child: buildNoteItem(context, e)),
                  if (editType == EditType.note)
                    Checkbox(
                        value: selected.contains(e.uuid), onChanged: (val) {})
                ],
              ),
              onDragEnd: (DraggableDetails details) {},
              onDragStarted: () {
                setState(() {
                  editType = EditType.note;
                  selected.add(e.uuid);
                });
                widget.modelCallback?.call(editType);
                widget.selectedCallback?.call(selected);
              },
            ),
          );
        } else {
          ////笔记本
          item = GestureDetector(
            onLongPress: () {
              setState(() {
                editType = EditType.folder;
                selected.add(e.uuid);
              });
              widget.modelCallback?.call(editType);
              widget.selectedCallback?.call(selected);
            },
            onTap: () async {
              if (editType == EditType.folder) {
                setState(() {
                  if (selected.contains(e.uuid)) {
                    selected.remove(e.uuid);
                  } else {
                    selected.add(e.uuid);
                  }
                });
                widget.selectedCallback?.call(selected);
              } else if (editType == EditType.none) {
                await Navigator.push(
                  context,
                  AppPageRoute<FolderScreenWidget>(builder: (context) {
                    return FolderScreenWidget(
                      book: e,
                    );
                  }),
                ).then((value) {
                  _refresh();
                });
                exitEditModel();
              }
            },
            child: TargetCard<Notebook, Note>(
              color: e.sticky
                  ? getSwatch(Theme.of(context).cardColor)
                      .shade600
                      .withAlpha(40)
                  : null,
              target: e,
              callback: (Notebook target, Note data) async {
                var logic = context.read<NoteBloc>();
                logic.add(NotesMoved([data.uuid], target.uuid));
                exitEditModel();
              },
              builder: (context, hover) {
                return Row(
                  children: [
                    Expanded(child: buildNoteBookItem(context, e, hover)),
                    if (editType == EditType.folder)
                      Checkbox(
                          value: selected.contains(e.uuid), onChanged: (val) {})
                  ],
                );
              },
            ),
          );
        }
        if (index == 0) {
          item = Padding(
            padding: const EdgeInsets.only(top: 10),
            child: item,
          );
        }
        return Stack(
          children: [
            item,
            Positioned.fill(
              right: 25,
              top: 20,
              child: Align(
                alignment: Alignment.topRight,
                widthFactor: 1.0,
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )
          ],
        );
      },
    ); // NON-NLS // NON-NLS
  }

  Widget _buildBottomBar(Widget listView) {
    var noteLogic = context.read<NoteBloc>();
    var notebookLogic = context.watch<BookBloc>();
    return Column(
      children: [
        Expanded(child: listView),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          color: Theme.of(context).bottomAppBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomButtonItem(
                context: context,
                onPressed: () async {
                  noteLogic.add(NotesSticky(selected));
                  setState(() {
                    selected.clear();
                  });
                  widget.selectedCallback?.call(selected);
                  exitEditModel();
                },
                icon: ImageIcon(Assets.icons.top.assetImage),
                label: Text(S.of(context).sticky),
              ),
              _bottomButtonItem(
                onPressed: () async {
                  if (editType == EditType.note) {
                    noteLogic.add(NotesNoteDeleted(selected));
                    exitEditModel();
                  } else if (editType == EditType.folder) {
                    notebookLogic.add(BookDeleted(selected));
                    exitEditModel();
                  }
                  setState(() {
                    selected.clear();
                  });
                  widget.selectedCallback?.call(selected);
                },
                icon: ImageIcon(Assets.icons.delete.assetImage),
                label: Text(S.of(context).delete),
                context: context,
              ),
              if (editType == EditType.note)
                _bottomButtonItem(
                  context: context,
                  onPressed: () {
                    showMoveToFolderDialog(context, onCreatePressed: () {
                      showCreateNotebookDialog(context, (name) {
                        notebookLogic.add(BookAdded(name: name));
                        Navigator.pop(context);
                      });
                    }, onNotebookPressed: (Notebook? notebook) {
                      noteLogic.add(NotesMoved(selected, notebook?.uuid));
                      exitEditModel();
                      Navigator.pop(context);
                    });
                  },
                  icon: ImageIcon(Assets.icons.move.assetImage),
                  label: Text(S.of(context).move_to),
                ),
            ],
          ),
        )
      ],
    );
  }

  void exitEditModel() {
    setState(() {
      editType = EditType.none;
      selected.clear();
    });
    widget.modelCallback?.call(editType);
    widget.selectedCallback?.call(selected);
    _refresh();
  }

  void unselectAll() {
    setState(() {
      selected.clear();
    });
    widget.selectedCallback?.call(selected);
  }

  void selectAll() {
    var notes = context.read<NoteBloc>().state.filteredTodos.toList();
    setState(() {
      if (editType == EditType.note) {
        selected.addAll(notes.map((e) => e.uuid));
      } else if (editType == EditType.folder) {
        selected.addAll(notes.map((e) => e.uuid));
      }
    });
    widget.selectedCallback?.call(selected);
  }

  Widget _bottomButtonItem(
      {required BuildContext context,
      VoidCallback? onPressed,
      required Widget icon,
      required Widget label}) {
    return GestureDetector(
      onTap: () {
        onPressed?.call();
      },
      child: Padding(
        padding: EdgeInsets.only(
            top: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          children: [icon, label],
        ),
      ),
    );
  }
}
