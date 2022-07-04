import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/db/models.dart';

import 'view/desktop/home.dart';
import 'view/mobile/home.dart';
import 'window.dart';

export 'view/app.dart'; // NON-NLS

Widget buildMainWindow(BuildContext context) {
  var targetPlatform = Theme.of(context).platform;
  if (targetPlatform == TargetPlatform.android ||
      targetPlatform == TargetPlatform.iOS) {
    var bloc = context.read<NoteBloc>();
    //If on a mobile device, just show the notebookId null note
    bloc.add(
      NotesFilterChanged(
        bloc.state.filter.copyWith(notebook: () => Notebook.other),
      ),
    );
    return const MobileHomePage();
  } else {
    return const DesktopWindow(child: DesktopHomePage());
  }
}
