import 'package:oplin/db/models.dart';

enum TodoViewFilter { all, activeOnly, completedOnly }

extension TodoViewFilterX on TodoViewFilter {
  bool apply(Todo todo) {
    switch (this) {
      case TodoViewFilter.all:
        return true;
      case TodoViewFilter.activeOnly:
        return !todo.isCompleted;
      case TodoViewFilter.completedOnly:
        return todo.isCompleted;
    }
  }

  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}
