import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/app/view/common/dialog.dart';
import 'package:oplin/app/view/desktop/folder_list.dart';
import 'package:oplin/app/view/desktop/note_edit.dart';
import 'package:oplin/app/view/desktop/note_list.dart';
import 'package:oplin/app/view/desktop/vertical_splite_view.dart';
import 'package:oplin/app/view/mobile/route.dart';
import 'package:oplin/app/view/common/settings.dart';
import 'package:oplin/bloc/app_cubit.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/gen/S.dart';

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({Key? key}) : super(key: key);

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  LayoutWidgetBuilder divider =
      (BuildContext context, BoxConstraints constraints) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.only(top: 15),
      width: 2,
      child: Container(
        color: Colors.transparent,
      ),
    );
  };

  @override
  Widget build(BuildContext context) {
    var appConfig = context.watch<AppCubit>().state;
    var noteBloc = context.read<NoteBloc>();
    noteBloc.add(const NoteRefreshRequested());
    context.read<BookBloc>().add(const BookRefreshRequested());
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 30),
            ),
            Spacer(),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              Row(
                children: const [
                  SizedBox(
                    width: 250,
                    child: FolderListWidget(),
                  ),
                  SizedBox(
                    width: 300,
                    child: NoteListWidget(),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(right: 8.0, left: 10),
                    child: NoteEditWidget(),
                  ))
                ],
              ),
              BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  return state.selected.isEmpty
                      ? Container()
                      : Container(
                          color: appConfig.primarySwatch,
                          child: _editToolBar(context),
                        );
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _editToolBar(BuildContext context) {
    var bloc = context.read<NoteBloc>();
    var selected = bloc.state.selected;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      height: 45,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              bloc.add(const ClearSelectNote());
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          Text(
            S.of(context).select_note_count(selected.length),
            style: const TextStyle(color: Colors.white),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showMoveToFolderDialog(context, onCreatePressed: () {},
                  onNotebookPressed: (notebook) {
                bloc.add(NotesMoved(
                    selected.map((e) => e.uuid).toList(), notebook?.uuid));
                bloc.add(const ClearSelectNote());
                Navigator.pop(context);
              });
            },
            icon: const Icon(
              Icons.move_to_inbox,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              bloc.add(NoteDeleted(selected.map((e) => e.uuid).toList()));
              bloc.add(const ClearSelectNote());
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
