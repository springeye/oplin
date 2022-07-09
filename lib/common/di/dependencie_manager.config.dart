// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i5;

import '../../bloc/app_cubit.dart' as _i3;
import '../../bloc/book_bloc.dart' as _i10;
import '../../bloc/edit_note_bloc.dart' as _i4;
import '../../bloc/note_bloc.dart' as _i11;
import '../../bloc/sync_bloc.dart' as _i12;
import '../../repository/book_repository.dart' as _i8;
import '../../repository/note_repository.dart' as _i6;
import '../../repository/storage/isar_book_repository.dart' as _i9;
import '../../repository/storage/isar_note_repository.dart' as _i7;
import 'dependencie_manager.dart'
    as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singletonAsync<_i3.AppConfig>(() => registerModule.appConfig);
  gh.singletonAsync<_i3.AppCubit>(
      () async => _i3.AppCubit(await get.getAsync<_i3.AppConfig>()));
  gh.singleton<_i4.EditNoteBloc>(_i4.EditNoteBloc());
  gh.singletonAsync<_i5.Isar>(() => registerModule.isar);
  gh.singletonAsync<_i6.NoteRepository>(
      () async => _i7.IsarNoteRepository(await get.getAsync<_i5.Isar>()));
  gh.singletonAsync<_i8.BookRepository>(
      () async => _i9.IsarBookRepository(await get.getAsync<_i5.Isar>()));
  gh.singletonAsync<_i10.BookBloc>(() async =>
      _i10.BookBloc(bookRepository: await get.getAsync<_i8.BookRepository>()));
  gh.singletonAsync<_i11.NoteBloc>(() async => _i11.NoteBloc(
      bookBloc: await get.getAsync<_i10.BookBloc>(),
      editLogic: get<_i4.EditNoteBloc>(),
      noteRepository: await get.getAsync<_i6.NoteRepository>()));
  gh.singletonAsync<_i12.SyncCubit>(() async => _i12.SyncCubit(
      await get.getAsync<_i6.NoteRepository>(),
      await get.getAsync<_i10.BookBloc>()));
  return get;
}

class _$RegisterModule extends _i13.RegisterModule {}
