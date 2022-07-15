// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo.edit.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TodoEditState _$TodoEditStateFromJson(Map<String, dynamic> json) {
  return _TodoEditState.fromJson(json);
}

/// @nodoc
mixin _$TodoEditState {
  EditTodoStatus get status => throw _privateConstructorUsedError;
  Todo? get initialTodo => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoEditStateCopyWith<TodoEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoEditStateCopyWith<$Res> {
  factory $TodoEditStateCopyWith(
          TodoEditState value, $Res Function(TodoEditState) then) =
      _$TodoEditStateCopyWithImpl<$Res>;
  $Res call(
      {EditTodoStatus status,
      Todo? initialTodo,
      String? title,
      String? description});
}

/// @nodoc
class _$TodoEditStateCopyWithImpl<$Res>
    implements $TodoEditStateCopyWith<$Res> {
  _$TodoEditStateCopyWithImpl(this._value, this._then);

  final TodoEditState _value;
  // ignore: unused_field
  final $Res Function(TodoEditState) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? initialTodo = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EditTodoStatus,
      initialTodo: initialTodo == freezed
          ? _value.initialTodo
          : initialTodo // ignore: cast_nullable_to_non_nullable
              as Todo?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$$_TodoEditStateCopyWith<$Res>
    implements $TodoEditStateCopyWith<$Res> {
  factory _$$_TodoEditStateCopyWith(
          _$_TodoEditState value, $Res Function(_$_TodoEditState) then) =
      __$$_TodoEditStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {EditTodoStatus status,
      Todo? initialTodo,
      String? title,
      String? description});
}

/// @nodoc
class __$$_TodoEditStateCopyWithImpl<$Res>
    extends _$TodoEditStateCopyWithImpl<$Res>
    implements _$$_TodoEditStateCopyWith<$Res> {
  __$$_TodoEditStateCopyWithImpl(
      _$_TodoEditState _value, $Res Function(_$_TodoEditState) _then)
      : super(_value, (v) => _then(v as _$_TodoEditState));

  @override
  _$_TodoEditState get _value => super._value as _$_TodoEditState;

  @override
  $Res call({
    Object? status = freezed,
    Object? initialTodo = freezed,
    Object? title = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_TodoEditState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as EditTodoStatus,
      initialTodo: initialTodo == freezed
          ? _value.initialTodo
          : initialTodo // ignore: cast_nullable_to_non_nullable
              as Todo?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TodoEditState extends _TodoEditState {
  const _$_TodoEditState(
      {required this.status, this.initialTodo, this.title, this.description})
      : super._();

  factory _$_TodoEditState.fromJson(Map<String, dynamic> json) =>
      _$$_TodoEditStateFromJson(json);

  @override
  final EditTodoStatus status;
  @override
  final Todo? initialTodo;
  @override
  final String? title;
  @override
  final String? description;

  @override
  String toString() {
    return 'TodoEditState(status: $status, initialTodo: $initialTodo, title: $title, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TodoEditState &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.initialTodo, initialTodo) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(initialTodo),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$$_TodoEditStateCopyWith<_$_TodoEditState> get copyWith =>
      __$$_TodoEditStateCopyWithImpl<_$_TodoEditState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoEditStateToJson(this);
  }
}

abstract class _TodoEditState extends TodoEditState {
  const factory _TodoEditState(
      {required final EditTodoStatus status,
      final Todo? initialTodo,
      final String? title,
      final String? description}) = _$_TodoEditState;
  const _TodoEditState._() : super._();

  factory _TodoEditState.fromJson(Map<String, dynamic> json) =
      _$_TodoEditState.fromJson;

  @override
  EditTodoStatus get status;
  @override
  Todo? get initialTodo;
  @override
  String? get title;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_TodoEditStateCopyWith<_$_TodoEditState> get copyWith =>
      throw _privateConstructorUsedError;
}

TodoEditEvent _$TodoEditEventFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'titleChanged':
      return TitleChanged.fromJson(json);
    case 'descriptionChanged':
      return DescriptionChanged.fromJson(json);
    case 'submitted':
      return Submitted.fromJson(json);
    case 'created':
      return Created.fromJson(json);
    case 'current':
      return Current.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'TodoEditEvent',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$TodoEditEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function() submitted,
    required TResult Function() created,
    required TResult Function(Todo? todo) current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(Submitted value) submitted,
    required TResult Function(Created value) created,
    required TResult Function(Current value) current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoEditEventCopyWith<$Res> {
  factory $TodoEditEventCopyWith(
          TodoEditEvent value, $Res Function(TodoEditEvent) then) =
      _$TodoEditEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$TodoEditEventCopyWithImpl<$Res>
    implements $TodoEditEventCopyWith<$Res> {
  _$TodoEditEventCopyWithImpl(this._value, this._then);

  final TodoEditEvent _value;
  // ignore: unused_field
  final $Res Function(TodoEditEvent) _then;
}

/// @nodoc
abstract class _$$TitleChangedCopyWith<$Res> {
  factory _$$TitleChangedCopyWith(
          _$TitleChanged value, $Res Function(_$TitleChanged) then) =
      __$$TitleChangedCopyWithImpl<$Res>;
  $Res call({String title});
}

/// @nodoc
class __$$TitleChangedCopyWithImpl<$Res>
    extends _$TodoEditEventCopyWithImpl<$Res>
    implements _$$TitleChangedCopyWith<$Res> {
  __$$TitleChangedCopyWithImpl(
      _$TitleChanged _value, $Res Function(_$TitleChanged) _then)
      : super(_value, (v) => _then(v as _$TitleChanged));

  @override
  _$TitleChanged get _value => super._value as _$TitleChanged;

  @override
  $Res call({
    Object? title = freezed,
  }) {
    return _then(_$TitleChanged(
      title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TitleChanged implements TitleChanged {
  const _$TitleChanged(this.title, {final String? $type})
      : $type = $type ?? 'titleChanged';

  factory _$TitleChanged.fromJson(Map<String, dynamic> json) =>
      _$$TitleChangedFromJson(json);

  @override
  final String title;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEditEvent.titleChanged(title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TitleChanged &&
            const DeepCollectionEquality().equals(other.title, title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(title));

  @JsonKey(ignore: true)
  @override
  _$$TitleChangedCopyWith<_$TitleChanged> get copyWith =>
      __$$TitleChangedCopyWithImpl<_$TitleChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function() submitted,
    required TResult Function() created,
    required TResult Function(Todo? todo) current,
  }) {
    return titleChanged(title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
  }) {
    return titleChanged?.call(title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
    required TResult orElse(),
  }) {
    if (titleChanged != null) {
      return titleChanged(title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(Submitted value) submitted,
    required TResult Function(Created value) created,
    required TResult Function(Current value) current,
  }) {
    return titleChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
  }) {
    return titleChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
    required TResult orElse(),
  }) {
    if (titleChanged != null) {
      return titleChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TitleChangedToJson(this);
  }
}

abstract class TitleChanged implements TodoEditEvent {
  const factory TitleChanged(final String title) = _$TitleChanged;

  factory TitleChanged.fromJson(Map<String, dynamic> json) =
      _$TitleChanged.fromJson;

  String get title;
  @JsonKey(ignore: true)
  _$$TitleChangedCopyWith<_$TitleChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DescriptionChangedCopyWith<$Res> {
  factory _$$DescriptionChangedCopyWith(_$DescriptionChanged value,
          $Res Function(_$DescriptionChanged) then) =
      __$$DescriptionChangedCopyWithImpl<$Res>;
  $Res call({String description});
}

/// @nodoc
class __$$DescriptionChangedCopyWithImpl<$Res>
    extends _$TodoEditEventCopyWithImpl<$Res>
    implements _$$DescriptionChangedCopyWith<$Res> {
  __$$DescriptionChangedCopyWithImpl(
      _$DescriptionChanged _value, $Res Function(_$DescriptionChanged) _then)
      : super(_value, (v) => _then(v as _$DescriptionChanged));

  @override
  _$DescriptionChanged get _value => super._value as _$DescriptionChanged;

  @override
  $Res call({
    Object? description = freezed,
  }) {
    return _then(_$DescriptionChanged(
      description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DescriptionChanged implements DescriptionChanged {
  const _$DescriptionChanged(this.description, {final String? $type})
      : $type = $type ?? 'descriptionChanged';

  factory _$DescriptionChanged.fromJson(Map<String, dynamic> json) =>
      _$$DescriptionChangedFromJson(json);

  @override
  final String description;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEditEvent.descriptionChanged(description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DescriptionChanged &&
            const DeepCollectionEquality()
                .equals(other.description, description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(description));

  @JsonKey(ignore: true)
  @override
  _$$DescriptionChangedCopyWith<_$DescriptionChanged> get copyWith =>
      __$$DescriptionChangedCopyWithImpl<_$DescriptionChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function() submitted,
    required TResult Function() created,
    required TResult Function(Todo? todo) current,
  }) {
    return descriptionChanged(description);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
  }) {
    return descriptionChanged?.call(description);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
    required TResult orElse(),
  }) {
    if (descriptionChanged != null) {
      return descriptionChanged(description);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(Submitted value) submitted,
    required TResult Function(Created value) created,
    required TResult Function(Current value) current,
  }) {
    return descriptionChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
  }) {
    return descriptionChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
    required TResult orElse(),
  }) {
    if (descriptionChanged != null) {
      return descriptionChanged(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DescriptionChangedToJson(this);
  }
}

abstract class DescriptionChanged implements TodoEditEvent {
  const factory DescriptionChanged(final String description) =
      _$DescriptionChanged;

  factory DescriptionChanged.fromJson(Map<String, dynamic> json) =
      _$DescriptionChanged.fromJson;

  String get description;
  @JsonKey(ignore: true)
  _$$DescriptionChangedCopyWith<_$DescriptionChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmittedCopyWith<$Res> {
  factory _$$SubmittedCopyWith(
          _$Submitted value, $Res Function(_$Submitted) then) =
      __$$SubmittedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmittedCopyWithImpl<$Res> extends _$TodoEditEventCopyWithImpl<$Res>
    implements _$$SubmittedCopyWith<$Res> {
  __$$SubmittedCopyWithImpl(
      _$Submitted _value, $Res Function(_$Submitted) _then)
      : super(_value, (v) => _then(v as _$Submitted));

  @override
  _$Submitted get _value => super._value as _$Submitted;
}

/// @nodoc
@JsonSerializable()
class _$Submitted implements Submitted {
  const _$Submitted({final String? $type}) : $type = $type ?? 'submitted';

  factory _$Submitted.fromJson(Map<String, dynamic> json) =>
      _$$SubmittedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEditEvent.submitted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Submitted);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function() submitted,
    required TResult Function() created,
    required TResult Function(Todo? todo) current,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(Submitted value) submitted,
    required TResult Function(Created value) created,
    required TResult Function(Current value) current,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SubmittedToJson(this);
  }
}

abstract class Submitted implements TodoEditEvent {
  const factory Submitted() = _$Submitted;

  factory Submitted.fromJson(Map<String, dynamic> json) = _$Submitted.fromJson;
}

/// @nodoc
abstract class _$$CreatedCopyWith<$Res> {
  factory _$$CreatedCopyWith(_$Created value, $Res Function(_$Created) then) =
      __$$CreatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreatedCopyWithImpl<$Res> extends _$TodoEditEventCopyWithImpl<$Res>
    implements _$$CreatedCopyWith<$Res> {
  __$$CreatedCopyWithImpl(_$Created _value, $Res Function(_$Created) _then)
      : super(_value, (v) => _then(v as _$Created));

  @override
  _$Created get _value => super._value as _$Created;
}

/// @nodoc
@JsonSerializable()
class _$Created implements Created {
  const _$Created({final String? $type}) : $type = $type ?? 'created';

  factory _$Created.fromJson(Map<String, dynamic> json) =>
      _$$CreatedFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEditEvent.created()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Created);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function() submitted,
    required TResult Function() created,
    required TResult Function(Todo? todo) current,
  }) {
    return created();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
  }) {
    return created?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(Submitted value) submitted,
    required TResult Function(Created value) created,
    required TResult Function(Current value) current,
  }) {
    return created(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
  }) {
    return created?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
    required TResult orElse(),
  }) {
    if (created != null) {
      return created(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CreatedToJson(this);
  }
}

abstract class Created implements TodoEditEvent {
  const factory Created() = _$Created;

  factory Created.fromJson(Map<String, dynamic> json) = _$Created.fromJson;
}

/// @nodoc
abstract class _$$CurrentCopyWith<$Res> {
  factory _$$CurrentCopyWith(_$Current value, $Res Function(_$Current) then) =
      __$$CurrentCopyWithImpl<$Res>;
  $Res call({Todo? todo});
}

/// @nodoc
class __$$CurrentCopyWithImpl<$Res> extends _$TodoEditEventCopyWithImpl<$Res>
    implements _$$CurrentCopyWith<$Res> {
  __$$CurrentCopyWithImpl(_$Current _value, $Res Function(_$Current) _then)
      : super(_value, (v) => _then(v as _$Current));

  @override
  _$Current get _value => super._value as _$Current;

  @override
  $Res call({
    Object? todo = freezed,
  }) {
    return _then(_$Current(
      todo == freezed
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Current implements Current {
  const _$Current(this.todo, {final String? $type})
      : $type = $type ?? 'current';

  factory _$Current.fromJson(Map<String, dynamic> json) =>
      _$$CurrentFromJson(json);

  @override
  final Todo? todo;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TodoEditEvent.current(todo: $todo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Current &&
            const DeepCollectionEquality().equals(other.todo, todo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(todo));

  @JsonKey(ignore: true)
  @override
  _$$CurrentCopyWith<_$Current> get copyWith =>
      __$$CurrentCopyWithImpl<_$Current>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String title) titleChanged,
    required TResult Function(String description) descriptionChanged,
    required TResult Function() submitted,
    required TResult Function() created,
    required TResult Function(Todo? todo) current,
  }) {
    return current(todo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
  }) {
    return current?.call(todo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String title)? titleChanged,
    TResult Function(String description)? descriptionChanged,
    TResult Function()? submitted,
    TResult Function()? created,
    TResult Function(Todo? todo)? current,
    required TResult orElse(),
  }) {
    if (current != null) {
      return current(todo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TitleChanged value) titleChanged,
    required TResult Function(DescriptionChanged value) descriptionChanged,
    required TResult Function(Submitted value) submitted,
    required TResult Function(Created value) created,
    required TResult Function(Current value) current,
  }) {
    return current(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
  }) {
    return current?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TitleChanged value)? titleChanged,
    TResult Function(DescriptionChanged value)? descriptionChanged,
    TResult Function(Submitted value)? submitted,
    TResult Function(Created value)? created,
    TResult Function(Current value)? current,
    required TResult orElse(),
  }) {
    if (current != null) {
      return current(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrentToJson(this);
  }
}

abstract class Current implements TodoEditEvent {
  const factory Current(final Todo? todo) = _$Current;

  factory Current.fromJson(Map<String, dynamic> json) = _$Current.fromJson;

  Todo? get todo;
  @JsonKey(ignore: true)
  _$$CurrentCopyWith<_$Current> get copyWith =>
      throw _privateConstructorUsedError;
}
