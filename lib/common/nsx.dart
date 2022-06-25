import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:oplin/db/models.dart';
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:quill_markdown/quill_markdown.dart';

part 'nsx.g.dart';

class ParseResult {
  final List<Notebook> books;
  final List<Note> notes;

  ParseResult(this.books, this.notes);
}

@JsonSerializable()
class Nsx {
  final List<String> note;
  final List<String> notebook;
  final List<String> todo;

  Nsx(this.note, this.notebook, this.todo);

  factory Nsx.fromJson(Map<String, dynamic> json) => _$NsxFromJson(json);

  Map<String, dynamic> toJson() => _$NsxToJson(this);
}

class NsxImport {
  final File input;

  NsxImport(this.input);

  Future<ParseResult> getResult({String? temp}) async {
    final bytes = input.readAsBytesSync();
    final archive = ZipDecoder().decodeBytes(bytes);
    final String output = temp ??
        await getTemporaryDirectory()
            .then((value) => "${value.absolute}/nsx_outpus");
    Nsx? config;
    for (var file in archive.files) {
      final filename = file.name;
      if (file.isFile) {
        if ("config.json" == filename) {
          config =
              Nsx.fromJson(jsonDecode(utf8.decode(file.content as List<int>)));
        }
        final data = file.content as List<int>;
        File('$output/$filename')
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory('$output/$filename').create(recursive: true);
      }
    }

    List<String> noteIds = config?.note ?? [];
    List<String> booksIds = config?.notebook ?? [];
    List<Notebook> books = [];
    List<Note> notes = [];
    for (var value in booksIds) {
      var content = await File('$output/$value').readAsString();
      var note = jsonDecode(content) as Map<String, dynamic>;
      var book = Notebook();
      book.name = note['title'];
      book.createTime =
          DateTime.fromMillisecondsSinceEpoch(note['ctime'] as int);
      books.add(book);
    }
    for (var value in noteIds) {
      var contentText = await File('$output/$value').readAsString();
      var json = jsonDecode(contentText) as Map<String, dynamic>;
      var note = Note();
      note.title = json['title'];
      note.createTime =
          DateTime.fromMillisecondsSinceEpoch(json['ctime'] as int);
      note.updateTime =
          DateTime.fromMillisecondsSinceEpoch(json['mtime'] as int);
      note.notebookId = json['parent_id'];
      var md = html2md.convert(json['content']);
      String? content = markdownToQuill(md);
      note.dbContent = content!;
      notes.add(note);
    }
    File(output).deleteSync(recursive: true);
    return ParseResult(books, notes);
  }
}
