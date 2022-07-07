import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/annotations.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/storage/isar_book_repository.dart';
import 'package:oplin/repository/storage/isar_note_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

@GenerateMocks([BookRepository])
Future<void> main() async {
  group("book_bloc", () {
    late BookRepository repository;
    late Isar store;
    setUp(() async {
      await Isar.initializeIsarCore(download: true);
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = FakePathProviderPlatform();
      final dir = await getTemporaryDirectory(); // path_provider package
      store = await Isar.open(
        [BookSchema, NoteSchema],
        directory: dir.path,
      );
      repository = IsarBookRepository(store);
    });
    tearDown(() async {
      store.close();
    });
    test("delete", () async {
      var book = Book()..uuid = const Uuid().v4();
      var noteRepository = IsarNoteRepository(store);
      repository.saveBook(book);
      noteRepository.saveNote(Note.create()..notebookId = book.uuid);
      repository.deleteBook(book.uuid);
      var notes = noteRepository
          .getNotes()
          .where((element) => element.notebookId == null);
      expect(notes.length, 0);
    });
  });
}

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() {
    return Future.value(Directory.systemTemp.createTempSync().path);
  }
}
