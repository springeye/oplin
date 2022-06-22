import 'package:bloc/bloc.dart';

import '../../../db/models.dart';

class ShowNodeCubit extends Cubit<Note?> {
  ShowNodeCubit() : super(null);

  void setNewNote(Note? note) {
    title = note?.title;
    content = note?.content;
    emit(note);
  }

  String? title;
  String? content;

  bool get changed {
    return state?.title != title || state?.content != content;
  }
}
