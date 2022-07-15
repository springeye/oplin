// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoState _$$_TodoStateFromJson(Map<String, dynamic> json) => _$_TodoState(
      status: $enumDecode(_$TodosOverviewStatusEnumMap, json['status']),
      todos: (json['todos'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
      search: json['search'] as String?,
      filter: $enumDecode(_$TodoViewFilterEnumMap, json['filter']),
      lastDeletedTodo: json['lastDeletedTodo'] == null
          ? null
          : Todo.fromJson(json['lastDeletedTodo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_TodoStateToJson(_$_TodoState instance) =>
    <String, dynamic>{
      'status': _$TodosOverviewStatusEnumMap[instance.status]!,
      'todos': instance.todos,
      'search': instance.search,
      'filter': _$TodoViewFilterEnumMap[instance.filter]!,
      'lastDeletedTodo': instance.lastDeletedTodo,
    };

const _$TodosOverviewStatusEnumMap = {
  TodosOverviewStatus.initial: 'initial',
  TodosOverviewStatus.loading: 'loading',
  TodosOverviewStatus.success: 'success',
  TodosOverviewStatus.failure: 'failure',
};

const _$TodoViewFilterEnumMap = {
  TodoViewFilter.all: 'all',
  TodoViewFilter.activeOnly: 'activeOnly',
  TodoViewFilter.completedOnly: 'completedOnly',
};

_$SubscriptionRequested _$$SubscriptionRequestedFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionRequested(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SubscriptionRequestedToJson(
        _$SubscriptionRequested instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$CompletionToggled _$$CompletionToggledFromJson(Map<String, dynamic> json) =>
    _$CompletionToggled(
      Todo.fromJson(json['todo'] as Map<String, dynamic>),
      json['isCompleted'] as bool,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$CompletionToggledToJson(_$CompletionToggled instance) =>
    <String, dynamic>{
      'todo': instance.todo,
      'isCompleted': instance.isCompleted,
      'runtimeType': instance.$type,
    };

_$Deleted _$$DeletedFromJson(Map<String, dynamic> json) => _$Deleted(
      Todo.fromJson(json['todo'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DeletedToJson(_$Deleted instance) => <String, dynamic>{
      'todo': instance.todo,
      'runtimeType': instance.$type,
    };

_$UnDoDeleted _$$UnDoDeletedFromJson(Map<String, dynamic> json) =>
    _$UnDoDeleted(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnDoDeletedToJson(_$UnDoDeleted instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$FilterChanged _$$FilterChangedFromJson(Map<String, dynamic> json) =>
    _$FilterChanged(
      $enumDecode(_$TodoViewFilterEnumMap, json['filter']),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$FilterChangedToJson(_$FilterChanged instance) =>
    <String, dynamic>{
      'filter': _$TodoViewFilterEnumMap[instance.filter]!,
      'runtimeType': instance.$type,
    };

_$Search _$$SearchFromJson(Map<String, dynamic> json) => _$Search(
      json['search'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SearchToJson(_$Search instance) => <String, dynamic>{
      'search': instance.search,
      'runtimeType': instance.$type,
    };

_$ToggleAll _$$ToggleAllFromJson(Map<String, dynamic> json) => _$ToggleAll(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ToggleAllToJson(_$ToggleAll instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };

_$ClearCompleted _$$ClearCompletedFromJson(Map<String, dynamic> json) =>
    _$ClearCompleted(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ClearCompletedToJson(_$ClearCompleted instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
