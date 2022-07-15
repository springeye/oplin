// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i6;

import '../../bloc/app_cubit.dart' as _i3;
import '../../bloc/book_bloc.dart' as _i18;
import '../../bloc/edit_note_bloc.dart' as _i5;
import '../../bloc/note_bloc.dart' as _i19;
import '../../bloc/sync_bloc.dart' as _i20;
import '../../bloc/todo.edit.bloc.dart' as _i17;
import '../../bloc/todo_bloc.dart' as _i16;
import '../../db/app_database.dart' as _i4;
import '../../db/dao/todo_dao.dart' as _i9;
import '../../repository/book_repository.dart' as _i13;
import '../../repository/note_repository.dart' as _i7;
import '../../repository/storage/isar_book_repository.dart' as _i14;
import '../../repository/storage/isar_note_repository.dart' as _i8;
import '../../repository/storage/Isar_todo_repository.dart' as _i11;
import '../../repository/storage/sqlite_book_repository.dart' as _i15;
import '../../repository/storage/sqlite_todo_repository.dart' as _i12;
import '../../repository/todo_repository.dart' as _i10;
import 'dependencie_manager.dart'
    as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singletonAsync<_i3.AppConfig>(() => registerModule.appConfig);
  gh.singletonAsync<_i3.AppCubit>(
      () async => _i3.AppCubit(await get.getAsync<_i3.AppConfig>()));
  gh.factoryAsync<_i4.AppDatabase>(() => _i4.AppDatabase.getAppDatabase());
  gh.singleton<_i5.EditNoteBloc>(_i5.EditNoteBloc());
  gh.singletonAsync<_i6.Isar>(() => registerModule.isar);
  gh.singletonAsync<_i7.NoteRepository>(
      () async => _i8.IsarNoteRepository(await get.getAsync<_i6.Isar>()));
  gh.singletonAsync<_i9.TodoDao>(() async =>
      registerModule.getTodoDao(await get.getAsync<_i4.AppDatabase>()));
  gh.singletonAsync<_i10.TodoRepository>(
      () async => _i11.IsarTodoRepository(await get.getAsync<_i6.Isar>()));
  gh.singletonAsync<_i10.TodoRepository>(
      () async => _i12.SQLiteTodoRepository(await get.getAsync<_i9.TodoDao>()),
      instanceName: 'sqlite');
  gh.singletonAsync<_i13.BookRepository>(
      () async => _i14.IsarBookRepository(await get.getAsync<_i6.Isar>()));
  gh.singletonAsync<_i13.BookRepository>(
      () async => _i15.SQLiteBookRepository(await get.getAsync<_i9.TodoDao>()),
      instanceName: 'sqlite');
  gh.singletonAsync<_i16.TodoBloc>(() async => _i16.TodoBloc(
      todosRepository:
          await get.getAsync<_i10.TodoRepository>(instanceName: 'sqlite')));
  gh.singletonAsync<_i17.TodoEditBloc>(() async => _i17.TodoEditBloc(
      todosRepository:
          await get.getAsync<_i10.TodoRepository>(instanceName: 'sqlite')));
  gh.singletonAsync<_i18.BookBloc>(() async =>
      _i18.BookBloc(bookRepository: await get.getAsync<_i13.BookRepository>()));
  gh.singletonAsync<_i19.NoteBloc>(() async => _i19.NoteBloc(
      bookBloc: await get.getAsync<_i18.BookBloc>(),
      editLogic: get<_i5.EditNoteBloc>(),
      noteRepository: await get.getAsync<_i7.NoteRepository>()));
  gh.singletonAsync<_i20.SyncCubit>(() async => _i20.SyncCubit(
      await get.getAsync<_i7.NoteRepository>(),
      await get.getAsync<_i18.BookBloc>()));
  return get;
}

class _$RegisterModule extends _i21.RegisterModule {}
