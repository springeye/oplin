part of 'show_node_bloc.dart';

abstract class ShowNodeEvent extends Equatable {
  const ShowNodeEvent();
}

class ShowNewNoteEvent extends ShowNodeEvent {
  final Note? note;


  const ShowNewNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdatedTitleEvent extends ShowNodeEvent {
  final String title;

  const UpdatedTitleEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class UpdatedDocumentEvent extends ShowNodeEvent {
  final Document document;

  const UpdatedDocumentEvent(this.document);

  @override
  List<Object?> get props => [document];
}
