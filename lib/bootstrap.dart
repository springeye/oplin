// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/dependencie_manager.dart';
import 'package:oplin/fonts.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:oplin/repository/storage/isar_book_repository.dart';
import 'package:oplin/repository/storage/isar_note_repository.dart';
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
    // log(details.exceptionAsString(), stackTrace: details.stack);
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      loadRemoteFonts();
      NoteRepository noteRepository = await getIt.getAsync<NoteRepository>();
      BookRepository bookRepository = await getIt.getAsync<BookRepository>();
      BookBloc bookLogic = await getIt.getAsync<BookBloc>();
      EditNoteBloc showBloc = getIt.get<EditNoteBloc>();
      NoteBloc noteLogic = await getIt.getAsync<NoteBloc>();
      AppCubit appCubit = await getIt.getAsync<AppCubit>();
      SyncCubit syncCubit = await getIt.getAsync<SyncCubit>();
      await BlocOverrides.runZoned(
        () async {
          runApp(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => appCubit),
                BlocProvider(create: (context) => showBloc),
                BlocProvider(create: (context) => noteLogic),
                BlocProvider(create: (context) => bookLogic),
                BlocProvider(
                  create: (context) => syncCubit,
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
    (error, stackTrace) => FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stackTrace)),
  );
}
