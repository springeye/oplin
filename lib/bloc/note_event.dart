part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class NotesSubscriptionRequested extends NoteEvent {
  const NotesSubscriptionRequested();
}

class NotesAdded extends NoteEvent {
  final String title;
  final String content;
  final String? notebookId;

  const NotesAdded(
      {required this.title, required this.content, this.notebookId});
}

class NotesUpdated extends NoteEvent {
  final String uuid;
  final String? title;
  final String? content;
  final String? notebookId;

  const NotesUpdated(this.uuid, {this.title, this.content, this.notebookId});
}

class NotesNoteDeleted extends NoteEvent {
  final List<String> uuids;

  NotesNoteDeleted(List<String> uuids) : uuids = [...uuids];

  @override
  List<Object> get props => [uuids];
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
