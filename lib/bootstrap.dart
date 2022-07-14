// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oplin/bloc/book_bloc.dart';
import 'package:oplin/bloc/edit_note_bloc.dart';
import 'package:oplin/bloc/note_bloc.dart';
import 'package:oplin/bloc/todo_bloc.dart';
import 'package:oplin/common/di/dependencie_manager.dart';
import 'package:oplin/common/logging.dart';
import 'package:oplin/common/fonts.dart';
import 'package:oplin/repository/book_repository.dart';
import 'package:oplin/repository/note_repository.dart';
import 'package:oplin/repository/todo_repository.dart';

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
  configureDependencies();
  await runZonedGuarded(
    () async {
      loadRemoteFonts();
      NoteRepository noteRepository = await getIt.getAsync<NoteRepository>();
      BookRepository bookRepository = await getIt.getAsync<BookRepository>();
      TodoRepository todoRepository = await getIt.getAsync<TodoRepository>();
      BookBloc bookLogic = await getIt.getAsync<BookBloc>();
      EditNoteBloc showBloc = getIt.get<EditNoteBloc>();
      NoteBloc noteLogic = await getIt.getAsync<NoteBloc>();
      AppCubit appCubit = await getIt.getAsync<AppCubit>();
      SyncCubit syncCubit = await getIt.getAsync<SyncCubit>();
      TodosOverviewBloc todoBloc = await getIt.getAsync<TodosOverviewBloc>();
      await BlocOverrides.runZoned(
        () async {
          runApp(
            MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => appCubit),
                BlocProvider(create: (context) => showBloc),
                BlocProvider(create: (context) => noteLogic),
                BlocProvider(create: (context) => bookLogic),
                BlocProvider(create: (context) => todoBloc),
                BlocProvider(create: (context) => syncCubit),
              ],
              child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(create: (context) => bookRepository),
                  RepositoryProvider(create: (context) => noteRepository),
                  RepositoryProvider(create: (context) => todoRepository),
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
