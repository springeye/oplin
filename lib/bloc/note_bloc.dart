import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/bloc/base_bloc.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/common/logging.dart';

import '../db/models.dart';
import '../repository/note_repository.dart';
import '../repository/note_view_filter.dart';

part 'note_event.dart';

part 'note_state.dart';

class NoteBloc extends BaseBloc<NoteEvent, NotesState> {
  final NoteRepository _noteRepository;
  final BookBloc bookBloc;

  NoteBloc({
    required this.bookBloc,
    required NoteRepository noteRepository,
  })  : _noteRepository = noteRepository,
        super(const NotesState()) {
    on<NotesSubscriptionRequested>(_onSubscriptionRequested);
    on<NotesNoteDeleted>(_onNoteDeleted);
    on<NotesFilterChanged>(_onFilterChanged);
    on<NotesAdded>(_onNoteAdded);
    on<NotesUpdated>(_onNoteUpdated);
    on<NotesSticky>(_onSticky);
    on<NotesMoved>(_onMoved);
  }

  Future<void> _onSubscriptionRequested(
    NotesSubscriptionRequested event,
    Emitter<NotesState> emit,
  ) async {
    emit(state.copyWith(status: () => NotesStatus.loading));

    emit(state.copyWith(notes: () => _noteRepository.getNotes()));
    bookBloc.add(const BookSubscriptionRequested());
  }

  Future<void> _onNoteDeleted(
    NotesNoteDeleted event,
    Emitter<NotesState> emit,
  ) async {
    appLog.debug("delete notes ${event.uuids}");
    _noteRepository.batchDeleteNote(event.uuids);
    add(const NotesSubscriptionRequested());
  }

  void _onFilterChanged(
    NotesFilterChanged event,
    Emitter<NotesState> emit,
  ) {
    appLog.debug("_onFilterChanged");
    emit(
      state.copyWith(
        filter: () {
          return event.filter;
        },
      ),
    );
  }

  Future<FutureOr<void>> _onNoteUpdated(
      NotesUpdated event, Emitter<NotesState> emit) async {
    var note = _noteRepository.findNote(event.uuid);
    if (note != null) {
      note.title = event.title ?? note.title;
      note.content = event.content ?? note.content;
      note.notebookId = event.notebookId;
      _noteRepository.saveNote(note);
    } else {
      Note note = Note.create();
      note.uuid = event.uuid;
      note.title = event.title ?? "";
      note.content = event.content!;
      note.notebookId = event.notebookId;
      _noteRepository.saveNote(note);
    }
    add(const NotesSubscriptionRequested());
  }

  FutureOr<void> _onSticky(NotesSticky event, Emitter<NotesState> emit) async {
    var notes = _noteRepository.findNotes(event.uuids);
    for (var value in notes) {
      value.sticky = !value.sticky;
    }
    _noteRepository.batchSaveNote(notes);
    add(const NotesSubscriptionRequested());
  }

  FutureOr<void> _onMoved(NotesMoved event, Emitter<NotesState> emit) async {
    var notes = _noteRepository.findNotes(event.uuids);
    for (var value in notes) {
      value.notebookId = event.notebookId;
    }
    _noteRepository.batchSaveNote(notes);
    add(const NotesSubscriptionRequested());
  }

  FutureOr<void> _onNoteAdded(
      NotesAdded event, Emitter<NotesState> emit) async {
    Note note = Note.create();
    note.title = event.title;
    note.content = event.content;
    note.notebookId = event.notebookId;
    _noteRepository.saveNote(note);
    add(const NotesSubscriptionRequested());
  }

  void setNotebook(Notebook? notebook) {
    add(NotesFilterChanged(state.filter.copyWith(notebook: () => notebook)));
  }

  void setSearch(String? search) {
    add(NotesFilterChanged(state.filter.copyWith(search: () => search)));
  }
}
