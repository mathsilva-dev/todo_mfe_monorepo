import 'package:flutter/material.dart';
import 'package:mfe_shared/mfe_shared.dart';

class HomeController {
  final ToDosUsecase _toDosUsecase;
  HomeController(this._toDosUsecase);

  ValueNotifier<List<ToDoEntity>> toDos = ValueNotifier([]);

  Future<void> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 200));
    final result = await _toDosUsecase.callFetchAll();
    if (result.$2 != null) toDos.value = result.$2!;
  }

  Future<(ToDosFailure?, bool)> completeToDo(
    ToDoEntity toDo,
    bool isCompleted,
  ) async {
    await Future.delayed(const Duration(milliseconds: 200));

    bool isDeleted = (await deleteToDo(toDo)).$2;
    if (!isDeleted) {
      return (ToDosFailure(message: 'Error updating ToDo'), false);
    }

    final result =
        await _toDosUsecase.callSave(toDo.copyWith(isCompleted: isCompleted));
    if (result.$1 != null) return (result.$1! as ToDosFailure, false);
    toDos.value.add(toDo.copyWith(isCompleted: isCompleted));
    return (null, true);
  }

  Future<(ToDosFailure?, bool)> deleteToDo(ToDoEntity toDo) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final result = await _toDosUsecase.callDelete(toDo);
    if (result.$1 != null) return (result.$1! as ToDosFailure, false);
    toDos.value = toDos.value..remove(toDo);
    return (null, true);
  }
}
