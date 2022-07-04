part of 'edit_note_bloc.dart';

abstract class EditNoteEvent extends Equatable {
  const EditNoteEvent();
}

class UpdatedTitleEvent extends EditNoteEvent {
  final String title;

  const UpdatedTitleEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class UpdatedDocumentEvent extends EditNoteEvent {
  final Document document;

  const UpdatedDocumentEvent(this.document);

  @override
  List<Object?> get props => [document];
}

class SetNewNoteEvent extends EditNoteEvent {
  final Note? note;

  const SetNewNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}
