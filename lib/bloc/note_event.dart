part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();
}

class NoteRefreshRequested extends NoteEvent {
  const NoteRefreshRequested();

  @override
  List<Object?> get props => [];
}

class ShowNewNoteEvent extends NoteEvent {
  final Note? note;

  const ShowNewNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class NotesUpdated extends NoteEvent {
  final String? uuid;
  final String? title;
  final Document content;
  final String? notebookId;

  const NotesUpdated(
      {this.uuid, this.title, required this.content, this.notebookId});

  @override
  List<Object?> get props => [uuid, title, content, notebookId];
}

class NoteDeleted extends NoteEvent {
  final List<String> uuids;

  NoteDeleted(List<String> uuids) : uuids = [...uuids];

  @override
  List<Object> get props => [...uuids];
}

class NotesSticky extends NoteEvent {
  final List<String> uuids;

  NotesSticky(List<String> uuids) : uuids = [...uuids];

  @override
  List<Object> get props => [uuids];
}

class NotesMoved extends NoteEvent {
  final List<String> uuids;
  final String? notebookId;

  NotesMoved(List<String> uuids, this.notebookId) : uuids = [...uuids];

  @override
  List<Object> get props => [uuids];
}

class NotesFilterChanged extends NoteEvent {
  const NotesFilterChanged(this.filter);

  final NoteViewFilter filter;

  @override
  List<Object> get props => [filter];
}
