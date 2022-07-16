import 'package:injectable/injectable.dart';
import 'package:oplin/db/dao/todo_dao.dart';
import 'package:oplin/db/models.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/db/dao/sqlite_dao.dart';
import 'package:oplin/repository/todo_repository.dart';

@Named("sqlite")
@Singleton(as: TodoRepository)
class SQLiteTodoRepository implements TodoRepository {
  final TodoDao todoDao;

  SQLiteTodoRepository(this.todoDao);

  @override
  Future<int> clearCompleted() async {
    var notes = await todoDao.findAll().then(
        (results) => results.where((element) => element.isCompleted).toList());
    for (var element in notes) {
      element.deleted = true;
      element.synced = false;
    }
    await todoDao.putMany(notes.toList());
    return notes.length;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    var notes = await todoDao.findAll().then(
        (results) => results.where((element) => !element.isCompleted).toList());
    for (var element in notes) {
      element.isCompleted = true;
      element.synced = false;
    }
    await todoDao.putMany(notes.toList());
    return notes.length;
  }

  @override
  Future<void> deleteTodo(String id) async {
    var todo = await todoDao.findById(id);
    if (todo != null) {
      todo.deleted = true;
      todo.synced = false;
      await todoDao.putOne(todo);
    }
  }

  @override
  Stream<List<Todo>> getTodos() {
    return todoDao.subscribeAll();
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    await todoDao.putOne(todo);
  }
}
