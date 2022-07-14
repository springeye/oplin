import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide freezed;
import 'package:injectable/injectable.dart';
import 'package:oplin/bloc/todo_view_filter.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/todo_repository.dart';

part 'todo_bloc.freezed.dart';

part 'todo_bloc.g.dart';

const freezed =
    Freezed(fromJson: true, toJson: true, toStringOverride: true, equal: true);

@singleton
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc({
    required TodoRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(TodoState.initial()) {
    on<TodoEvent>((event, emit) {
      event.map(
          subscriptionRequested: (event) =>
              _onSubscriptionRequested(event, emit),
          completionToggled: (event) => _onTodoCompletionToggled(event, emit),
          deleted: (event) => _onTodoDeleted(event, emit),
          unDoDeleted: (event) => _onUndoDeletionRequested(event, emit),
          filterChanged: (event) => _onFilterChanged(event, emit),
          search: (event) => _onSearch(event, emit),
          toggleAll: (event) => _onToggleAllRequested(event, emit),
          clearCompleted: (event) => _onClearCompletedRequested(event, emit));
    });
  }

  final TodoRepository _todosRepository;

  Future<void> _onSubscriptionRequested(
    SubscriptionRequested event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(status: TodosOverviewStatus.loading));

    await emit.forEach<List<Todo>>(
      _todosRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: TodosOverviewStatus.success,
        todos: todos,
      ),
      onError: (_, __) => state.copyWith(
        status: TodosOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onTodoCompletionToggled(
    CompletionToggled event,
    Emitter<TodoState> emit,
  ) async {
    final newTodo = event.todo.copyWith(isCompleted: event.isCompleted);
    await _todosRepository.saveTodo(newTodo);
  }

  Future<void> _onTodoDeleted(
    Deleted event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(lastDeletedTodo: event.todo));
    await _todosRepository.deleteTodo(event.todo.uuid);
  }

  Future<void> _onUndoDeletionRequested(
    UnDoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    assert(
      state.lastDeletedTodo != null,
      'Last deleted todo can not be null.',
    );

    final todo = state.lastDeletedTodo!;
    emit(state.copyWith(lastDeletedTodo: null));
    await _todosRepository.saveTodo(todo);
  }

  void _onFilterChanged(
    FilterChanged event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onToggleAllRequested(
    ToggleAll event,
    Emitter<TodoState> emit,
  ) async {
    final areAllCompleted = state.todos.every((todo) => todo.isCompleted);
    await _todosRepository.completeAll(isCompleted: !areAllCompleted);
  }

  Future<void> _onClearCompletedRequested(
    ClearCompleted event,
    Emitter<TodoState> emit,
  ) async {
    await _todosRepository.clearCompleted();
  }

  FutureOr<void> _onSearch(Search event, Emitter<TodoState> emit) {
    appLog.debug('Searching for ${event.search}');
    emit(state.copyWith(search: event.search));
  }
}

enum TodosOverviewStatus { initial, loading, success, failure }

@freezed
abstract class TodoState with _$TodoState {
  const TodoState._();

  const factory TodoState(
      {required TodosOverviewStatus status,
      required List<Todo> todos,
      String? search,
      required TodoViewFilter filter,
      Todo? lastDeletedTodo}) = _TodoState;

  factory TodoState.initial() => const TodoState(
        status: TodosOverviewStatus.initial,
        todos: [],
        search: null,
        filter: TodoViewFilter.all,
        lastDeletedTodo: null,
      );

  Iterable<Todo> get filteredTodos => filter.applyAll(todos);
}

@freezed
class TodoEvent with _$TodoEvent {
  const factory TodoEvent.subscriptionRequested() = SubscriptionRequested;

  const factory TodoEvent.completionToggled(Todo todo, bool isCompleted) =
      CompletionToggled;

  const factory TodoEvent.deleted(Todo todo) = Deleted;

  const factory TodoEvent.unDoDeleted() = UnDoDeleted;

  const factory TodoEvent.filterChanged(TodoViewFilter filter) = FilterChanged;

  const factory TodoEvent.search(String? search) = Search;

  const factory TodoEvent.toggleAll() = ToggleAll;

  const factory TodoEvent.clearCompleted() = ClearCompleted;

  factory TodoEvent.fromJson(Map<String, Object?> json) =>
      _$TodoEventFromJson(json);
}
