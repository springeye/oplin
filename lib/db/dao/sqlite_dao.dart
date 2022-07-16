import 'package:floor/floor.dart';

abstract class SQLiteDao<T> {
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> putOne(T item);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> putMany(List<T> items);

  @delete
  Future<void> deleteOne(T item);

  @delete
  Future<int> deleteMany(List<T> persons);
}
