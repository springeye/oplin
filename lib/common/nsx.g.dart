// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nsx.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nsx _$NsxFromJson(Map<String, dynamic> json) => Nsx(
      (json['note'] as List<dynamic>).map((e) => e as String).toList(),
      (json['notebook'] as List<dynamic>).map((e) => e as String).toList(),
      (json['todo'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$NsxToJson(Nsx instance) => <String, dynamic>{
      'note': instance.note,
      'notebook': instance.notebook,
      'todo': instance.todo,
    };
