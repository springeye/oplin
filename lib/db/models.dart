import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

part 'models.g.dart';

@Entity()
@JsonSerializable()
class Note {
  int id = 0;
  @Index()
  String uuid = "";
  String title = "";
  bool synced = false;
  String content = "";
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
@Entity()
class Notebook {
  int id = 0;
  @Index()
  String uuid = "";
  String name = "";
  bool synced = false;
  String? parentId;
  bool deleted = false;
  DateTime createTime = DateTime.now();
  @Transient()
  int count = 0;
  bool sticky = false;

  Notebook();

  static Notebook get other {
    return Notebook()..uuid = "other";
  }

  bool get isOther => uuid == "other";

  factory Notebook.fromJson(Map<String, dynamic> json) =>
      _$NotebookFromJson(json);

  Map<String, dynamic> toJson() => _$NotebookToJson(this);

  @override
  String toString() {
    return 'Notebook{id: $id, uuid: $uuid, name: $name, synced: $synced, parentId: $parentId, deleted: $deleted, createTime: $createTime, count: $count, sticky: $sticky}';
  }
}
