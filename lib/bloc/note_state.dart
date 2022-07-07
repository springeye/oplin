part of 'note_bloc.dart';

enum NotesStatus { initial, loading, success, failure }

class NoteState extends Equatable {
  const NoteState(
      {this.status = NotesStatus.initial,
      this.note,
      this.notes = const [],
      this.selected = const [],
      this.filter = const NoteViewFilter(),
      this.lastUpdatedNote});

  final NotesStatus status;
  final List<Note> notes;
  final List<Note> selected;
  final NoteViewFilter filter;
  final Note? note;

  @override
  String toString() {
    return 'NotesState{status: $status, note:$note, notes: ${notes.length}, filter: $filter, lastUpdatedNote: $lastUpdatedNote}';
  } //last add or update note

  final Note? lastUpdatedNote;

  Iterable<Note> get filteredTodos => filter.applyAll(notes);

  NoteState copyWith({
    Note? Function()? note,
    NotesStatus Function()? status,
    List<Note> Function()? notes,
    List<Note> Function()? selected,
    NoteViewFilter Function()? filter,
    String Function()? search,
    Note? Function()? lastUpdatedNote,
  }) {
    return NoteState(
      status: status != null ? status() : this.status,
      notes: notes != null ? notes() : this.notes,
      selected: selected != null ? selected() : this.selected,
      filter: filter != null ? filter() : this.filter,
      note: note != null ? note() : this.note,
      lastUpdatedNote:
          lastUpdatedNote != null ? lastUpdatedNote() : this.lastUpdatedNote,
    );
  }

  @override
  List<Object?> get props => [
        status,
        note,
        notes,
        filter,
      ];
}
