import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/mobile/edit.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/notebook_cubit.dart';
import 'package:oplin/ext/AssetGenImage.dart';
import 'package:oplin/gen/assets.gen.dart';

import '../../../common/utils.dart';
import '../../../db/models.dart';
import '../../../l10n/S.dart';
import 'build_note.dart';
import 'card_item_draggable.dart';
import 'card_item_target.dart';
import 'dialog.dart';
import 'folder.dart';

class NoteList extends StatefulWidget {
  final Notebook? notebook;
  final Function(EditType editType)? modelCallback;
  final Function(List<String> selected)? selectedCallback;
  final List<Note> notes;
  final List<Notebook> books;

  const NoteList(
    this.notes,
    this.books, {
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
    var read = context.read<NotebookCubit>();
    await read.add(name);
    await read.list("");
  }

  Future<void> refresh() async {
    await context.read<NotebookCubit>().refresh();
  }

  @override
  void initState() {
    super.initState();
    refresh();
    context.read<NoteBloc>().add(const NotesSubscriptionRequested());
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = buildListView(context);
    listView = RefreshIndicator(
        child: listView,
        onRefresh: () async {
          refresh();
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

  buildListView(BuildContext context) {
    List items = [...widget.books];
    items.addAll(widget.notes);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var e = items[index];
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
                  AppPageRoute(builder: (context) {
                    return EditNoteWidget(
                      note: e,
                    );
                  }),
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
                  AppPageRoute(builder: (context) {
                    return FolderWidget(
                      book: e,
                    );
                  }),
                ).then((value) {
                  refresh();
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
                    Expanded(child: _buildNoteBookItem(e, hover)),
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
    );
  }

  Widget _buildNoteBookItem(Notebook book, bool opened) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
      child: Row(
        children: [
          Icon(
            opened ? Icons.folder_open : Icons.folder,
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              book.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 22),
            ),
          ),
          //folder name
          const Spacer(),
          Text("${book.count}"),
          // notes count in folder
        ],
      ),
    );
  }

  Widget _buildBottomBar(Widget listView) {
    var noteLogic = context.read<NoteBloc>();
    var notebookLogic = context.read<NotebookCubit>();
    return Column(
      children: [
        Expanded(child: listView),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          color: Theme.of(context).bottomAppBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (false)
                IconButton(
                  onPressed: () {},
                  icon: const ImageIcon(AssetImage("icons/lock.png")),
                ),
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
                    await notebookLogic.delete(selected);
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
                    showMoveToFolderDialog(context, notebooks: widget.books,
                        onCreatePressed: () {
                      showCreateNotebookDialog(context, (name) async {
                        var notebook = await notebookLogic.add(name);
                        noteLogic.add(NotesMoved(selected, notebook.uuid));
                        exitEditModel();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    }, onNotebookPressed: (Notebook? notebook) async {
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

  exitEditModel() {
    setState(() {
      editType = EditType.none;
      selected.clear();
    });
    widget.modelCallback?.call(editType);
    widget.selectedCallback?.call(selected);
    print("refresh");
    refresh();
  }

  void unselectAll() {
    setState(() {
      selected.clear();
    });
    widget.selectedCallback?.call(selected);
  }

  void selectAll() {
    setState(() {
      if (editType == EditType.note) {
        var notes = widget.notes;
        selected.addAll(notes.map((e) => e.uuid));
      } else if (editType == EditType.folder) {
        var notes = widget.notes;
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
