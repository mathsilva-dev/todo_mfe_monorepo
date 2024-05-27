import 'package:flutter_test/flutter_test.dart';
import 'package:mfe_register/src/features/register/presenter/business/register_controller.dart';
import 'package:mfe_shared/mfe_shared.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late RegisterController controller;
  late ToDosUsecase toDosUsecase;

  var toDo = ToDoEntity(
      title: 'Test 1', description: 'Test Desc 1', isCompleted: false);

  setUp(() {
    toDosUsecase = ToDosUsecaseMock();
    controller = RegisterController(toDosUsecase);

    registerFallbackValue(toDo);
  });

  test(
    'Should RegisterController Save a ToDo inside a List in save method with correct values',
    () async {
      when(() => toDosUsecase.callSave(any(that: isA<ToDoEntity>())))
          .thenAnswer((_) async => (null, toDo));
      await controller.saveToDo();
      expect(controller.toDo, isA<ToDoEntity>());
    },
  );

  test(
    'Should RegisterController return a Exception in save method for any reason',
    () async {
      when(() => toDosUsecase.callSave(any(that: isA<ToDoEntity>())))
          .thenThrow(Exception());
      expectLater(() => controller.saveToDo(), throwsA(isA<Exception>()));
    },
  );
}

class ToDosUsecaseMock extends Mock implements ToDosUsecase {}
