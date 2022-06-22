import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/app/view/mobile/settings.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/show_node_cubit.dart';
import 'package:oplin/db/models.dart';

import '../../../bloc/app_cubit.dart';

class FolderListWidget extends StatelessWidget {
  const FolderListWidget({Key? key}) : super(key: key);

  void onTapBook(BuildContext context, Notebook? book) {
    var noteLogic = context.read<NoteBloc>();
    var showLogic = context.read<ShowNodeCubit>();
    var oldNote = showLogic.state;
    if (showLogic.changed) {
      showDialog<AlertDialog>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("提示"),
              content: const Text("文件已修改，是否保存?"),
              actions: [
                TextButton(
                  child: const Text("取消"),
                  onPressed: () {
                    noteLogic.setNotebook(book);
                    showLogic.setNewNote(null);
                  },
                ),
                TextButton(
                  child: const Text("确定"),
                  onPressed: () async {
                    var id = oldNote?.uuid;
                    var title = showLogic.title!;
                    var content = showLogic.content!;
                    context
                        .read<NoteBloc>()
                        .add(NotesUpdated(id!, title: title, content: content));
                    showLogic.setNewNote(showLogic.state!
                      ..title = title
                      ..content = content);
                    Navigator.of(context).pop();
                    context
                        .read<BookBloc>()
                        .add(const BookSubscriptionRequested());
                    noteLogic.setNotebook(book);
                  },
                ),
              ],
            );
          });
    } else {
      noteLogic.setNotebook(book);
      showLogic.setNewNote(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    var primaryColor = context.watch<AppCubit>().state.primarySwatch;
    var normalColor = primaryColor.shade50;
    var logic = context.watch<NoteBloc>();
    return BlocBuilder<BookBloc, BooksState>(
      builder: (context, state) {
        var books = state.filteredTodos.toList();
        return Container(
          color: normalColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                color: primaryColor.shade500,
                child: Text(
                  "笔记本",
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
                      return _buildItem(context, Notebook.other, selected, () {
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
                      child: const Text("设置"),
                      onTap: () {
                        Navigator.of(context).push(
                            AppPageRoute<SettingWidget>(builder: (context) {
                          return const SettingWidget();
                        }));
                      }),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, Notebook? book, bool selected,
      GestureTapCallback? onTap) {
    var primaryColor = context.watch<AppCubit>().state.primarySwatch;
    var selectedColor = primaryColor.shade300;
    var titleStyle = Theme.of(context).textTheme.bodyText2;
    var normalColor = primaryColor.shade50;
    return Material(
      child: ListTile(
        iconColor: titleStyle?.color,
        tileColor: normalColor,
        selectedTileColor: selectedColor,
        hoverColor: selectedColor.withAlpha(50),
        selected: selected,
        leading:
            selected ? const Icon(Icons.folder_open) : const Icon(Icons.folder),
        title: Text(
          (book != null && book.isOther) ? "Other" : book?.name ?? "All",
          style: !selected
              ? titleStyle
              : titleStyle?.copyWith(
                  color: Theme.of(context).primaryTextTheme.headline6?.color),
        ),
        onTap: onTap,
      ),
    );
  }
}
