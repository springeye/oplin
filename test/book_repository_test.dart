import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/db/objectbox.g.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/storage/storage_book_repository.dart';
import 'package:oplin/repository/storage/storage_note_repository.dart';
import 'package:uuid/uuid.dart';

@GenerateMocks([BookRepository])
Future<void> main() async {
  group("book_bloc", () {
    late BookRepository repository;
    late Store store;
    setUp(() async {
      store = await openStore(directory: "./test_db");
      repository = StorageBookRepository(store);
    });
    tearDown(() async {
      store.close();
      File("./test_db").deleteSync(recursive: true);
    });
    test("delete", () async {
      var book = Book()..uuid = const Uuid().v4();
      var noteRepository = StorageNoteRepository(store);
      repository.saveBook(book);
      noteRepository.saveNote(Note.create()..notebookId = book.uuid);
      repository.deleteBook(book.uuid);
      var notes = noteRepository.query(Note_.uuid.isNull());
      expect(notes.length, 0);
    });
  });
}
