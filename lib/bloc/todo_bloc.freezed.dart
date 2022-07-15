// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TodoState {
  TodosOverviewStatus get status => throw _privateConstructorUsedError;
  List<Todo> get todos => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;
  TodoViewFilter get filter => throw _privateConstructorUsedError;
  Todo? get lastDeletedTodo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TodoStateCopyWith<TodoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoStateCopyWith<$Res> {
  factory $TodoStateCopyWith(TodoState value, $Res Function(TodoState) then) =
      _$TodoStateCopyWithImpl<$Res>;
  $Res call(
      {TodosOverviewStatus status,
      List<Todo> todos,
      String? search,
      TodoViewFilter filter,
      Todo? lastDeletedTodo});
}

/// @nodoc
class _$TodoStateCopyWithImpl<$Res> implements $TodoStateCopyWith<$Res> {
  _$TodoStateCopyWithImpl(this._value, this._then);

  final TodoState _value;
  // ignore: unused_field
  final $Res Function(TodoState) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? todos = freezed,
    Object? search = freezed,
    Object? filter = freezed,
    Object? lastDeletedTodo = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TodosOverviewStatus,
      todos: todos == freezed
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      search: search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: filter == freezed
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TodoViewFilter,
      lastDeletedTodo: lastDeletedTodo == freezed
          ? _value.lastDeletedTodo
          : lastDeletedTodo // ignore: cast_nullable_to_non_nullable
              as Todo?,
    ));
  }
}

/// @nodoc
abstract class _$$_TodoStateCopyWith<$Res> implements $TodoStateCopyWith<$Res> {
  factory _$$_TodoStateCopyWith(
          _$_TodoState value, $Res Function(_$_TodoState) then) =
      __$$_TodoStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {TodosOverviewStatus status,
      List<Todo> todos,
      String? search,
      TodoViewFilter filter,
      Todo? lastDeletedTodo});
}

/// @nodoc
class __$$_TodoStateCopyWithImpl<$Res> extends _$TodoStateCopyWithImpl<$Res>
    implements _$$_TodoStateCopyWith<$Res> {
  __$$_TodoStateCopyWithImpl(
      _$_TodoState _value, $Res Function(_$_TodoState) _then)
      : super(_value, (v) => _then(v as _$_TodoState));

  @override
  _$_TodoState get _value => super._value as _$_TodoState;

  @override
  $Res call({
    Object? status = freezed,
    Object? todos = freezed,
    Object? search = freezed,
    Object? filter = freezed,
    Object? lastDeletedTodo = freezed,
  }) {
    return _then(_$_TodoState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TodosOverviewStatus,
      todos: todos == freezed
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<Todo>,
      search: search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
      filter: filter == freezed
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TodoViewFilter,
      lastDeletedTodo: lastDeletedTodo == freezed
          ? _value.lastDeletedTodo
          : lastDeletedTodo // ignore: cast_nullable_to_non_nullable
              as Todo?,
    ));
  }
}

/// @nodoc

class _$_TodoState extends _TodoState {
  const _$_TodoState(
      {required this.status,
      required final List<Todo> todos,
      this.search,
      required this.filter,
      this.lastDeletedTodo})
      : _todos = todos,
        super._();

  @override
  final TodosOverviewStatus status;
  final List<Todo> _todos;
  @override
  List<Todo> get todos {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  final String? search;
  @override
  final TodoViewFilter filter;
  @override
  final Todo? lastDeletedTodo;

  @override
  String toString() {
    return 'TodoState(status: $status, todos: $todos, search: $search, filter: $filter, lastDeletedTodo: $lastDeletedTodo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoState &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other._todos, _todos) &&
            const DeepCollectionEquality().equals(other.search, search) &&
            const DeepCollectionEquality().equals(other.filter, filter) &&
            const DeepCollectionEquality()
                .equals(other.lastDeletedTodo, lastDeletedTodo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(_todos),
      const DeepCollectionEquality().hash(search),
      const DeepCollectionEquality().hash(filter),
      const DeepCollectionEquality().hash(lastDeletedTodo));

  @JsonKey(ignore: true)
  @override
  _$$_TodoStateCopyWith<_$_TodoState> get copyWith =>
      __$$_TodoStateCopyWithImpl<_$_TodoState>(this, _$identity);
}

abstract class _TodoState extends TodoState {
  const factory _TodoState(
      {required final TodosOverviewStatus status,
      required final List<Todo> todos,
      final String? search,
      required final TodoViewFilter filter,
      final Todo? lastDeletedTodo}) = _$_TodoState;
  const _TodoState._() : super._();

  @override
  TodosOverviewStatus get status;
  @override
  List<Todo> get todos;
  @override
  String? get search;
  @override
  TodoViewFilter get filter;
  @override
  Todo? get lastDeletedTodo;
  @override
  @JsonKey(ignore: true)
  _$$_TodoStateCopyWith<_$_TodoState> get copyWith =>
      throw _privateConstructorUsedError;
}

TodoEvent _$TodoEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'subscriptionRequested':
      return SubscriptionRequested.fromJson(json);
    case 'completionToggled':
      return CompletionToggled.fromJson(json);
    case 'deleted':
      return Deleted.fromJson(json);
    case 'unDoDeleted':
      return UnDoDeleted.fromJson(json);
    case 'filterChanged':
      return FilterChanged.fromJson(json);
    case 'search':
      return Search.fromJson(json);
    case 'toggleAll':
      return ToggleAll.fromJson(json);
    case 'clearCompleted':
      return ClearCompleted.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'TodoEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$TodoEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoEventCopyWith<$Res> {
  factory $TodoEventCopyWith(TodoEvent value, $Res Function(TodoEvent) then) =
      _$TodoEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$TodoEventCopyWithImpl<$Res> implements $TodoEventCopyWith<$Res> {
  _$TodoEventCopyWithImpl(this._value, this._then);

  final TodoEvent _value;
  // ignore: unused_field
  final $Res Function(TodoEvent) _then;
}

/// @nodoc
abstract class _$$SubscriptionRequestedCopyWith<$Res> {
  factory _$$SubscriptionRequestedCopyWith(_$SubscriptionRequested value,
          $Res Function(_$SubscriptionRequested) then) =
      __$$SubscriptionRequestedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubscriptionRequestedCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res>
    implements _$$SubscriptionRequestedCopyWith<$Res> {
  __$$SubscriptionRequestedCopyWithImpl(_$SubscriptionRequested _value,
      $Res Function(_$SubscriptionRequested) _then)
      : super(_value, (v) => _then(v as _$SubscriptionRequested));

  @override
  _$SubscriptionRequested get _value => super._value as _$SubscriptionRequested;
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionRequested implements SubscriptionRequested {
  const _$SubscriptionRequested({final String? $type})
      : $type = $type ?? 'subscriptionRequested';

  factory _$SubscriptionRequested.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionRequestedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEvent.subscriptionRequested()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubscriptionRequested);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) {
    return subscriptionRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) {
    return subscriptionRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) {
    if (subscriptionRequested != null) {
      return subscriptionRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) {
    return subscriptionRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) {
    return subscriptionRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) {
    if (subscriptionRequested != null) {
      return subscriptionRequested(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionRequestedToJson(this);
  }
}

abstract class SubscriptionRequested implements TodoEvent {
  const factory SubscriptionRequested() = _$SubscriptionRequested;

  factory SubscriptionRequested.fromJson(Map<String, dynamic> json) =
      _$SubscriptionRequested.fromJson;
}

/// @nodoc
abstract class _$$CompletionToggledCopyWith<$Res> {
  factory _$$CompletionToggledCopyWith(
          _$CompletionToggled value, $Res Function(_$CompletionToggled) then) =
      __$$CompletionToggledCopyWithImpl<$Res>;
  $Res call({Todo todo, bool isCompleted});
}

/// @nodoc
class __$$CompletionToggledCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res>
    implements _$$CompletionToggledCopyWith<$Res> {
  __$$CompletionToggledCopyWithImpl(
      _$CompletionToggled _value, $Res Function(_$CompletionToggled) _then)
      : super(_value, (v) => _then(v as _$CompletionToggled));

  @override
  _$CompletionToggled get _value => super._value as _$CompletionToggled;

  @override
  $Res call({
    Object? todo = freezed,
    Object? isCompleted = freezed,
  }) {
    return _then(_$CompletionToggled(
      todo == freezed
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
      isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CompletionToggled implements CompletionToggled {
  const _$CompletionToggled(this.todo, this.isCompleted, {final String? $type})
      : $type = $type ?? 'completionToggled';

  factory _$CompletionToggled.fromJson(Map<String, dynamic> json) =>
      _$$CompletionToggledFromJson(json);

  @override
  final Todo todo;
  @override
  final bool isCompleted;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEvent.completionToggled(todo: $todo, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompletionToggled &&
            const DeepCollectionEquality().equals(other.todo, todo) &&
            const DeepCollectionEquality()
                .equals(other.isCompleted, isCompleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(todo),
      const DeepCollectionEquality().hash(isCompleted));

  @JsonKey(ignore: true)
  @override
  _$$CompletionToggledCopyWith<_$CompletionToggled> get copyWith =>
      __$$CompletionToggledCopyWithImpl<_$CompletionToggled>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) {
    return completionToggled(todo, isCompleted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) {
    return completionToggled?.call(todo, isCompleted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) {
    if (completionToggled != null) {
      return completionToggled(todo, isCompleted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) {
    return completionToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) {
    return completionToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) {
    if (completionToggled != null) {
      return completionToggled(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CompletionToggledToJson(this);
  }
}

abstract class CompletionToggled implements TodoEvent {
  const factory CompletionToggled(final Todo todo, final bool isCompleted) =
      _$CompletionToggled;

  factory CompletionToggled.fromJson(Map<String, dynamic> json) =
      _$CompletionToggled.fromJson;

  Todo get todo;
  bool get isCompleted;
  @JsonKey(ignore: true)
  _$$CompletionToggledCopyWith<_$CompletionToggled> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeletedCopyWith<$Res> {
  factory _$$DeletedCopyWith(_$Deleted value, $Res Function(_$Deleted) then) =
      __$$DeletedCopyWithImpl<$Res>;
  $Res call({Todo todo});
}

/// @nodoc
class __$$DeletedCopyWithImpl<$Res> extends _$TodoEventCopyWithImpl<$Res>
    implements _$$DeletedCopyWith<$Res> {
  __$$DeletedCopyWithImpl(_$Deleted _value, $Res Function(_$Deleted) _then)
      : super(_value, (v) => _then(v as _$Deleted));

  @override
  _$Deleted get _value => super._value as _$Deleted;

  @override
  $Res call({
    Object? todo = freezed,
  }) {
    return _then(_$Deleted(
      todo == freezed
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Deleted implements Deleted {
  const _$Deleted(this.todo, {final String? $type})
      : $type = $type ?? 'deleted';

  factory _$Deleted.fromJson(Map<String, dynamic> json) =>
      _$$DeletedFromJson(json);

  @override
  final Todo todo;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEvent.deleted(todo: $todo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Deleted &&
            const DeepCollectionEquality().equals(other.todo, todo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(todo));

  @JsonKey(ignore: true)
  @override
  _$$DeletedCopyWith<_$Deleted> get copyWith =>
      __$$DeletedCopyWithImpl<_$Deleted>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) {
    return deleted(todo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) {
    return deleted?.call(todo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(todo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) {
    return deleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) {
    return deleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) {
    if (deleted != null) {
      return deleted(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DeletedToJson(this);
  }
}

abstract class Deleted implements TodoEvent {
  const factory Deleted(final Todo todo) = _$Deleted;

  factory Deleted.fromJson(Map<String, dynamic> json) = _$Deleted.fromJson;

  Todo get todo;
  @JsonKey(ignore: true)
  _$$DeletedCopyWith<_$Deleted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnDoDeletedCopyWith<$Res> {
  factory _$$UnDoDeletedCopyWith(
          _$UnDoDeleted value, $Res Function(_$UnDoDeleted) then) =
      __$$UnDoDeletedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UnDoDeletedCopyWithImpl<$Res> extends _$TodoEventCopyWithImpl<$Res>
    implements _$$UnDoDeletedCopyWith<$Res> {
  __$$UnDoDeletedCopyWithImpl(
      _$UnDoDeleted _value, $Res Function(_$UnDoDeleted) _then)
      : super(_value, (v) => _then(v as _$UnDoDeleted));

  @override
  _$UnDoDeleted get _value => super._value as _$UnDoDeleted;
}

/// @nodoc
@JsonSerializable()
class _$UnDoDeleted implements UnDoDeleted {
  const _$UnDoDeleted({final String? $type}) : $type = $type ?? 'unDoDeleted';

  factory _$UnDoDeleted.fromJson(Map<String, dynamic> json) =>
      _$$UnDoDeletedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEvent.unDoDeleted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UnDoDeleted);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) {
    return unDoDeleted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) {
    return unDoDeleted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) {
    if (unDoDeleted != null) {
      return unDoDeleted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) {
    return unDoDeleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) {
    return unDoDeleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) {
    if (unDoDeleted != null) {
      return unDoDeleted(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnDoDeletedToJson(this);
  }
}

abstract class UnDoDeleted implements TodoEvent {
  const factory UnDoDeleted() = _$UnDoDeleted;

  factory UnDoDeleted.fromJson(Map<String, dynamic> json) =
      _$UnDoDeleted.fromJson;
}

/// @nodoc
abstract class _$$FilterChangedCopyWith<$Res> {
  factory _$$FilterChangedCopyWith(
          _$FilterChanged value, $Res Function(_$FilterChanged) then) =
      __$$FilterChangedCopyWithImpl<$Res>;
  $Res call({TodoViewFilter filter});
}

/// @nodoc
class __$$FilterChangedCopyWithImpl<$Res> extends _$TodoEventCopyWithImpl<$Res>
    implements _$$FilterChangedCopyWith<$Res> {
  __$$FilterChangedCopyWithImpl(
      _$FilterChanged _value, $Res Function(_$FilterChanged) _then)
      : super(_value, (v) => _then(v as _$FilterChanged));

  @override
  _$FilterChanged get _value => super._value as _$FilterChanged;

  @override
  $Res call({
    Object? filter = freezed,
  }) {
    return _then(_$FilterChanged(
      filter == freezed
          ? _value.filter
          : filter // ignore: cast_nullable_to_non_nullable
              as TodoViewFilter,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FilterChanged implements FilterChanged {
  const _$FilterChanged(this.filter, {final String? $type})
      : $type = $type ?? 'filterChanged';

  factory _$FilterChanged.fromJson(Map<String, dynamic> json) =>
      _$$FilterChangedFromJson(json);

  @override
  final TodoViewFilter filter;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEvent.filterChanged(filter: $filter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterChanged &&
            const DeepCollectionEquality().equals(other.filter, filter));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(filter));

  @JsonKey(ignore: true)
  @override
  _$$FilterChangedCopyWith<_$FilterChanged> get copyWith =>
      __$$FilterChangedCopyWithImpl<_$FilterChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) {
    return filterChanged(filter);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) {
    return filterChanged?.call(filter);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(filter);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) {
    return filterChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) {
    return filterChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) {
    if (filterChanged != null) {
      return filterChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FilterChangedToJson(this);
  }
}

abstract class FilterChanged implements TodoEvent {
  const factory FilterChanged(final TodoViewFilter filter) = _$FilterChanged;

  factory FilterChanged.fromJson(Map<String, dynamic> json) =
      _$FilterChanged.fromJson;

  TodoViewFilter get filter;
  @JsonKey(ignore: true)
  _$$FilterChangedCopyWith<_$FilterChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchCopyWith<$Res> {
  factory _$$SearchCopyWith(_$Search value, $Res Function(_$Search) then) =
      __$$SearchCopyWithImpl<$Res>;
  $Res call({String? search});
}

/// @nodoc
class __$$SearchCopyWithImpl<$Res> extends _$TodoEventCopyWithImpl<$Res>
    implements _$$SearchCopyWith<$Res> {
  __$$SearchCopyWithImpl(_$Search _value, $Res Function(_$Search) _then)
      : super(_value, (v) => _then(v as _$Search));

  @override
  _$Search get _value => super._value as _$Search;

  @override
  $Res call({
    Object? search = freezed,
  }) {
    return _then(_$Search(
      search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Search implements Search {
  const _$Search(this.search, {final String? $type})
      : $type = $type ?? 'search';

  factory _$Search.fromJson(Map<String, dynamic> json) =>
      _$$SearchFromJson(json);

  @override
  final String? search;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEvent.search(search: $search)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Search &&
            const DeepCollectionEquality().equals(other.search, search));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(search));

  @JsonKey(ignore: true)
  @override
  _$$SearchCopyWith<_$Search> get copyWith =>
      __$$SearchCopyWithImpl<_$Search>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) {
    return search(this.search);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) {
    return search?.call(this.search);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this.search);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchToJson(this);
  }
}

abstract class Search implements TodoEvent {
  const factory Search(final String? search) = _$Search;

  factory Search.fromJson(Map<String, dynamic> json) = _$Search.fromJson;

  String? get search;
  @JsonKey(ignore: true)
  _$$SearchCopyWith<_$Search> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleAllCopyWith<$Res> {
  factory _$$ToggleAllCopyWith(
          _$ToggleAll value, $Res Function(_$ToggleAll) then) =
      __$$ToggleAllCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ToggleAllCopyWithImpl<$Res> extends _$TodoEventCopyWithImpl<$Res>
    implements _$$ToggleAllCopyWith<$Res> {
  __$$ToggleAllCopyWithImpl(
      _$ToggleAll _value, $Res Function(_$ToggleAll) _then)
      : super(_value, (v) => _then(v as _$ToggleAll));

  @override
  _$ToggleAll get _value => super._value as _$ToggleAll;
}

/// @nodoc
@JsonSerializable()
class _$ToggleAll implements ToggleAll {
  const _$ToggleAll({final String? $type}) : $type = $type ?? 'toggleAll';

  factory _$ToggleAll.fromJson(Map<String, dynamic> json) =>
      _$$ToggleAllFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEvent.toggleAll()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ToggleAll);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) {
    return toggleAll();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) {
    return toggleAll?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) {
    if (toggleAll != null) {
      return toggleAll();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) {
    return toggleAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) {
    return toggleAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) {
    if (toggleAll != null) {
      return toggleAll(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ToggleAllToJson(this);
  }
}

abstract class ToggleAll implements TodoEvent {
  const factory ToggleAll() = _$ToggleAll;

  factory ToggleAll.fromJson(Map<String, dynamic> json) = _$ToggleAll.fromJson;
}

/// @nodoc
abstract class _$$ClearCompletedCopyWith<$Res> {
  factory _$$ClearCompletedCopyWith(
          _$ClearCompleted value, $Res Function(_$ClearCompleted) then) =
      __$$ClearCompletedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearCompletedCopyWithImpl<$Res> extends _$TodoEventCopyWithImpl<$Res>
    implements _$$ClearCompletedCopyWith<$Res> {
  __$$ClearCompletedCopyWithImpl(
      _$ClearCompleted _value, $Res Function(_$ClearCompleted) _then)
      : super(_value, (v) => _then(v as _$ClearCompleted));

  @override
  _$ClearCompleted get _value => super._value as _$ClearCompleted;
}

/// @nodoc
@JsonSerializable()
class _$ClearCompleted implements ClearCompleted {
  const _$ClearCompleted({final String? $type})
      : $type = $type ?? 'clearCompleted';

  factory _$ClearCompleted.fromJson(Map<String, dynamic> json) =>
      _$$ClearCompletedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEvent.clearCompleted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearCompleted);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() subscriptionRequested,
    required TResult Function(Todo todo, bool isCompleted) completionToggled,
    required TResult Function(Todo todo) deleted,
    required TResult Function() unDoDeleted,
    required TResult Function(TodoViewFilter filter) filterChanged,
    required TResult Function(String? search) search,
    required TResult Function() toggleAll,
    required TResult Function() clearCompleted,
  }) {
    return clearCompleted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
  }) {
    return clearCompleted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? subscriptionRequested,
    TResult Function(Todo todo, bool isCompleted)? completionToggled,
    TResult Function(Todo todo)? deleted,
    TResult Function()? unDoDeleted,
    TResult Function(TodoViewFilter filter)? filterChanged,
    TResult Function(String? search)? search,
    TResult Function()? toggleAll,
    TResult Function()? clearCompleted,
    required TResult orElse(),
  }) {
    if (clearCompleted != null) {
      return clearCompleted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SubscriptionRequested value)
        subscriptionRequested,
    required TResult Function(CompletionToggled value) completionToggled,
    required TResult Function(Deleted value) deleted,
    required TResult Function(UnDoDeleted value) unDoDeleted,
    required TResult Function(FilterChanged value) filterChanged,
    required TResult Function(Search value) search,
    required TResult Function(ToggleAll value) toggleAll,
    required TResult Function(ClearCompleted value) clearCompleted,
  }) {
    return clearCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
  }) {
    return clearCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SubscriptionRequested value)? subscriptionRequested,
    TResult Function(CompletionToggled value)? completionToggled,
    TResult Function(Deleted value)? deleted,
    TResult Function(UnDoDeleted value)? unDoDeleted,
    TResult Function(FilterChanged value)? filterChanged,
    TResult Function(Search value)? search,
    TResult Function(ToggleAll value)? toggleAll,
    TResult Function(ClearCompleted value)? clearCompleted,
    required TResult orElse(),
  }) {
    if (clearCompleted != null) {
      return clearCompleted(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ClearCompletedToJson(this);
  }
}

abstract class ClearCompleted implements TodoEvent {
  const factory ClearCompleted() = _$ClearCompleted;

  factory ClearCompleted.fromJson(Map<String, dynamic> json) =
      _$ClearCompleted.fromJson;
}
