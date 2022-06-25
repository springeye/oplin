
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:oplin/db/models.dart';

part 'show_node_event.dart';

part 'show_node_state.dart';

class ShowNodeBloc
    extends Bloc<ShowNodeEvent, ShowNodeState> {
  ShowNodeBloc()
      : super(
          ShowNodeState(
            note: null,
            changed: false,
            editTitle: "",
            editDocument: Document(),
          ),
        ) {
    on<ShowNewNoteEvent>((event, emit) {
      emit(
        state.copyWith(
          note: () => event.note,
          changed: () => false,
          editTitle: () => "",
          editDocument: () => Document(),
        ),
      );
    });
    on<UpdatedTitleEvent>((event, emit) {
      emit(
        state.copyWith(changed: () => true, editTitle: () => event.title),
      );
      _setNewNote(state.note?..title=event.title);
    });
    on<UpdatedDocumentEvent>((event, emit) {
      emit(
        state.copyWith(changed: () => true, editDocument: () => event.document),
      );
      _setNewNote(state.note?..content =event.document);
    });
  }

  void _setNewNote(Note? note) {
    add(ShowNewNoteEvent(note));
  }
}
