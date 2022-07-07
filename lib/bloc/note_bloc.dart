import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:oplin/bloc/base_bloc.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/common/logging.dart';

import '../db/models.dart';
import '../repository/note_repository.dart';
import '../repository/note_view_filter.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends BaseBloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;
  final BookBloc bookBloc;
  final EditNoteBloc editLogic;

  NoteBloc({
    required this.bookBloc,
    required this.editLogic,
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(const NoteState()) {
    on<NoteRefreshRequested>(_onSubscriptionRequested);
    on<NoteDeleted>(_onNoteDeleted);
    on<NotesFilterChanged>(_onFilterChanged);
    on<NotesUpdated>(_onNoteUpdated);
    on<NotesSticky>(_onSticky);
    on<NotesMoved>(_onMoved);
    on<ShowNewNoteEvent>((event, emit) {
      appLog.debug("ShowNewNoteEvent");
      emit(
        state.copyWith(
          note: () => event.note,
        ),
      );
      editLogic.add(SetNewNoteEvent(event.note));
    });
  }

  Future<void> _onSubscriptionRequested(
    NoteRefreshRequested event,
    Emitter<NoteState> emit,
  ) async {
    emit(state.copyWith(status: () => NotesStatus.loading));

    emit(state.copyWith(notes: () => _noteRepository.getNotes()));
    bookBloc.add(const BookRefreshRequested());
    // add(const ShowNewNoteEvent(null));
  }

  Future<void> _onNoteDeleted(
    NoteDeleted event,
    Emitter<NoteState> emit,
  ) async {
    appLog.debug("delete notes ${event.uuids}");
    _noteRepository.batchDeleteNote(event.uuids);
    add(const NoteRefreshRequested());
  }

  void _onFilterChanged(
    NotesFilterChanged event,
    Emitter<NoteState> emit,
  ) {
    appLog.debug("_onFilterChanged");
    emit(
      state.copyWith(
        filter: () {
          return event.filter;
        },
      ),
    );
    add(const ShowNewNoteEvent(null));
  }

  Future<FutureOr<void>> _onNoteUpdated(
      NotesUpdated event, Emitter<NoteState> emit) async {
    Note? note;
    appLog.debug(
        "_onNoteUpdated uuid:${event.uuid},title:${event.title},content:${event.content}");
    if (event.uuid == null || event.uuid!.isEmpty) {
      note = Note.create();
      note.title = event.title ?? "";
      note.content = event.content;
      note.notebookId = event.notebookId;
      _noteRepository.saveNote(note);
    } else {
      note = _noteRepository.findNote(event.uuid!);
      if (note != null) {
        note.title = event.title ?? note.title;
        note.content = event.content;
        note.notebookId = event.notebookId;
        _noteRepository.saveNote(note);
      } else {
        note = Note.create();
        note.uuid = event.uuid!;
        note.title = event.title ?? "";
        note.content = event.content;
        note.notebookId = event.notebookId;
        _noteRepository.saveNote(note);
      }
    }

    add(const NoteRefreshRequested());
    add(ShowNewNoteEvent(note));
  }

  FutureOr<void> _onSticky(NotesSticky event, Emitter<NoteState> emit) async {
    var notes = _noteRepository.findNotes(event.uuids);
    for (var value in notes) {
      value.sticky = !value.sticky;
    }
    _noteRepository.batchSaveNote(notes);
    add(const NoteRefreshRequested());
  }

  FutureOr<void> _onMoved(NotesMoved event, Emitter<NoteState> emit) async {
    var notes = _noteRepository.findNotes(event.uuids);
    for (var value in notes) {
      value.notebookId = event.notebookId;
    }
    _noteRepository.batchSaveNote(notes);
    add(const NoteRefreshRequested());
  }

  void setNotebook(Book? notebook) {
    add(NotesFilterChanged(state.filter.copyWith(notebook: () => notebook)));
  }

  void setSearch(String? search) {
    add(NotesFilterChanged(state.filter.copyWith(search: () => search)));
  }
}
