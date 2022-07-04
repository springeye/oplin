import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/app/view/mobile/settings.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/db/models.dart';

import '../../../bloc/app_cubit.dart';
import 'package:oplin/gen/S.dart';

class FolderListWidget extends StatelessWidget {
  const FolderListWidget({Key? key}) : super(key: key);

  void onTapBook(BuildContext context, Notebook? book) {
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

  @override
  Widget build(BuildContext context) {
    var primaryColor = context.watch<AppCubit>().state.primarySwatch;
    var logic = context.watch<NoteBloc>();
    return BlocBuilder<BookBloc, BooksState>(
      builder: (context, state) {
        var books = state.filteredTodos.toList();
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  color: primaryColor.shade500,
                  child: Text(
                    S.of(context).notebook,
                    style: Theme.of(context).primaryTextTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    controller: ScrollController(),
                    scrollDirection: Axis.vertical,
                    itemCount: books.length + 2,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        indent: 0.0,
                        thickness: 0.0,
                        height: 1.0,
                      );
                    },
                    itemBuilder: (ctx, index) {
                      var book = logic.state.filter.notebook;
                      if (index == 0) {
                        var selected = book == null;
                        return _buildItem(context, null, selected, () {
                          onTapBook(context, null);
                        });
                      }
                      if (index == 1) {
                        var selected = book != null && book.isOther;
                        return _buildItem(context, Notebook.other, selected,
                            () {
                          onTapBook(context, Notebook.other);
                        });
                      } else {
                        var selected = book?.uuid == books[index - 2].uuid;
                        return _buildItem(context, books[index - 2], selected,
                            () {
                          onTapBook(context, books[index - 2]);
                        });
                      }
                    },
                  ),
                ),
                if (Theme.of(context).platform != TargetPlatform.macOS)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        child: Text(S.of(context).settings),
                        onTap: () {
                          Navigator.of(context).push(
                              AppPageRoute<SettingWidget>(builder: (context) {
                            return const SettingWidget();
                          }));
                        }),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, Notebook? book, bool selected,
      GestureTapCallback? onTap) {
    var primaryColor = context.watch<AppCubit>().state.primarySwatch;
    var selectedColor = primaryColor.shade50;
    var titleStyle = Theme.of(context).textTheme.bodyText2;
    return Material(
      child: ListTile(
        iconColor: titleStyle?.color,
        selectedTileColor: selectedColor,
        hoverColor: selectedColor.withAlpha(50),
        selected: selected,
        minLeadingWidth: 24,
        leading:
            selected ? const Icon(Icons.folder_open) : const Icon(Icons.folder),
        title: Text(
          (book != null && book.isOther)
              ? S.of(context).other
              : book?.name ?? S.of(context).all,
          style: !selected ? titleStyle : titleStyle,
        ),
        onTap: onTap,
      ),
    );
  }
}
