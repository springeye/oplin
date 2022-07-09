import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/common/dialog.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/app/view/common/settings.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/db/models.dart';

import '../../../bloc/app_cubit.dart';
import 'package:oplin/gen/S.dart';

import 'expansion_folder.dart';

class FolderListWidget extends StatelessWidget {
  final bgColor = const Color(0xfff3f3f3);

  const FolderListWidget({Key? key}) : super(key: key);

  void onTapBook(BuildContext context, Book? book) {
    var noteLogic = context.read<NoteBloc>();
    var showLogic = context.read<EditNoteBloc>();
    var changed = showLogic.state.changed;
    var oldNote = noteLogic.state.note;
    if (changed) {
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
                    noteLogic.setNotebook(book);
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
                    context.read<BookBloc>().add(const BookRefreshRequested());
                    noteLogic.setNotebook(book);
                  },
                ),
              ],
            );
          });
    } else {
      noteLogic.setNotebook(book);
    }
  }

  List<Widget> _buildList(BuildContext context) {
    var logic = context.watch<NoteBloc>();

    var bloc = context.watch<BookBloc>();
    var state = bloc.state;
    var books = state.filteredTodos.toList();
    return books.map((book) {
      var selectBook = logic.state.filter.notebook;
      var selected = selectBook?.uuid == book.uuid;
      return _buildItem(context, book, selected, () {
        onTapBook(context, book);
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = context.watch<AppCubit>().state.primarySwatch;
    var bloc = context.watch<BookBloc>();
    var logic = context.watch<NoteBloc>();
    var book = logic.state.filter.notebook;
    var titleStyle = Theme.of(context).textTheme.bodyText2;
    return Container(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            color: bgColor,
            child: Text(
              S.of(context).notebook,
              style: Theme.of(context).primaryTextTheme.titleLarge,
            ),
          ),
          _buildItem(context, null, book == null, () {
            onTapBook(context, null);
          }),
          _buildItem(context, Book.other, book?.isOther == true, () {
            onTapBook(context, Book.other);
          }),
          ExpansionFolder(
            title: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("我的文件夹"),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  shrinkWrap: true,
                  children: [..._buildList(context)],
                ),
              ),
            ),
          ),
          _buildItem(context, Book.recycled, book?.isRecycled == true, () {
            onTapBook(context, Book.recycled);
          }),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                child: Text(S.of(context).settings),
                onTap: () {
                  Navigator.of(context)
                      .push(AppPageRoute<SettingWidget>(builder: (context) {
                    return const SettingWidget();
                  }));
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, Book? book, bool selected,
      GestureTapCallback? onTap) {
    var selectedColor = context.watch<AppCubit>().state.primarySwatch;
    var titleStyle = Theme.of(context).textTheme.bodyText2;
    var selectTitleStyle = titleStyle?.copyWith(color: selectedColor);
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 2.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        child: Material(
          child: GestureDetector(
            onSecondaryTapDown: (details) {
              if (book != null && !book.isOther && !book.isRecycled) {
                showContextMenu(context, details.globalPosition, [
                  ListTile(
                    title: Text("Delete"),
                    onTap: () {
                      context.read<BookBloc>().add(BookDeleted([book.uuid]));
                      Navigator.pop(context);
                    },
                  ),
                ]);
              }
            },
            child: ListTile(
              iconColor: titleStyle?.color,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              tileColor: bgColor,
              selectedTileColor: selectedColor.shade100,
              selected: selected,
              minLeadingWidth: 24,
              leading: selected
                  ? const Icon(Icons.folder_open)
                  : const Icon(Icons.folder),
              title: Text(
                book == null
                    ? "全部"
                    : book.isOther
                        ? "未分类"
                        : book.isRecycled
                            ? "回收站"
                            : book.name,
                style: selected ? selectTitleStyle : titleStyle,
              ),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
