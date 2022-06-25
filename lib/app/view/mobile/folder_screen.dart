import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/mobile/edit.dart';
import 'package:oplin/app/view/mobile/note_list.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/common/AssetGenImage.dart';
import 'package:oplin/repository/note_repository.dart';

import '../../../gen/assets.gen.dart';
import 'package:oplin/gen/S.dart';

class FolderScreenWidget extends StatefulWidget {
  final Notebook book;

  const FolderScreenWidget({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FolderScreenWidgetState();
  }
}

class _FolderScreenWidgetState extends State<FolderScreenWidget> {
  GlobalKey<NoteListState> noteListKey = GlobalKey();
  EditType editType = EditType.none;
  List<String> selected = [];

  AppBar _buildAppBar(BuildContext context) {
    var titleStyle = Theme.of(context).appBarTheme.titleTextStyle;
    var title = S.of(context).notebook_by_name(widget.book.name);
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var repository = context.read<NoteRepository>();
    var bookBloc = context.read<BookBloc>();
    return BlocProvider<NoteBloc>(
      create: (context) {
        return NoteBloc(noteRepository: repository, bookBloc: bookBloc)
          ..setNotebook(widget.book);
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<NoteBloc, NotesState>(
          builder: (context, state) {
            return NoteList(
              notebook: widget.book,
              key: noteListKey,
              showFolder: false,
              modelCallback: (editType) {
                setState(() {
                  this.editType = editType;
                });
              },
              selectedCallback: (selected) {
                setState(() {
                  this.selected = selected;
                });
              },
            );
          },
        ),
        floatingActionButton: editType != EditType.none
            ? null
            : FloatingActionButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    AppPageRoute<EditNoteWidget>(
                      builder: (context) => EditNoteWidget(
                        book: widget.book,
                      ),
                    ),
                  ).then((value) => context
                      .read<NoteBloc>()
                      .add(const NotesSubscriptionRequested()));
                },
                child: const Icon(Icons.add),
              ),
      ),
    );
  }
}
