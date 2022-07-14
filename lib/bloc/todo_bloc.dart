import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:oplin/bloc/todo_view_filter.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/todo_repository.dart';

import 'todo_event.dart';

part 'todo_state.dart';

@singleton
class TodosOverviewBloc extends Bloc<TodoEvent, TodoState> {
  TodosOverviewBloc({
    required TodoRepository todosRepository,
  })  : _todosRepository = todosRepository,
        super(const TodoState()) {
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
    emit(state.copyWith(status: () => TodosOverviewStatus.loading));

    await emit.forEach<List<Todo>>(
      _todosRepository.getTodos(),
      onData: (todos) => state.copyWith(
        status: () => TodosOverviewStatus.success,
        todos: () => todos,
      ),
      onError: (_, __) => state.copyWith(
        status: () => TodosOverviewStatus.failure,
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
    emit(state.copyWith(lastDeletedTodo: () => event.todo));
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
    emit(state.copyWith(lastDeletedTodo: () => null));
    await _todosRepository.saveTodo(todo);
  }

  void _onFilterChanged(
    FilterChanged event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
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
    emit(state.copyWith(search: () => event.search));
  }
}
