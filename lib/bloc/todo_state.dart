part of 'todo_bloc.dart';

enum TodosOverviewStatus { initial, loading, success, failure }

class TodoState extends Equatable {
  const TodoState({
    this.status = TodosOverviewStatus.initial,
    this.todos = const [],
    this.search,
    this.filter = TodoViewFilter.all,
    this.lastDeletedTodo,
  });

  final TodosOverviewStatus status;
  final List<Todo> todos;
  final TodoViewFilter filter;
  final String? search;
  final Todo? lastDeletedTodo;

  Iterable<Todo> get filteredTodos => filter.applyAll(todos);

  TodoState copyWith({
    TodosOverviewStatus Function()? status,
    List<Todo> Function()? todos,
    TodoViewFilter Function()? filter,
    String? Function()? search,
    Todo? Function()? lastDeletedTodo,
  }) {
    return TodoState(
      status: status != null ? status() : this.status,
      todos: todos != null ? todos() : this.todos,
      filter: filter != null ? filter() : this.filter,
      search: search != null ? search() : this.search,
      lastDeletedTodo:
          lastDeletedTodo != null ? lastDeletedTodo() : this.lastDeletedTodo,
    );
  }

  @override
  List<Object?> get props => [
        status,
        todos,
        filter,
        search,
        lastDeletedTodo,
      ];
}
