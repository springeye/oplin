part of 'desktop_show_node_bloc.dart';

abstract class DesktopShowNodeEvent extends Equatable {
  const DesktopShowNodeEvent();
}

class ShowNoteEvent extends DesktopShowNodeEvent {
  final Note? note;


  const ShowNoteEvent(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdatedTitleEvent extends DesktopShowNodeEvent {
  final String title;

  const UpdatedTitleEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class UpdatedDocumentEvent extends DesktopShowNodeEvent {
  final Document document;

  const UpdatedDocumentEvent(this.document);

  @override
  List<Object?> get props => [document];
}
