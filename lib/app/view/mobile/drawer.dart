import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oplin/app/view/mobile/build_note.dart';

// import 'package:objectbox/objectbox.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/app/view/mobile/settings.dart';
import 'package:oplin/bloc/app_cubit.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/sync_bloc.dart';
import 'package:oplin/bloc/sync_event.dart';
import 'package:oplin/bloc/sync_state.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';

import 'package:oplin/gen/S.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: BlocConsumer<SyncCubit, SyncState>(
      listener: (context, state) {
        appLog.debug(state.toString());
        if (state.type == SyncStateType.error) {
          var error = state.error;
          if (error != null) {
            EasyLoading.showToast(error);
          }
        }
      },
      builder: (context, state) {
        var books = context.watch<BookBloc>().state.filteredTodos.toList();
        var noteBloc = context.watch<NoteBloc>();
        var selectBook = noteBloc.state.filter.notebook;
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  S.of(context).settings,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                itemCount: books.length + 2,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return InkWell(
                      onTap: () {
                        noteBloc.setNotebook(null);
                        Navigator.pop(context);
                      },
                      child: buildNoteBookItem(
                          context,
                          Notebook()..name = S.of(context).all,
                          selectBook == null),
                    );
                  }
                  if (index == 1) {
                    return InkWell(
                      onTap: () {
                        noteBloc.setNotebook(Notebook.other);
                        Navigator.pop(context);
                      },
                      child: buildNoteBookItem(
                          context,
                          Notebook.other..name = S.of(context).other,
                          selectBook != null && selectBook.isOther),
                    );
                  }
                  var book = books[index - 2];
                  return InkWell(
                    onTap: () {
                      noteBloc.setNotebook(book);
                      Navigator.pop(context);
                    },
                    child: buildNoteBookItem(
                        context, book, selectBook?.uuid == book.uuid),
                  );
                },
              ),
            ),
            ListTile(
              title: Text(S.of(context).settings),
              onTap: () {
                Navigator.push(context,
                    AppPageRoute<SettingWidget>(builder: (context) {
                  return const SettingWidget();
                }));
              },
            ),
            ListTile(
              title: const Text("Sync"),
              onTap: () async {
                var config = context.read<AppCubit>().state;
                context
                    .read<SyncCubit>()
                    .add(SyncSubscriptionRequested(config.server));
              },
            ),
          ],
        );
      },
    ),
  );
}
