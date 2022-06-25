import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';

import '../../../db/models.dart';

class ShowNodeCubit extends Cubit<Note?> {
  ShowNodeCubit() : super(null);

  void setNewNote(Note? note) {
    if (note == null) {
      title = "";
      content = Document();
    } else {
      title = note.title;
      content = note.content;
    }
    emit(note);
  }

  String? title;
  Document? content;

  bool get changed {
    return state?.title != title || state?.content != content;
  }
}
