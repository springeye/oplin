import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/isar_repository.dart';
import 'package:oplin/repository/todo_repository.dart';
import 'package:uuid/uuid.dart';

@Singleton(as: TodoRepository)
class IsarTodoRepository extends IsarRepository implements TodoRepository {
  IsarTodoRepository(super.store);

  @override
  Future<int> clearCompleted() async {
    return await store.writeTxn<int>((store) async {
      var todos = await store.todos
          .filter()
          .isCompletedEqualTo(true)
          .and()
          .deletedEqualTo(false)
          .findAll();
      for (var todo in todos) {
        todo.deleted = true;
        todo.synced = false;
      }
      return (await store.todos.putAll(todos)).length;
    });
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    return await store.writeTxn<int>((store) async {
      var todos =
          await store.todos.filter().isCompletedEqualTo(!isCompleted).findAll();
      for (var todo in todos) {
        todo.isCompleted = isCompleted;
      }
      return (await store.todos.putAll(todos)).length;
    });
  }

  @override
  Future<void> deleteTodo(String id) async {
    var todo = store.todos
        .filter()
        .uuidEqualTo(id)
        .and()
        .deletedEqualTo(false)
        .findFirstSync();
    if (todo != null) {
      todo.deleted = true;
      todo.synced = false;
      await store.todos.put(todo);
    }
  }

  @override
  Stream<List<Todo>> getTodos() {
    return store.todos.where().watch(initialReturn: true);
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    if (todo.uuid.isEmpty) {
      todo.id = 0;
      todo.uuid = const Uuid().v4();
    }
    await store.todos.put(todo);
  }
}
