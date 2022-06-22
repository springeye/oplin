import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/repository/book_repository.dart';

import 'book_bloc_note.mocks.dart';

@GenerateMocks([BookRepository])
Future<void> main() async {
  group("book_bloc", () {
    late BookBloc bloc;
    late BookRepository bookApi;
    setUp(() async {
      bookApi = MockBookRepository();
      when(bookApi.getBooks()).thenAnswer((_) => Future.value([]));
      bloc = BookBloc(
        bookRepository: bookApi,
      );
    });
    tearDown(() async {});
    test("init", () async {
      expect(bloc.state, const NotesState());
    });
    blocTest<BookBloc, BooksState>(
      'load books',
      build: () {
        when(bookApi.getBooks()).thenAnswer((_) => Future.value([]));
        return bloc;
      },
      act: (bloc) => bloc
        ..add(const BookSubscriptionRequested())
        ..add(const BookAdded(name: "a")),
      expect: () => [
        const BooksState(status: BooksStatus.loading),
        const BooksState(status: BooksStatus.success),
        const BooksState(status: BooksStatus.loading),
        const BooksState(status: BooksStatus.success),
      ],
    );
  });
}
