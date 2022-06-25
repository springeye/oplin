// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/server/webdav/webdav.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  group("webdav", () {
    var url = const String.fromEnvironment("webdav_url");
    var user = const String.fromEnvironment('webdav_user');
    var password = const String.fromEnvironment('webdav_pass');
    var uuid = const Uuid();
    var client = WebDAVClient(
      url,
      user: user,
      password: password,
    );
    setUp(() async {
      await client.check();
    });
    test("writeText", () async {
      var note = Note.create();
      note.uuid = uuid.v4();
      note.content = Document();
      await client.uploadNote(note);
    });
    test("listNote", () async {
      var notes = await client.listNote();
      expect(notes.isNotEmpty, true);
    });
    test("getNode", () async {
      var note = await client.getNote("bfcf5efa-341f-4266-8ab7-1cae8bf54438");
      expect(note.content, true);
    });
    test("sync", () async {
      appLog.debug("create");
      Note note = Note.create();
      note.uuid = uuid.v4();
      appLog.debug("uuid=>>>>${note.uuid}");
      note.version = 1;
      note.content = Document();
      await client.uploadNote(note);
      note.version = 2;
      note.content = Document();
      var removeNote = await client.getNote(note.uuid);
      if (removeNote.version > note.version) {
        appLog.debug("有冲突");
      } else if (note.version > removeNote.version) {
        appLog.debug("update remote node ");
        await client.uploadNote(note);
        var remoteNote = await client.getNote(note.uuid);
        expect(remoteNote.content, "hello\ntest");
      }
    });
  });
}
