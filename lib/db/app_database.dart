// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:oplin/db/converter.dart';
import 'package:oplin/db/dao/todo_dao.dart';
import 'package:oplin/db/models.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart'; // the generated code will be there

@TypeConverters([TodoLevelConverter])
@Database(version: 1, entities: [Todo])
@injectable
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;

  @factoryMethod
  static Future<AppDatabase> getAppDatabase() async {
    // return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
  }
}
