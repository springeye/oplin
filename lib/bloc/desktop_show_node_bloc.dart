import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:oplin/db/models.dart';

part 'desktop_show_node_event.dart';

part 'desktop_show_node_state.dart';

class DesktopShowNodeBloc
    extends Bloc<DesktopShowNodeEvent, DesktopShowNodeState> {
  DesktopShowNodeBloc()
      : super(
          DesktopShowNodeState(
            note: null,
            changed: false,
            editTitle: "",
            editDocument: Document(),
          ),
        ) {
    on<ShowNoteEvent>((event, emit) {
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
    });
    on<UpdatedDocumentEvent>((event, emit) {
      emit(
        state.copyWith(changed: () => true, editDocument: () => event.document),
      );
    });
  }
}
