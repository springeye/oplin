// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Todo` (`id` INTEGER NOT NULL, `uuid` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `isCompleted` INTEGER NOT NULL, `synced` INTEGER NOT NULL, `deleted` INTEGER NOT NULL, `sticky` INTEGER NOT NULL, `level` TEXT NOT NULL, `parentId` TEXT, PRIMARY KEY (`uuid`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _todoInsertionAdapter = InsertionAdapter(
            database,
            'Todo',
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'uuid': item.uuid,
                  'title': item.title,
                  'description': item.description,
                  'isCompleted': item.isCompleted ? 1 : 0,
                  'synced': item.synced ? 1 : 0,
                  'deleted': item.deleted ? 1 : 0,
                  'sticky': item.sticky ? 1 : 0,
                  'level': _todoLevelConverter.encode(item.level),
                  'parentId': item.parentId
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  @override
  Stream<List<Todo>> subscribeAll() {
    return _queryAdapter.queryListStream('SELECT * FROM Todo',
        mapper: (Map<String, Object?> row) => Todo(
            id: row['id'] as int,
            uuid: row['uuid'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            isCompleted: (row['isCompleted'] as int) != 0,
            synced: (row['synced'] as int) != 0,
            deleted: (row['deleted'] as int) != 0,
            sticky: (row['sticky'] as int) != 0,
            level: _todoLevelConverter.decode(row['level'] as String),
            parentId: row['parentId'] as String?),
        queryableName: 'Todo',
        isView: false);
  }

  @override
  Future<List<Todo>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM Todo',
        mapper: (Map<String, Object?> row) => Todo(
            id: row['id'] as int,
            uuid: row['uuid'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            isCompleted: (row['isCompleted'] as int) != 0,
            synced: (row['synced'] as int) != 0,
            deleted: (row['deleted'] as int) != 0,
            sticky: (row['sticky'] as int) != 0,
            level: _todoLevelConverter.decode(row['level'] as String),
            parentId: row['parentId'] as String?));
  }

  @override
  Future<Todo?> findById(String id) async {
    return _queryAdapter.query('SELECT * FROM Todo where uuid = ?1',
        mapper: (Map<String, Object?> row) => Todo(
            id: row['id'] as int,
            uuid: row['uuid'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            isCompleted: (row['isCompleted'] as int) != 0,
            synced: (row['synced'] as int) != 0,
            deleted: (row['deleted'] as int) != 0,
            sticky: (row['sticky'] as int) != 0,
            level: _todoLevelConverter.decode(row['level'] as String),
            parentId: row['parentId'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> put(Todo todo) async {
    await _todoInsertionAdapter.insert(todo, OnConflictStrategy.replace);
  }

  @override
  Future<void> putAll(List<Todo> todos) async {
    await _todoInsertionAdapter.insertList(todos, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _todoLevelConverter = TodoLevelConverter();
