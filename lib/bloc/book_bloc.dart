import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:oplin/bloc/base_bloc.dart';
import 'package:oplin/common/logging.dart';

import '../db/models.dart';
import '../repository/book_repository.dart';
import '../repository/book_view_filter.dart';

part 'book_event.dart';

part 'book_state.dart';

class BookBloc extends BaseBloc<BookEvent, BooksState> {
  final BookRepository _bookRepository;

  BookBloc({
    required BookRepository bookRepository,
  })  : _bookRepository = bookRepository,
        super(const BooksState()) {
    on<BookSubscriptionRequested>(_onSubscriptionRequested);
    on<BookAdded>(_onBookAdded);
    on<BookUpdated>(_onBookUpdated);
    on<BookDeleted>(_onBookDeleted);
    on<BookMoved>(_onBookMoved);
    on<BookFilterChanged>(_onBookFilterChanged);
  }

  FutureOr<void> _onSubscriptionRequested(
      BookSubscriptionRequested event, Emitter<BooksState> emit) async {
    emit(state.copyWith(status: () => BooksStatus.loading));
    var books = _bookRepository.getBooks();
    emit(
      state.copyWith(status: () => BooksStatus.success, books: () => books),
    );
  }

  FutureOr<void> _onBookAdded(BookAdded event, Emitter<BooksState> emit) async {
    var book = Notebook();
    book.name = event.name;
    book.parentId = event.parentId;
    _bookRepository.saveBook(book);
    add(const BookSubscriptionRequested());
  }

  FutureOr<void> _onBookUpdated(
      BookUpdated event, Emitter<BooksState> emit) async {
    var book = _bookRepository.findBook(event.uuid);
    if (book != null) {
      book.name = event.name ?? book.name;
      book.parentId = event.parentId;
      _bookRepository.saveBook(book);
      add(const BookSubscriptionRequested());
    }
  }

  FutureOr<void> _onBookDeleted(
      BookDeleted event, Emitter<BooksState> emit) async {
    _bookRepository.batchDeleteBook(event.uuids);
    add(const BookSubscriptionRequested());
  }

  FutureOr<void> _onBookMoved(BookMoved event, Emitter<BooksState> emit) async {
    var book = _bookRepository.findBook(event.uuid);
    if (book != null) {
      book.parentId = event.parentId;
      _bookRepository.saveBook(book);
      add(const BookSubscriptionRequested());
    }
  }

  void setSearch(String? search) {
    add(BookFilterChanged(state.filter.copyWith(search: () => search)));
  }

  FutureOr<void> _onBookFilterChanged(
      BookFilterChanged event, Emitter<BooksState> emit) {
    emit(
      state.copyWith(
        filter: () {
          return event.filter;
        },
      ),
    );
  }

  FutureOr<Null> handlerError(Object obj) {
    appLog.debug(obj.toString());
    emit(state.copyWith(status: () => BooksStatus.failure));
  }
}
