import '../../domain/entities/to_do_entity.dart';
import '../../domain/errors/failure.dart';
import '../../domain/repositories/to_dos_repository.dart';
import '../datasources/to_dos_datasource.dart';
import '../errors/to_dos_failure.dart';

class ToDosRepositoryI implements ToDosRepository {
  final ToDosDatasource _datasource;
  ToDosRepositoryI(this._datasource);

  @override
  Future<(Failure?, List<ToDoEntity>?)> fetchToDos() async {
    try {
      final toDos = await _datasource.fetchAll();
      return (null, toDos);
    } on Exception {
      return (
        ToDosFailure(
          message: 'Error fetching ToDos',
          attributes: {'stackTrace': StackTrace.current},
        ),
        null
      );
    }
  }

  @override
  Future<(Failure?, ToDoEntity)> saveToDo(ToDoEntity toDoEntity) async {
    try {
      await _datasource.save(toDoEntity);
      return (null, toDoEntity);
    } on Exception {
      return (
        ToDosFailure(
          message: 'Error saving ToDo',
          attributes: {'stackTrace': StackTrace.current},
        ),
        toDoEntity
      );
    }
  }

  @override
  Future<(Failure?, ToDoEntity)> deleteToDo(ToDoEntity toDoEntity) async {
    try {
      await _datasource.delete(toDoEntity);
      return (null, toDoEntity);
    } on Exception {
      return (
        ToDosFailure(
          message: 'Error deleting ToDo',
          attributes: {'stackTrace': StackTrace.current},
        ),
        toDoEntity
      );
    }
  }
}
