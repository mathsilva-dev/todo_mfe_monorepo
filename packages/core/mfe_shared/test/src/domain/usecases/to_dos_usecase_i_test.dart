import 'package:flutter_test/flutter_test.dart';
import 'package:mfe_shared/mfe_shared.dart';
import 'package:mfe_shared/src/domain/usecases/to_dos_usecase_i.dart';
import 'package:mfe_shared/src/infra/repositories/to_dos_repository_i.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late ToDosUsecaseI toDosUsecase;
  late ToDosDatasource toDosDatasource;

  var toDo = ToDoEntity(
      title: 'Test 1', description: 'Test Desc 1', isCompleted: false);

  setUp(() {
    toDosDatasource = ToDosDatasourceMock();
    toDosUsecase = ToDosUsecaseI(ToDosRepositoryI(toDosDatasource));

    registerFallbackValue(toDo);
  });

  test(
    'Should UseCase return a ToDo List in fetch method with correct values',
    () async {
      var toDosList = [
        ToDoEntity(
            title: 'Test 1', description: 'Test Desc 1', isCompleted: false),
        ToDoEntity(
            title: 'Test 2', description: 'Test Desc 2', isCompleted: true),
        ToDoEntity(
            title: 'Test 3', description: 'Test Desc 3', isCompleted: true),
      ];

      when(() => toDosDatasource.fetchAll()).thenAnswer((_) async => toDosList);
      var response = await toDosUsecase.callFetchAll();
      expect(response, (null, toDosList));
    },
  );

  test(
    'Should UseCase return a Exception in fetch method for any reason',
    () async {
      when(() => toDosDatasource.fetchAll()).thenThrow(Exception());
      var response = await toDosUsecase.callFetchAll();
      expect(response.$1, isA<ToDosFailure>());
    },
  );

  test(
    'Should UseCase complete a ToDo in complete method',
    () async {
      var toDosList = [
        toDo,
        ToDoEntity(
            title: 'Test 2', description: 'Test Desc 2', isCompleted: true),
        ToDoEntity(
            title: 'Test 3', description: 'Test Desc 3', isCompleted: true),
      ];

      when(() => toDosDatasource.fetchAll()).thenAnswer((_) async => toDosList);
      when(() => toDosDatasource.delete(toDo)).thenAnswer((_) async => true);
      when(() => toDosDatasource.save(any(that: isA<ToDoEntity>())))
          .thenAnswer((_) async => true);
      await toDosUsecase.callFetchAll();
      await toDosUsecase.callDelete(toDo);
      await toDosUsecase.callSave(toDo);
      var response = await toDosUsecase.callFetchAll();
      expect(response, (
        null,
        toDosList..replaceRange(0, 1, [toDo.copyWith(isCompleted: true)])
      ));
    },
  );

  test(
    'Should UseCase remove a ToDo in delete method',
    () async {
      var toDosList = [
        toDo,
        ToDoEntity(
            title: 'Test 2', description: 'Test Desc 2', isCompleted: true),
        ToDoEntity(
            title: 'Test 3', description: 'Test Desc 3', isCompleted: true),
      ];

      when(() => toDosDatasource.delete(toDo)).thenAnswer((_) async => true);
      when(() => toDosDatasource.fetchAll()).thenAnswer((_) async => toDosList);
      await toDosUsecase.callFetchAll();
      await toDosUsecase.callDelete(toDo);
      var response = await toDosUsecase.callFetchAll();
      expect(response, (null, toDosList..remove(toDo)));
    },
  );

  test(
    'Should UseCase Save a ToDo inside a List in save method with correct values',
    () async {
      when(() => toDosDatasource.save(toDo)).thenAnswer((_) async => true);
      var response = await toDosUsecase.callSave(toDo);
      expect(response, (null, toDo));
    },
  );

  test(
    'Should UseCase return a Exception in save method for any reason',
    () async {
      when(() => toDosDatasource.save(toDo)).thenThrow(Exception());
      var response = await toDosUsecase.callSave(toDo);
      expect(response.$1, isA<ToDosFailure>());
    },
  );
}

class ToDosDatasourceMock extends Mock implements ToDosDatasource {}
