import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/db/objectbox.g.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/storage/storage_book_repository.dart';
import 'package:oplin/repository/storage/storage_note_repository.dart';
import 'package:uuid/uuid.dart';

import 'book_bloc_note.mocks.dart';

@GenerateMocks([BookRepository])
Future<void> main() async {
  group("book_bloc", () {
    late BookBloc bloc;
    late BookRepository repository;
    late Store store;
    setUp(() async {
      File("test").deleteSync(recursive: false);
      store = await openStore(directory: "test");
      repository = StorageBookRepository(store);
    });
    tearDown(() async {
      store.close();
      File("test").deleteSync(recursive: false);
    });
    test("delete", () async {
      var book = Notebook()..uuid = const Uuid().v4();
      var noteRepository = StorageNoteRepository(store);
      await repository.saveBook(book);
      await noteRepository.saveNote(Note.create()..notebookId = book.uuid);
      await repository.deleteBook(book.uuid);
      var notes = await noteRepository.query(Note_.notebookId.isNull());
      expect(notes.length, 0);
    });
  });
}
