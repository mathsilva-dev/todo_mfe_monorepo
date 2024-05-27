import '../../domain/entities/to_do_entity.dart';

abstract class ToDosDatasource {
  Future<void> save(ToDoEntity toDo);
  Future<List<ToDoEntity>> fetchAll();
  Future<void> delete(ToDoEntity toDo);
}
