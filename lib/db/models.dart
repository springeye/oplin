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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Note &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              uuid == other.uuid &&
              title == other.title &&
              synced == other.synced &&
              content == other.content &&
              notebookId == other.notebookId &&
              createTime == other.createTime &&
              updateTime == other.updateTime &&
              syncTime == other.syncTime &&
              deleted == other.deleted &&
              version == other.version &&
              sticky == other.sticky &&
              conflict == other.conflict;

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      title.hashCode ^
      synced.hashCode ^
      content.hashCode ^
      notebookId.hashCode ^
      createTime.hashCode ^
      updateTime.hashCode ^
      syncTime.hashCode ^
      deleted.hashCode ^
      version.hashCode ^
      sticky.hashCode ^
      conflict.hashCode;

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

  bool sticky = false;

  Book();

  static Book get other {
    return Book()
      ..uuid = "other";
  }

  static Book get recycled {
    return Book()
      ..uuid = "recycled";
  }

  bool get isOther => uuid == "other";

  bool get isRecycled => uuid == "recycled";

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Book &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              uuid == other.uuid &&
              name == other.name &&
              synced == other.synced &&
              parentId == other.parentId &&
              deleted == other.deleted &&
              createTime == other.createTime &&
              sticky == other.sticky;

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      name.hashCode ^
      synced.hashCode ^
      parentId.hashCode ^
      deleted.hashCode ^
      createTime.hashCode ^
      sticky.hashCode;

  @override
  String toString() {
    return 'Book{id: $id, uuid: $uuid, name: $name, synced: $synced, parentId: $parentId, deleted: $deleted, createTime: $createTime, sticky: $sticky}';
  }
}

enum TodoLevel {
  l1,
  l2,
  l3,
  l4,
  l5,
}

@JsonSerializable()
@Collection()
class Todo {
  int id = Isar.autoIncrement;
  @Index()
  String uuid = "";
  String title = "";
  bool done = false;
  bool synced = false;
  bool deleted = false;
  bool sticky = false;
  DateTime createTime = DateTime.now();
  TodoLevel level = TodoLevel.l1;
  String? parentId = null;

  Todo();

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Todo &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              uuid == other.uuid &&
              title == other.title &&
              done == other.done &&
              synced == other.synced &&
              deleted == other.deleted &&
              sticky == other.sticky &&
              createTime == other.createTime &&
              level == other.level &&
              parentId == other.parentId;

  @override
  int get hashCode =>
      id.hashCode ^
      uuid.hashCode ^
      title.hashCode ^
      done.hashCode ^
      synced.hashCode ^
      deleted.hashCode ^
      sticky.hashCode ^
      createTime.hashCode ^
      level.hashCode ^
      parentId.hashCode;

}
