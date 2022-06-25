import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:oplin/common/logging.dart';

import '../../../db/models.dart';
import 'package:collection/collection.dart';

Function eq = const ListEquality<dynamic>().equals;

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

  String title = "";
  Document content = Document();

  bool get changed {
    appLog.debug("old title  ${state?.title}");
    appLog.debug("old content  ${state?.content.toPlainText()}");
    appLog.debug("new title  $title");
    appLog.debug("new content  ${content.toPlainText()}");
    return (state?.title ?? "") != title ||
        !eq((state?.content ?? Document()).toDelta().toJson(),
            content.toDelta().toJson());
  }
}
