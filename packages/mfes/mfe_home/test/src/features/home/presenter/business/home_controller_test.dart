import 'package:flutter_test/flutter_test.dart';
import 'package:mfe_home/src/features/home/presenter/business/home_controller.dart';
import 'package:mfe_shared/mfe_shared.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late HomeController controller;
  late ToDosUsecase toDosUsecase;

  var toDo = ToDoEntity(
      title: 'Test 1', description: 'Test Desc 1', isCompleted: false);

  setUp(() {
    toDosUsecase = ToDosUsecaseMock();
    controller = HomeController(toDosUsecase);

    registerFallbackValue(toDo);
  });

  test(
    'Should HomeController return a ToDo List in fetch method with correct values',
    () async {
      var toDosList = [
        ToDoEntity(
            title: 'Test 1', description: 'Test Desc 1', isCompleted: false),
        ToDoEntity(
            title: 'Test 2', description: 'Test Desc 2', isCompleted: true),
        ToDoEntity(
            title: 'Test 3', description: 'Test Desc 3', isCompleted: true),
      ];

      when(() => toDosUsecase.callFetchAll())
          .thenAnswer((_) async => (null, toDosList));
      await controller.fetchAll();
      expect(controller.toDos.value, toDosList);
    },
  );

  test(
    'Should HomeController return a Exception in fetch method for any reason',
    () async {
      when(() => toDosUsecase.callFetchAll()).thenThrow(Exception());
      expectLater(() => controller.fetchAll(), throwsA(isA<Exception>()));
    },
  );

  test(
    'Should HomeController complete a ToDo in complete method',
    () async {
      var toDosList = [
        toDo,
        ToDoEntity(
            title: 'Test 2', description: 'Test Desc 2', isCompleted: true),
        ToDoEntity(
            title: 'Test 3', description: 'Test Desc 3', isCompleted: true),
      ];

      when(() => toDosUsecase.callFetchAll())
          .thenAnswer((_) async => (null, toDosList));
      when(() => toDosUsecase.callDelete(toDo))
          .thenAnswer((_) async => (null, toDo));
      when(() => toDosUsecase.callSave(any(that: isA<ToDoEntity>())))
          .thenAnswer((_) async => (null, toDo.copyWith(isCompleted: true)));
      await controller.fetchAll();
      await controller.completeToDo(toDo, true);
      expect(
        controller.toDos.value,
        toDosList..replaceRange(0, 1, [toDo.copyWith(isCompleted: true)]),
      );
    },
  );

  test(
    'Should HomeController remove a ToDo in delete method',
    () async {
      var toDosList = [
        toDo,
        ToDoEntity(
            title: 'Test 2', description: 'Test Desc 2', isCompleted: true),
        ToDoEntity(
            title: 'Test 3', description: 'Test Desc 3', isCompleted: true),
      ];

      when(() => toDosUsecase.callDelete(toDo))
          .thenAnswer((_) async => (null, toDo));
      when(() => toDosUsecase.callFetchAll())
          .thenAnswer((_) async => (null, toDosList));
      await controller.fetchAll();
      await controller.deleteToDo(toDo);
      expect(controller.toDos.value, toDosList..remove(toDo));
    },
  );
}

class ToDosUsecaseMock extends Mock implements ToDosUsecase {}
