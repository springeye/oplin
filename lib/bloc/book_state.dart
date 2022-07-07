part of 'book_bloc.dart';

enum BooksStatus { initial, loading, success, failure }

class BooksState extends Equatable {
  const BooksState(
      {this.status = BooksStatus.initial,
      this.books = const [],
      this.filter = const NotebookViewFilter(),
      this.lastUpdatedBook});

  final BooksStatus status;
  final List<Book> books;
  final NotebookViewFilter filter;

  final Book? lastUpdatedBook;

  Iterable<Book> get filteredTodos => filter.applyAll(books);

  @override
  String toString() {
    return 'BooksState{status: $status, books: ${books.length}, filter: $filter, lastUpdatedBook: $lastUpdatedBook}';
  }

  BooksState copyWith({
    BooksStatus Function()? status,
    List<Book> Function()? books,
    NotebookViewFilter Function()? filter,
    String Function()? search,
    Book? Function()? lastUpdatedBook,
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
