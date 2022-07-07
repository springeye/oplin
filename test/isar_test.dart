// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';
import 'dart:io' show Directory;

import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:oplin/repository/storage/isar_note_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

Future<void> main() async {
  late NoteRepository noteRepository;
  group("isar", () {
    setUp(() async {
      await Isar.initializeIsarCore(download: true);
      TestWidgetsFlutterBinding.ensureInitialized();
      PathProviderPlatform.instance = FakePathProviderPlatform();
      final dir = await getTemporaryDirectory(); // path_provider package
      final isar = await Isar.open(
        [BookSchema, NoteSchema],
        directory: dir.path,
      );
      noteRepository = IsarNoteRepository(isar);
    });
    test("getNotes", () {
      noteRepository.getNotes();
    });
    test("batchDeleteNote", () {
      noteRepository.batchDeleteNote([]);
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
