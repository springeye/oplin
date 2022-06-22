part of 'note_bloc.dart';

enum NotesStatus { initial, loading, success, failure }

class NotesState extends Equatable {
  const NotesState(
      {this.status = NotesStatus.initial,
      this.notes = const [],
      this.filter = const NoteViewFilter(),
      this.lastUpdatedNote});

  final NotesStatus status;
  final List<Note> notes;
  final NoteViewFilter filter;

  @override
  String toString() {
    return 'NotesState{status: $status, notes: ${notes.length}, filter: $filter, lastUpdatedNote: $lastUpdatedNote}';
  } //last add or update note

  final Note? lastUpdatedNote;

  Iterable<Note> get filteredTodos => filter.applyAll(notes);

  NotesState copyWith({
    NotesStatus Function()? status,
    List<Note> Function()? notes,
    NoteViewFilter Function()? filter,
    String Function()? search,
    Note? Function()? lastUpdatedNote,
  }) {
    return NotesState(
      status: status != null ? status() : this.status,
      notes: notes != null ? notes() : this.notes,
      filter: filter != null ? filter() : this.filter,
      lastUpdatedNote:
          lastUpdatedNote != null ? lastUpdatedNote() : this.lastUpdatedNote,
    );
  }

  @override
  List<Object?> get props => [
        status,
        notes,
        filter,
      ];
}
