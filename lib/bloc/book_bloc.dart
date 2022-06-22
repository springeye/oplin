import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../db/models.dart';
import '../repository/book_repository.dart';
import '../repository/book_view_filter.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BooksState> {
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
    _bookRepository.getBooks().then((books) {
      emit(
        state.copyWith(status: () => BooksStatus.success, books: () => books),
      );
    }).catchError(handlerError);
  }

  FutureOr<void> _onBookAdded(BookAdded event, Emitter<BooksState> emit) async {
    var book = Notebook();
    book.name = event.name;
    book.parentId = event.parentId;
    await _bookRepository.saveBook(book);
    add(const BookSubscriptionRequested());
  }

  FutureOr<void> _onBookUpdated(
      BookUpdated event, Emitter<BooksState> emit) async {
    var book = await _bookRepository.findBook(event.uuid);
    if (book != null) {
      book.name = event.name ?? book.name;
      book.parentId = event.parentId;
      await _bookRepository.saveBook(book);
    }
  }

  FutureOr<void> _onBookDeleted(
      BookDeleted event, Emitter<BooksState> emit) async {
    await _bookRepository.deleteBook(event.uuid);
  }

  FutureOr<void> _onBookMoved(BookMoved event, Emitter<BooksState> emit) async {
    var book = await _bookRepository.findBook(event.uuid);
    if (book != null) {
      book.parentId = event.parentId;
      await _bookRepository.saveBook(book);
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

  FutureOr<void> handlerError(obj) {
    emit(state.copyWith(status: () => BooksStatus.failure));
  }
}
