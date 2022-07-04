part of 'edit_note_bloc.dart';

class EditNoteState extends Equatable {
  final bool changed;
  final String editTitle;
  final Document editDocument;

  const EditNoteState({
    required this.changed,
    required this.editTitle,
    required this.editDocument,
  });

  @override
  List<Object?> get props => [changed, editTitle, editDocument];

  @override
  String toString() {
    return 'EditNoteState{changed: $changed, editTitle: $editTitle, editDocument: $editDocument}';
  }

  EditNoteState copyWith({
    bool Function()? changed,
    String Function()? editTitle,
    Document Function()? editDocument,
  }) {
    return EditNoteState(
      changed: changed != null ? changed() : this.changed,
      editTitle: editTitle != null ? editTitle() : this.editTitle,
      editDocument: editDocument != null ? editDocument() : this.editDocument,
    );
  }
}
