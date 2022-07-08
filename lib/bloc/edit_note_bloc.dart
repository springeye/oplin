import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:injectable/injectable.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';

part 'edit_note_event.dart';

part 'edit_note_state.dart';

@singleton
class EditNoteBloc extends Bloc<EditNoteEvent, EditNoteState> {
  EditNoteBloc()
      : super(
          EditNoteState(
            changed: false,
            editTitle: "",
            editDocument: Document(),
          ),
        ) {
    on<UpdatedTitleEvent>((event, emit) {
      appLog.debug("UpdatedTitleEvent==>${event.title}");
      emit(
        state.copyWith(changed: () => true, editTitle: () => event.title),
      );
    });
    on<UpdatedDocumentEvent>((event, emit) {
      appLog.debug("UpdatedDocumentEvent");
      emit(
        state.copyWith(changed: () => true, editDocument: () => event.document),
      );
    });
    on<SetNewNoteEvent>((event, emit) {
      emit(EditNoteState(
        changed: false,
        editTitle: event.note?.title ?? "",
        editDocument: event.note?.content ?? Document(),
      ));
    });
  }
}
