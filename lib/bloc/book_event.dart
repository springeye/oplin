part of 'book_bloc.dart';

abstract class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class BookSubscriptionRequested extends BookEvent {
  const BookSubscriptionRequested();
}

class BookAdded extends BookEvent {
  final String name;
  final String? parentId;

  const BookAdded({required this.name, this.parentId});
}

class BookUpdated extends BookEvent {
  final String uuid;
  final String? name;
  final String? parentId;

  const BookUpdated(this.uuid, {this.name, this.parentId});
}

class BookDeleted extends BookEvent {
  final List<String> uuids;

  BookDeleted(List<String> _uuids) : uuids = [..._uuids];

  @override
  List<Object> get props => [uuids];
}

class BookMoved extends BookEvent {
  final String uuid;
  final String? parentId;

  const BookMoved(this.uuid, this.parentId);

  @override
  List<Object> get props => [uuid, parentId ?? ""];
}

class BookFilterChanged extends BookEvent {
  const BookFilterChanged(this.filter);

  final NotebookViewFilter filter;

  @override
  List<Object> get props => [filter];
}
