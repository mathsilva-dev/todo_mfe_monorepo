import 'package:mfe_shared/mfe_shared.dart';

class RegisterController {
  late final ToDosUsecase _toDosUsecase;
  RegisterController(this._toDosUsecase);

  ToDoEntity toDo = ToDoEntity.empty();

  Future<(ToDosFailure?, ToDoEntity)> saveToDo() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final result = await _toDosUsecase.callSave(toDo);
    if (result.$1 != null) return (result.$1! as ToDosFailure, toDo);
    return (null, toDo);
  }
}
