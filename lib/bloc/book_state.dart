part of 'book_bloc.dart';

enum BooksStatus { initial, loading, success, failure }

class BooksState extends Equatable {
  const BooksState(
      {this.status = BooksStatus.initial,
      this.books = const [],
      this.filter = const NotebookViewFilter(),
      this.lastUpdatedBook});

  final BooksStatus status;
  final List<Notebook> books;
  final NotebookViewFilter filter;

  final Notebook? lastUpdatedBook;

  Iterable<Notebook> get filteredTodos => filter.applyAll(books);

  @override
  String toString() {
    return 'BooksState{status: $status, books: $books, filter: $filter, lastUpdatedBook: $lastUpdatedBook}';
  }

  BooksState copyWith({
    BooksStatus Function()? status,
    List<Notebook> Function()? books,
    NotebookViewFilter Function()? filter,
    String Function()? search,
    Notebook? Function()? lastUpdatedBook,
  }) {
    return BooksState(
      status: status != null ? status() : this.status,
      books: books != null ? books() : this.books,
      filter: filter != null ? filter() : this.filter,
      lastUpdatedBook:
          lastUpdatedBook != null ? lastUpdatedBook() : this.lastUpdatedBook,
    );
  }

  @override
  List<Object?> get props => [status, books, filter, lastUpdatedBook];
}
