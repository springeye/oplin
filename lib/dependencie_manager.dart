import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:oplin/bloc/app_cubit.dart';
import 'package:oplin/dependencie_manager.config.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'db/models.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);

@module
abstract class RegisterModule {
  @singleton
  Future<Isar> get isar async => await Isar.open(
        schemas: [BookSchema, NoteSchema],
        directory: (await getApplicationSupportDirectory()).path,
      );

  @singleton
  Future<AppConfig> get appConfig async => await AppCubit.getDefaultConfig();
}
