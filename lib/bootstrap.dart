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
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/db/objectbox.g.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:oplin/repository/storage/storage_note_repository.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/app_cubit.dart';
import 'bloc/notebook_cubit.dart';
import 'bloc/sync_cubit.dart';

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
          var store =
              await openStore(directory: (await getTemporaryDirectory()).path);
          NoteRepository noteRepository = StorageNoteRepository(store);
          NoteBloc noteLogic = NoteBloc(
            noteRepository: noteRepository,
          );
          NotebookCubit notebookLogic = NotebookCubit(store);
          AppConfig appConfig = await AppCubit.getDefaultConfig();
          runApp(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AppCubit(appConfig)),
                BlocProvider(create: (context) {
                  return noteLogic;
                }),
                BlocProvider(create: (context) {
                  return notebookLogic;
                }),
                BlocProvider(
                    create: (context) =>
                        SyncCubit(noteRepository, notebookLogic)),
              ],
              child: RepositoryProvider(
                create: (context) => noteRepository,
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
