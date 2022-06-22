import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/mobile/dialog.dart';
import 'package:oplin/app/view/mobile/drawer.dart';
import 'package:oplin/app/view/mobile/edit.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/notebook_cubit.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/ext/AssetGenImage.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/S.dart';
import 'note_list.dart';
import 'route.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  EditType editType = EditType.none;
  List<String> selected = [];
  GlobalKey<NoteListState> noteListKey = GlobalKey();

  AppBar _buildAppBar() {
    var titleStyle = Theme.of(context).appBarTheme.titleTextStyle;
    var title = S.of(context).app_name;
    if (editType == EditType.note) {
      title = "选择了${selected.length}个笔记";
    } else if (editType == EditType.folder) {
      title = "选择了${selected.length}个笔记本";
    }
    return AppBar(
      title: Text(
        title,
        style: titleStyle,
      ),
      leading: editType != EditType.none
          ? IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                noteListKey.currentState?.exitEditModel();
              },
            )
          : null,
      actions: [
        if (editType != EditType.none)
          IconButton(
            onPressed: () {
              setState(() {
                if (selected.isNotEmpty) {
                  noteListKey.currentState?.unselectAll();
                } else {
                  noteListKey.currentState?.selectAll();
                }
              });
            },
            icon: ImageIcon(Assets.icons.multiselect.assetImage),
          ),
        if (editType == EditType.none)
          IconButton(
            onPressed: () {
              showCreateNotebookDialog(context, (name) async {
                noteListKey.currentState?.addFolder(name).then((value) {
                  Navigator.pop(context);
                });
              });
            },
            icon: const Icon(Icons.create_new_folder),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: editType != EditType.none
          ? null
          : FloatingActionButton(
              heroTag: "create",
              onPressed: () {
                Navigator.push(
                  context,
                  AppPageRoute(
                    builder: (context) => const EditNoteWidget(),
                  ),
                ).then((value) => noteListKey.currentState?.refresh());
              },
              child: const Icon(Icons.add),
            ),
      drawer: editType != EditType.none ? null : buildDrawer(context),
      body: BlocBuilder<NoteBloc, NotesState>(
        builder: (context, state) {
          return BlocBuilder<NotebookCubit, List<Notebook>>(
            builder: (context, books) {
              return NoteList(
                state.filteredTodos.toList(),
                books,
                key: noteListKey,
                modelCallback: (isEditing) {
                  setState(() {
                    editType = isEditing;
                  });
                },
                selectedCallback: (selected) {
                  setState(() {
                    this.selected = selected;
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
