import '../entities/to_do_entity.dart';
import '../errors/failure.dart';
import '../repositories/to_dos_repository.dart';
import 'to_dos_usecase.dart';

class ToDosUsecaseI implements ToDosUsecase {
  final ToDosRepository _repository;
  ToDosUsecaseI(this._repository);

  @override
  Future<(Failure?, List<ToDoEntity>?)> callFetchAll() async {
    return await _repository.fetchToDos();
  }

  @override
  Future<(Failure?, ToDoEntity)> callSave(ToDoEntity toDoEntity) async {
    return await _repository.saveToDo(toDoEntity);
  }

  @override
  Future<(Failure?, ToDoEntity)> callDelete(ToDoEntity toDoEntity) async {
    return await _repository.deleteToDo(toDoEntity);
  }
}
