// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) => Note()
  ..id = json['id'] as int
  ..uuid = json['uuid'] as String
  ..title = json['title'] as String
  ..content = const DocumentConverter().fromJson(json['content'] as List)
  ..notebookId = json['notebookId'] as String?
  ..createTime = DateTime.parse(json['createTime'] as String)
  ..updateTime = DateTime.parse(json['updateTime'] as String)
  ..syncTime = json['syncTime'] == null
      ? null
      : DateTime.parse(json['syncTime'] as String)
  ..deleted = json['deleted'] as bool
  ..version = json['version'] as int
  ..sticky = json['sticky'] as bool
  ..conflict = json['conflict'] as String?;

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'title': instance.title,
      'content': const DocumentConverter().toJson(instance.content),
      'notebookId': instance.notebookId,
      'createTime': instance.createTime.toIso8601String(),
      'updateTime': instance.updateTime.toIso8601String(),
      'syncTime': instance.syncTime?.toIso8601String(),
      'deleted': instance.deleted,
      'version': instance.version,
      'sticky': instance.sticky,
      'conflict': instance.conflict,
    };

Notebook _$NotebookFromJson(Map<String, dynamic> json) => Notebook()
  ..id = json['id'] as int
  ..uuid = json['uuid'] as String
  ..name = json['name'] as String
  ..synced = json['synced'] as bool
  ..parentId = json['parentId'] as String?
  ..deleted = json['deleted'] as bool
  ..createTime = DateTime.parse(json['createTime'] as String)
  ..count = json['count'] as int
  ..sticky = json['sticky'] as bool;

Map<String, dynamic> _$NotebookToJson(Notebook instance) => <String, dynamic>{
      'id': instance.id,
      'uuid': instance.uuid,
      'name': instance.name,
      'synced': instance.synced,
      'parentId': instance.parentId,
      'deleted': instance.deleted,
      'createTime': instance.createTime.toIso8601String(),
      'count': instance.count,
      'sticky': instance.sticky,
    };
