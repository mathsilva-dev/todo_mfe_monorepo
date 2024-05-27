import '../entities/to_do_entity.dart';
import '../errors/failure.dart';

abstract class ToDosUsecase {
  Future<(Failure?, List<ToDoEntity>?)> callFetchAll();
  Future<(Failure?, ToDoEntity)> callSave(ToDoEntity toDoEntity);
  Future<(Failure?, ToDoEntity)> callDelete(ToDoEntity toDoEntity);
}
