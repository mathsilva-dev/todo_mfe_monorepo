import 'dart:convert';

import 'package:dependencies/dependencies.dart';

import '../../domain/entities/to_do_entity.dart';
import '../../infra/datasources/to_dos_datasource.dart';

class ToDosDatasourceI implements ToDosDatasource {
  @override
  Future<void> save(ToDoEntity toDo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    var currentToDos = prefs.getStringList('to_dos') ?? [];
    currentToDos.add(jsonEncode(toDo.toMap()));

    await prefs.setStringList('to_dos', currentToDos);
  }

  @override
  Future<List<ToDoEntity>> fetchAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    List<ToDoEntity> toDos = [];
    var currentToDos = prefs.getStringList('to_dos') ?? [];

    if (currentToDos.isNotEmpty) {
      toDos =
          currentToDos.map((e) => ToDoEntity.fromMap(jsonDecode(e))).toList();
    }

    return toDos;
  }

  @override
  Future<void> delete(ToDoEntity toDo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();

    var currentToDos = prefs.getStringList('to_dos') ?? [];
    var indexToDo =
        currentToDos.indexWhere((e) => e == jsonEncode(toDo.toMap()));
    currentToDos.removeAt(indexToDo);

    await prefs.setStringList('to_dos', currentToDos);
  }
}
