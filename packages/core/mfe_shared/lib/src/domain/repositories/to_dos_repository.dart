import '../entities/to_do_entity.dart';
import '../errors/failure.dart';

abstract class ToDosRepository {
  Future<(Failure?, List<ToDoEntity>?)> fetchToDos();
  Future<(Failure?, ToDoEntity)> saveToDo(ToDoEntity toDoEntity);
  Future<(Failure?, ToDoEntity)> deleteToDo(ToDoEntity toDoEntity);
}
