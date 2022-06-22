import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/note_repository.dart';

import 'note_bloc_note.mocks.dart';

@GenerateMocks([NoteRepository, BookRepository])
Future<void> main() async {
  group("note_bloc", () {
    late NoteBloc bloc;
    late NoteRepository noteApi;
    setUp(() async {
      noteApi = MockNoteRepository();
      when(noteApi.getNotes()).thenAnswer((_) => Stream.value([]));
      bloc = NoteBloc(
        noteRepository: noteApi,
        bookBloc: BookBloc(bookRepository: MockBookRepository()),
      );
    });
    tearDown(() async {});
    test("init", () async {
      expect(bloc.state, const NotesState());
    });
    blocTest<NoteBloc, NotesState>(
      'load notes',
      build: () {
        when(noteApi.getNotes()).thenAnswer((_) => Stream.value([]));
        return bloc;
      },
      act: (bloc) => bloc..add(const NotesSubscriptionRequested()),
      expect: () => [
        const NotesState(status: NotesStatus.loading),
        const NotesState(status: NotesStatus.success),
      ],
    );
  });
}
