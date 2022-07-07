import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'models.g.dart';

class DocumentConverter implements JsonConverter<Document, List> {
  const DocumentConverter();

  @override
  Document fromJson(List<dynamic> json) {
    return Document.fromJson(json);
  }

  @override
  List toJson(Document object) {
    return object.toDelta().toJson();
  }
}

@DocumentConverter()
@JsonSerializable()
@Collection()
class Note {
  int id = Isar.autoIncrement;
  @Index()
  String uuid = "";
  String title = "";
  @JsonKey(ignore: true)
  bool synced = false;

  Document content = Document();
  String? notebookId;
  DateTime createTime = DateTime.now();
  DateTime updateTime = DateTime.now();
  DateTime? syncTime;
  bool deleted = false;
  int version = 0;
  bool sticky = false;

  //conflict target uuid
  String? conflict = "";

  Note();

  @JsonKey(ignore: true)
  String get dbContent {
    return jsonEncode(content.toDelta().toJson());
  }

  set dbContent(String content) {
    if (content.isEmpty) {
      this.content = Document();
    } else {
      this.content = Document.fromJson(jsonDecode(content));
    }
  }

  static Note create() {
    var note = Note();
    note.uuid = const Uuid().v4();
    note.createTime = DateTime.now();
    note.updateTime = DateTime.now();
    return note;
  }

  void setSynced() {
    synced = true;
    syncTime = DateTime.now();
  }

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  @override
  String toString() {
    return 'Note{id: $id, uuid: $uuid, title: $title, synced: $synced, content: $content, notebookId: $notebookId, createTime: $createTime, updateTime: $updateTime, deleted: $deleted, version: $version, sticky: $sticky, conflict: $conflict}';
  }
}

@JsonSerializable()
@Collection()
class Book {
  int id = Isar.autoIncrement;
  @Index()
  String uuid = "";
  String name = "";
  bool synced = false;
  String? parentId;
  bool deleted = false;
  DateTime createTime = DateTime.now();
  @Ignore()
  int count = 0;
  bool sticky = false;

  Book();

  static Book get other {
    return Book()..uuid = "other";
  }

  static Book get recycled {
    return Book()..uuid = "recycled";
  }

  bool get isOther => uuid == "other";

  bool get isRecycled => uuid == "recycled";

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  String toString() {
    return 'Book{id: $id, uuid: $uuid, name: $name, synced: $synced, parentId: $parentId, deleted: $deleted, createTime: $createTime, count: $count, sticky: $sticky}';
  }
}
