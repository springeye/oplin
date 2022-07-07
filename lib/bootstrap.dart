// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/objectbox.g.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:oplin/repository/storage/isar_book_repository.dart';
import 'package:oplin/repository/storage/isar_note_repository.dart';
import 'package:oplin/repository/storage/storage_book_repository.dart';
import 'package:oplin/repository/storage/storage_note_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:oplin/db/models.dart';
import 'bloc/app_cubit.dart';
import 'bloc/sync_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    appLog.debug('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    appLog.debug('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async {
          var store = await openStore(
              directory: (await getApplicationSupportDirectory()).path);
          Isar isar = await Isar.open(
            [BookSchema, NoteSchema],
            directory: (await getApplicationSupportDirectory()).path,
          );
          // NoteRepository noteRepository = StorageNoteRepository(store);
          // BookRepository bookRepository = StorageBookRepository(store);
          NoteRepository noteRepository = IsarNoteRepository(isar);
          BookRepository bookRepository = IsarBookRepository(isar);
          BookBloc bookLogic = BookBloc(bookRepository: bookRepository);
          EditNoteBloc showBloc = EditNoteBloc();
          NoteBloc noteLogic = NoteBloc(
              noteRepository: noteRepository,
              editLogic: showBloc,
              bookBloc: bookLogic);
          AppConfig appConfig = await AppCubit.getDefaultConfig();
          runApp(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AppCubit(appConfig)),
                BlocProvider(create: (context) => showBloc),
                BlocProvider(create: (context) => noteLogic),
                BlocProvider(create: (context) => bookLogic),
                BlocProvider(
                  create: (context) => SyncCubit(noteRepository, bookLogic),
                ),
              ],
              child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider<BookRepository>(
                    create: (context) => bookRepository,
                  ),
                  RepositoryProvider<NoteRepository>(
                    create: (context) => noteRepository,
                  ),
                ],
                child: await builder(),
              ),
            ),
          );
        },
        blocObserver: AppBlocObserver(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
