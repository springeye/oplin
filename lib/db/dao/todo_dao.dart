import 'package:floor/floor.dart';
import 'package:oplin/db/models.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM Todo')
  Stream<List<Todo>> subscribeAll();

  @Query('SELECT * FROM Todo')
  Future<List<Todo>> findAll();

  @Query('SELECT * FROM Todo where uuid = :id')
  Future<Todo?> findById(String id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> put(Todo todo);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> putAll(List<Todo> todos);
}
