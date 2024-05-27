import 'package:dependencies/dependencies.dart';

import 'domain/repositories/to_dos_repository.dart';
import 'domain/usecases/to_dos_usecase.dart';
import 'domain/usecases/to_dos_usecase_i.dart';
import 'external/datasources/to_dos_datasource_i.dart';
import 'infra/datasources/to_dos_datasource.dart';
import 'infra/repositories/to_dos_repository_i.dart';

class SharedModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<ToDosDatasource>(ToDosDatasourceI.new);
    i.addLazySingleton<ToDosRepository>(ToDosRepositoryI.new);
    i.addLazySingleton<ToDosUsecase>(ToDosUsecaseI.new);
  }
}
