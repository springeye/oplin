import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/common/dialog.dart';
import 'package:oplin/app/view/mobile/drawer.dart';
import 'package:oplin/app/view/mobile/edit.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/common/AssetGenImage.dart';

import '../../../gen/assets.gen.dart';
import 'package:oplin/gen/S.dart';
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

  AppBar _buildAppBar(BuildContext context) {
    var selectBook = context.watch<NoteBloc>().state.filter.notebook;
    var titleStyle = Theme.of(context).appBarTheme.titleTextStyle;
    var title = S.of(context).app_name;
    if (selectBook == null) {
      title = S.of(context).all;
    } else if (selectBook.isOther) {
      title = S.of(context).other;
    } else {
      title = selectBook.name;
      title = S.of(context).notebook_by_name(title);
    }

    if (editType == EditType.note) {
      title = S.of(context).select_note_count(selected.length);
    } else if (editType == EditType.folder) {
      title = S.of(context).select_book_count(selected.length);
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
    return Scaffold(
      appBar: _buildAppBar(context),
      floatingActionButton: editType != EditType.none
          ? null
          : FloatingActionButton(
              heroTag: "create",
              onPressed: () {
                Navigator.push(
                  context,
                  AppPageRoute<EditNoteWidget>(
                    builder: (context) => const EditNoteWidget(),
                  ),
                ).then((value) =>
                    context.read<NoteBloc>().add(const NoteRefreshRequested()));
              },
              child: const Icon(Icons.add),
            ),
      drawer: editType != EditType.none ? null : buildDrawer(context),
      body: NoteList(
        key: noteListKey,
        showFolder: false,
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
      ),
    );
  }
}
