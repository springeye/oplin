// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.edit.bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoEditState _$$_TodoEditStateFromJson(Map<String, dynamic> json) =>
    _$_TodoEditState(
      status: $enumDecode(_$EditTodoStatusEnumMap, json['status']),
      initialTodo: json['initialTodo'] == null
          ? null
          : Todo.fromJson(json['initialTodo'] as Map<String, dynamic>),
      title: json['title'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$_TodoEditStateToJson(_$_TodoEditState instance) =>
    <String, dynamic>{
      'status': _$EditTodoStatusEnumMap[instance.status]!,
      'initialTodo': instance.initialTodo,
      'title': instance.title,
      'description': instance.description,
    };

const _$EditTodoStatusEnumMap = {
  EditTodoStatus.initial: 'initial',
  EditTodoStatus.loading: 'loading',
  EditTodoStatus.success: 'success',
  EditTodoStatus.failure: 'failure',
};

_$TitleChanged _$$TitleChangedFromJson(Map<String, dynamic> json) =>
    _$TitleChanged(
      json['title'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$TitleChangedToJson(_$TitleChanged instance) =>
    <String, dynamic>{
      'title': instance.title,
      'runtimeType': instance.$type,
    };

_$DescriptionChanged _$$DescriptionChangedFromJson(Map<String, dynamic> json) =>
    _$DescriptionChanged(
      json['description'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DescriptionChangedToJson(
        _$DescriptionChanged instance) =>
    <String, dynamic>{
      'description': instance.description,
      'runtimeType': instance.$type,
    };

_$Submitted _$$SubmittedFromJson(Map<String, dynamic> json) => _$Submitted(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SubmittedToJson(_$Submitted instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$Created _$$CreatedFromJson(Map<String, dynamic> json) => _$Created(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CreatedToJson(_$Created instance) => <String, dynamic>{
      'runtimeType': instance.$type,
    };
