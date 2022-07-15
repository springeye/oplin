import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:oplin/bloc/app_cubit.dart';
import 'package:oplin/common/di/dependencie_manager.config.dart';
import 'package:oplin/db/app_database.dart';
import 'package:oplin/db/dao/todo_dao.dart';
import 'package:oplin/db/models.dart';
import 'package:isar/isar.dart';
import 'package:oplin/db/models.dart';
import 'package:path_provider/path_provider.dart';

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
      schemas: [BookSchema, NoteSchema, TodoSchema],
      directory: (await getApplicationSupportDirectory()).path,
      inspector: true);

  @singleton
  Future<AppConfig> get appConfig async => await AppCubit.getDefaultConfig();

  @singleton
  TodoDao getTodoDao(AppDatabase database) => database.todoDao;
}
