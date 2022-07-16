import 'package:floor/floor.dart';
import 'package:oplin/db/dao/sqlite_dao.dart';
import 'package:oplin/db/models.dart';

@dao
abstract class TodoDao extends SQLiteDao<Todo> {
  @Query('SELECT * FROM Todo order by isCompleted, createTime desc ')
  Stream<List<Todo>> subscribeAll();

  @Query('SELECT * FROM Todo order by isCompleted,createTime desc ')
  Future<List<Todo>> findAll();

  @Query('SELECT * FROM Todo where uuid = :id')
  Future<Todo?> findById(String id);
}
