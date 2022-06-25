part of 'show_node_bloc.dart';

class ShowNodeState extends Equatable {
  final Note? note;
  final bool changed;
  final String editTitle;
  final Document editDocument;

  const ShowNodeState({
    this.note,
    required this.changed,
    required this.editTitle,
    required this.editDocument,
  });

  @override
  List<Object?> get props => [changed, note];

  ShowNodeState copyWith({
    Note? Function()? note,
    bool Function()? changed,
    String Function()? editTitle,
    Document Function()? editDocument,
  }) {
    return ShowNodeState(
      note: note != null ? note() : this.note,
      changed: changed != null ? changed() : this.changed,
      editTitle: editTitle != null ? editTitle() : this.editTitle,
      editDocument: editDocument != null ? editDocument() : this.editDocument,
    );
  }
}
