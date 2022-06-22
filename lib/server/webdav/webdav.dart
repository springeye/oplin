import 'dart:convert';
import 'dart:typed_data';

import 'package:oplin/db/models.dart';
import 'package:webdav_client/webdav_client.dart';
import 'package:dio/dio.dart';

const String _dirLock = ".lock";
const String _dirRecycled = ".recycled";
const String _suffixNote = ".json";

class WebDAVClient {
  late Client client;

  WebDAVClient(String url, {String user = '', String password = ''}) {
    if (!url.endsWith("/")) {
      throw Exception("url must ends with '/'");
    }
    client =
        newClient("${url}oplin", user: user, password: password, debug: false);
  }

  Future<void> ping() async {
    return await client.ping();
  }

  Future<void> check() async {
    await client.mkdir(_dirLock);
    await client.mkdir(_dirRecycled);
  }

  Future<List<File>> listNote({bool recycled = false}) async {
    await check();
    var dir = "";
    if (recycled) {
      dir = _dirRecycled;
    }
    var notes = await client.readDir(dir).then((notes) => notes.where(
        (element) =>
            element.name?.endsWith(_suffixNote) == true &&
            element.isDir == false));
    return notes.toList();
  }

  Future<void> uploadNote(
    Note note, {
    void Function(int count, int total)? onProgress,
  }) async {
    await check();
    return await client.write("${note.uuid}$_suffixNote",
        Uint8List.fromList(_toJson(note.toJson()).codeUnits),
        onProgress: onProgress);
  }

  String _toJson(Map<String, dynamic> map) {
    var spaces = ' ' * 4;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(map);
  }

  delete(Note note, {bool recycled = true}) async {
    await check();
    if (recycled) {
      return await client.rename("${note.uuid}$_suffixNote",
          "$_dirRecycled/${note.uuid}$_suffixNote", true);
    } else {
      return await client.remove("${note.uuid}$_suffixNote");
    }
  }

  Future<Note> getNote(String uuid) async {
    var codes = await client.read("$uuid$_suffixNote");
    var body = String.fromCharCodes(codes);
    var note = Note.fromJson(jsonDecode(body));
    return note;
  }

  Future<bool> exist(String uuid) async {
    try {
      await client.readProps("$uuid$_suffixNote");
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 404) {
          return false;
        } else {}
        rethrow;
      }
    }
    return true;
  }

  Future<Note> getNoteByName(String name) async {
    var codes = await client.read(name);
    var body = String.fromCharCodes(codes);
    var note = Note.fromJson(jsonDecode(body));
    return note;
  }
}
